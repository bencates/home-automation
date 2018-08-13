
export function state () {
  return {
    windows: {
      den: {
        id: 'den',
        name: 'Den Window',
        position: 0
      }
    }
  }
}

export const actions = {
  async setWindow (_context, payload) {
    return await this.$server.dispatch('set_window', payload)
  }
}
