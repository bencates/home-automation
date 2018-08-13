<template>
  <nav class="navbar">
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
    computed: {
      ...mapState('window', ['windows'])
    }
  }
</script>

<style scoped>
  ul {
    list-style: none;
    padding: 0;
  }

  a.category {
    display: block;
    background: #888;
    color: #333;
    text-decoration: none;

    font-size: 1.6rem;
    padding: 0.8rem;

    border: 1px solid black;
  }

  a.device {
    display: block;
    background: #AAA;
    color: #333;
    text-decoration: none;

    font-size: 1.4rem;
    padding: 0.7rem 1.4rem;

    border: 1px solid black;
    border-top: none;
  }
</style>
