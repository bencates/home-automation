import { Socket } from '~~/deps/phoenix/assets/js/phoenix.js'

export const plugins = [
  store => {
    const socket = new Socket(`${process.env.WS_SERVER}/socket`, { params: { userToken: "123" } })

    socket.connect()

    const channel = socket.channel('store')

    channel.on('commit', mutation => store.commit(mutation))
    channel.on('dispatch', action => store.dispatch(action))

    channel.join()
      .receive("ok", ({messages}) => console.log("catching up", messages) )
      .receive("error", ({reason}) => console.log("failed join", reason) )
      .receive("timeout", () => console.log("Networking issue. Still waiting...") )

    store.$server = {
      $socket: socket,
      $channel: channel,

      commit (type, payload = {}) {
        let mutation
        if (type !== null && typeof type === 'object' && type.type) {
          mutation = type
        } else {
          mutation = { type, ...payload }
        }

        channel.push("server_commit", mutation)
      },

      async dispatch (type, payload = {}) {
        let action
        if (type !== null && typeof type === 'object' && type.type) {
          action = type
        } else {
          action = { type, ...payload }
        }

        return await new Promise((resolve, reject) => {
          channel.push("server_dispatch", action)
            .receive("ok", resolve)
            .receive("timeout", () => reject(new Error("timeout")))
        })
      }
    }
  }
]

export const mutations = {
  log (_state, { message }) {
    console.log('Mutation: ' + message)
  }
}

export const actions = {
  log (_context, { message }) {
    console.log('Action: ' + message)
  }
}