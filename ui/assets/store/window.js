
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

export const mutations = {
  setWindowPosition (state, { id, position }) {
    state.windows[id].position = position
  }
}

export const actions = {
  async setWindow ({ commit }, payload) {
    commit('setWindowPosition', payload)
    // return await this.$server.dispatch('set_window', payload)
  }
}
