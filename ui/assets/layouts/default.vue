<template>
  <div class="container" :data-room="$room">
    <button class="show" @click="$refs.theNavbar.show()">
      <font-awesome-icon icon="bars" />
    </button>

    <the-navbar ref="theNavbar" />

    <main class="content">
      <nuxt/>
    </main>
  </div>
</template>

<script>
  import TheNavbar from '~/components/the-navbar'

  import { mapState } from 'vuex'

  export default {
    components: { TheNavbar },

    computed: mapState(['$room'])
  }
</script>

<style>
  div.container {
    display: flex;
    flex-direction: row;

    min-height: 100vh;
  }

  main.content {
    background: var(--room-color);
    color: var(--room-font-color);

    flex: 1 0 auto;
  }

  button.show {
    position: absolute;
    background: transparent;
    color: var(--font-light);
    border: none;
  }
</style>
