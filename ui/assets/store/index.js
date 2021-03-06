import Vue from 'vue'
import phoenix from '~/plugins/store/phoenix'

export const plugins = [phoenix]

export function state () {
  return {
    $socketConnected: false,
    $room: false,
  }
}

export const mutations = {
  socketConnect: state => state.$socketConnected = true,
  socketDisconnect: state => state.$socketConnected = false,

  setRoom (state, { room }) {
    state.$room = room;
  },

  patchState (state, patch) {
    function deepPatch (state, patch, key) {
      switch (patch.changed) {
        case 'added':
          Vue.set(state, key, patch.value)
          return state

        case 'removed':
          delete(state[key])
          return state

        case 'primitive_change':
          return patch.value

        case 'map_change':
          Object.keys(patch.value).forEach(key => {
            state[key] = deepPatch(state[key], patch.value[key], key)
          })
          return state
      }
    }

    return deepPatch(state, patch, null)
  }
}
