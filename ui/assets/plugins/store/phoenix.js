import { Socket } from '~~/deps/phoenix/assets/js/phoenix.js'
import { camelizeKeys, decamelize, decamelizeKeys } from 'humps'

export default function phoenix(store) {
  const socket = new Socket(`${process.env.WS_SERVER}/socket`, { params: { userToken: "123" } })

  socket.connect()

  const channel = socket.channel('store')

  channel.on('commit', mutation => store.commit(mutation))
  channel.on('dispatch', action => store.dispatch(action))

  channel.join()
    .receive("ok", ({messages}) => {
      store.commit('socketConnect')

      console.log("catching up", messages)
    })
    .receive("error", ({reason}) => console.log("failed join", reason) )
    .receive("timeout", () => console.log("Networking issue. Still waiting...") )

  channel.onError(() => store.commit('socketDisconnect'))

  store.$server = {
    $socket: socket,
    $channel: channel,

    async dispatch (type, payload = {}) {
      let action
      if (type !== null && typeof type === 'object' && type.type) {
        action = decamelizeKeys(type)
      } else {
        action = { type, ...decamelizeKeys(payload) }
      }
      action.type = decamelize(action.type)

      return await new Promise((resolve, reject) => {
        channel.push("dispatch", action)
          .receive("ok", response => resolve(camelizeKeys(response)))
          .receive("timeout", () => reject(new Error("timeout")))
      })
    }
  }
}
