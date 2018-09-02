<template>
  <section>
    <h1>{{ windowBlind.name }}</h1>

    <button class="up" @click="setPositionUp">
      <font-awesome-icon icon="caret-up" />
    </button>

    <button class="down" @click="setPositionDown">
      <font-awesome-icon icon="caret-down" />
    </button>

    <progress-input
      :min="0"
      :max="100"
      :reverse="true"
      :vertical="true"
      :value="windowBlind.position"
      @change="setPosition"
    />
  </section>
</template>

<style scoped>
  section {
    height: 100vh;

    display: grid;
    grid-template-rows: 6rem 1fr 1fr;
    grid-template-columns: 1fr 10rem 1fr;
    grid-template-areas:
      "header header header"
      ". up-button slider"
      ". down-button slider";

    align-items: center;
    justify-items: center;
  }

  h1 {
    grid-area: header;
    size: 4rem;
    color: var(--room-font-color);
  }

  button {
    color: var(--room-font-color);
    background: inherit;
    border: none;
    font-size: 10rem;
  }
  button:active {
    color: var(--room-accent-color);
  }

  button.up { grid-area: up-button }
  button.down { grid-area: down-button }

  .progress-input {
    grid-area: slider;

    --progress-input-height: 40vh !important;
  }
</style>

<script>
  import { mapState } from 'vuex'

  import ProgressInput from '~/components/progress-input'

  export default {
    components: { ProgressInput },

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
      setPositionUp () {
        this.$store.dispatch('window/setWindow', {
          id: this.$route.params.id,
          position: 100
        })
      },

      setPositionDown () {
        this.$store.dispatch('window/setWindow', {
          id: this.$route.params.id,
          position: 0
        })
      },

      setPosition (position) {
        this.$store.dispatch('window/setWindow', {
          id: this.$route.params.id,
          position
        })
      }
    }
  }
</script>
