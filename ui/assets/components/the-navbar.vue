<template>
  <nav :class="{ visible, navbar: true }">

    <section class="controls">
      <nuxt-link class="home" to="/">
        <font-awesome-icon icon="home" />
      </nuxt-link>

      <button class="hide" @click="hide">
        <font-awesome-icon icon="arrow-left" />
      </button>
    </section>

    <ul><li class="category">
      <h2>Windows</h2>

      <ul><li v-for="(window, id) in windows" class="device" :key="id">
        <nuxt-link class="device" :to="`/window/${id}`">
          {{ window.name }}
        </nuxt-link>
      </li></ul>
    </li></ul>

  </nav>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    data () {
      return { visible: true }
    },

    computed: {
      ...mapState('window', ['windows'])
    },

    methods: {
      show () { this.visible = true },
      hide () { this.visible = false }
    }
  }
</script>

<style scoped>
  .navbar {
    background: var(--wood-dark);

    position: absolute;

    width: 70vw;
    height: 100vh;
    z-index: 1;

    transform: translateX(-70vw);
    transition: transform 0.6s ease-in;
  }

  .navbar.visible {
    transform: translateX(0);
    transition: transform 0.6s ease-out;
  }



  .controls {
    color: var(--font-light);
    width: 100%;
    font-size: 1.4rem;
    text-align: left;
    padding: 0.3rem;

    display: flex;
    align-items: center;
  }

  .controls :matches(button, a) {
    background: inherit;
    color: inherit;
    font-size: inherit;
    border: none;
    display: inline block;
    margin: 0 0.3rem;
    padding: 0;
    text-align: right;
  }

  .controls .hide {
    flex-grow: 1;
  }



  ul {
    list-style: none;
    padding: 0;
  }

  li {
    padding: 0 0.6rem;
  }

  .category {
    color: var(--font-light);
  }

  .category h2 {
    display: block;
    background: var(--wood-dark);
    color: var(--font-light);
    text-decoration: none;

    font-size: 1.6rem;
    padding: 0;
  }

  a.device {
    display: block;
    color: var(--room-accent-color);
    text-decoration: none;

    font-size: 1.4rem;
  }
</style>
