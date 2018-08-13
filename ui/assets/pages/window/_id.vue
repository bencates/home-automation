<template>
  <section>
    <h1>{{ window.name }}</h1>
    <progress :value="window.progress" max="100" />
  </section>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('window', {
        window (state) {
          const id = this.$route.params.id
          return state.windows[id]
        }
      })
    }
  }
</script>
