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
    // TODO: find a cleaner way to do this
    beforeRouteEnter (_to, _from, next) {
      next(({ $route, $store }) => {
        $store.commit('setRoom', { room: $route.params.id })
      })
    },

    beforeRouteUpdate (_to, _from, next) {
      this.$store.commit('setRoom', { room: this.$route.params.id })
      next()
    },

    beforeRouteLeave (_to, _from, next) {
      this.$store.commit('setRoom', { room: false })
      next()
    },

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
