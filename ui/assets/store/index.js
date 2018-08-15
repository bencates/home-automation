import phoenix from '~/plugins/store/phoenix'

export const plugins = [phoenix]

export function state () {
  return {
    socketConnected: false
  }
}

export const mutations = {
  socketDisconnect: state => state.socketConnected = false,

  patchState (state, patch) {
    console.log("patching state", patch)
    console.log("state", patch)

    function deepPatch (state, patch, key) {
      console.log("deep patching state", state, patch, key)
      switch (patch.changed) {
        case 'equal':
          return state

        case 'added':
          state[key] = patch.value
          return state

        case 'removed':
          delete(state[key])
          return state

        case 'primitive_change':
          return patch.added

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
