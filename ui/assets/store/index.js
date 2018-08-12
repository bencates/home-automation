import phoenix from '~/plugins/store/phoenix'

export const plugins = [phoenix]

export function state () {
  return {
    socketConnected: false
  }
}

export const mutations = {
  socketConnect: state => state.socketConnected = true,
  socketDisconnect: state => state.socketConnected = false
}
