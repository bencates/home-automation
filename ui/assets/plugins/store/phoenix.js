import { Socket } from '~~/deps/phoenix/assets/js/phoenix.js'
import { camelizeKeys, decamelize, decamelizeKeys } from 'humps'

export class TimeoutError extends Error {}

export default function phoenix(store) {
  const socket = new Socket(`${process.env.WS_SERVER}/socket`)

  // TODO: real authentication
  socket.connect({ userToken: "123" })

  const channel = socket.channel('store')

  channel.on('patch_state', patch => {
    store.commit('patchState', camelizeKeys(patch))
  })

  channel.onError(() => store.commit('socketDisconnect'))

  channel.join()
    .receive('ok', serverState => store.replaceState(camelizeKeys(serverState)))
    .receive('timeout', () => console.log('Networking issue. Still waiting...'))

  store.$serverDispatch = async (type, payload = {}) => {
    const action = { ...decamelizeKeys(payload), type: decamelize(type) }

    return await new Promise((resolve, reject) => {
      channel.push('dispatch', action)
        .receive('ok', response => resolve(camelizeKeys(response)))
        // FIXME: receive "error"
        .receive('timeout', () => reject(new TimeoutError('timeout')))
    })
  }
}
