<template>
  <div class="container">
    <aside class="navbar">
      <the-navbar />
    </aside>

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
html {
  box-sizing: border-box;
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

aside.navbar {
  background: #666;
  color: #333;

  width: 300px;
}

main.content {
  background: #333;
  color: #CCC;

  flex: 1 0 auto;
}
</style>

