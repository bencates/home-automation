<template>
  <section class="container">
    <font-awesome-icon icon="home" :symbol="true" />

    <svg class="home-icon" viewBox="0 0 100 100">
      <use xlink:href="#fas-fa-home" filter="url(#inset-shadow)"></use>
      <filter id="inset-shadow" x="-50%" y="-50%" width="200%" height="200%">
        <feComponentTransfer in=SourceAlpha>
          <feFuncA type="table" tableValues="1 0" />
        </feComponentTransfer>
        <feGaussianBlur stdDeviation="3"/>
        <feOffset dx="0" dy="3" result="offsetblur"/>
        <feFlood flood-color="rgb(20, 0, 0)" result="color"/>
        <feComposite in2="offsetblur" operator="in"/>
        <feComposite in2="SourceAlpha" operator="in" />
        <feMerge>
          <feMergeNode in="SourceGraphic" />
          <feMergeNode />
        </feMerge>
      </filter>
    </svg>
  </section>
</template>

<style scoped>
  .container {
    min-height: 100vh;
    background: var(--charcoal);

    display: flex;
    justify-content: center;
    align-items: center;
  }

  svg.home-icon {
    color: var(--charcoal);
    filter: saturate(120%);
    width: 65%;
  }
</style>

