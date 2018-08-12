import { Socket } from '~~/deps/phoenix/assets/js/phoenix.js'

export const plugins = [
  store => {
    const socket = new Socket(`${process.env.WS_SERVER}/socket`, { params: { userToken: "123" } })

    socket.connect()

    const channel = socket.channel('store')

    channel.on('commit', mutation => store.commit(mutation))
    channel.on('dispatch', action => store.dispatch(action))

    store.$channel = channel

    channel.join()
      .receive("ok", ({messages}) => console.log("catching up", messages) )
      .receive("error", ({reason}) => console.log("failed join", reason) )
      .receive("timeout", () => console.log("Networking issue. Still waiting...") )
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
