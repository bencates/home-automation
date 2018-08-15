
export function state () {
  return {
    windows: {
      den: {
        name: 'Den Window',
        position: 50
      }
    }
  }
}

export const actions = {
  async setWindow (_context, payload) {
    return await this.$server.dispatch('window/setWindow', payload)
  }
}
