<template>
  <nav :class="{ visible, navbar: true }">
    <button class="hide" @click="hide">
      <font-awesome-icon icon="arrow-left" />
    </button>

    <ul>
      <li>
        <nuxt-link class="category" to="/window">Windows</nuxt-link>
        <ul>
          <li v-for="(window, id) in windows" :key="id">
            <nuxt-link class="device" :to="`/window/${id}`">{{ window.name }}</nuxt-link>
          </li>
        </ul>
      </li>
    </ul>
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

    transform: translateX(-70vw);
    transition: transform 0.6s ease-in;
  }

  .navbar.visible {
    transform: translateX(0);
    transition: transform 0.6s ease-out;
  }

  button.hide {
    background: transparent;
    color: var(--font-light);
    border: none;
    width: 100%;
    font-size: 1.4rem;
    text-align: left;
    padding: 0.3rem 0.6rem;
  }

  ul {
    list-style: none;
    padding: 0;
  }

  a.category {
    display: block;
    background: var(--wood-dark);
    color: var(--font-light);
    text-decoration: none;

    font-size: 1.6rem;
    padding: 0.8rem;

    border: 1px solid black;
  }

  a.device {
    display: block;
    background: var(--wood-medium);
    color: var(--room-accent-color);
    text-decoration: none;

    font-size: 1.4rem;
    padding: 0.7rem 1.4rem;

    border: 1px solid black;
    border-top: none;
  }
</style>
