<template>
  <section>
    <h1>{{ windowBlind.name }}</h1>
    <input type="range" min="0" max="100" @change="setPosition" />
    <progress :value="windowBlind.position" max="100" />
  </section>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('window', {
        windowBlind (state) {
          const id = this.$route.params.id
          return state.windows[id]
        }
      })
    },

    methods: {
      setPosition (event) {
        this.$store.dispatch('window/setWindow', {
          id: this.$route.params.id,
          position: event.target.value
        })
      }
    }
  }
</script>
