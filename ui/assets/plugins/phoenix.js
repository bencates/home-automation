import Vue from 'vue'

import { Socket } from '~~/deps/phoenix/assets/js/phoenix.js'

export default ({ app, env }) => {
  const socket = new Socket(`${env.WS_SERVER}/socket`, { params: { userToken: "123" } })
  socket.connect()

  app.$socket = socket
}
