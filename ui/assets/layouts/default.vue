<template>
  <div class="container">
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

  export default {
    components: {
      TheNavbar
    }
  }
</script>

<style>
  :root {
    --wood-dark: hsl(26.47deg, 34%, 19.61%);
    --wood-medium: hsl(26.13deg, 34.44%, 64.71%);
    --wood-light: hsl(24.78deg, 74.19%, 87.84%);

    --font-light: gray(90);
    --font-dark: gray(12);

    /* FIXME: real colors */
    --den-color: blue;
    --den-accent-color: green;

    --room-color: gray(20);
    --room-font-color: var(--font-light);
    --room-accent-color: gray(85);
  }

  html {
    box-sizing: border-box;

    color: var(--font-dark);
  }

  *, *:before, *:after {
    box-sizing: border-box;
    margin: 0;
  }

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
