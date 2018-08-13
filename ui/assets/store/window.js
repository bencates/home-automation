
export function state () {
  {
    windows: [{
      id: 'den_window',
      name: 'Den Window',
      position: 0
    }]
  }
}

export const actions = {
  async setWindow (_context, payload) {
    return await this.$server.dispatch('set_window', payload)
  }
}
