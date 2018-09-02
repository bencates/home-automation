<template>
  <div :class="['progress-input', { reverse, vertical }]">
    <progress :value="progressValue" :max="max" />

    <input type="range" :min="min" :max="max" :value="value" @input="handleInput" />
  </div>
</template>

<style scoped>
  .progress-input {
    --progress-input-width: 180px;
    --progress-input-height: 20px;

    position: relative;
    width: var(--progress-input-width);
    height: var(--progress-input-height);
  }

  .progress-input progress,
  .progress-input input {
    position: absolute;
    display: block;
    width: 100%;
    height: 100%;
  }

  .progress-input progress {
    appearance: none;
    background: inherit;
    border: 3px solid var(--room-font-color);
    border-radius: calc(var(--progress-input-width) / 2);
    padding: 3px;
  }
  .progress-input ::-webkit-progress-value {
    background: var(--room-accent-color);
    border-radius: calc((var(--progress-input-width) / 2) - 6px);
  }
  .progress-input ::-moz-progress-bar {
    background: var(--room-accent-color);
    border-radius: calc((var(--progress-input-width) / 2) - 6px);
  }

  .progress-input input {
    opacity: 0;
  }



  .reverse progress {
    transform: rotate(180deg);
  }



  .progress-input.vertical {
    --progress-input-width: 20px;
    --progress-input-height: 180px;
  }

  .vertical {
    width: var(--progress-input-width);
    height: var(--progress-input-height);
  }

  .vertical progress,
  .vertical input {
    width: var(--progress-input-height);
    height: var(--progress-input-width);
    transform:
      translateX(var(--progress-input-width))
      rotate(-90deg);
    transform-origin: top left;
  }



  .vertical.reverse input {
    transform:
      translateY(var(--progress-input-height))
      rotate(-90deg);
  }

  .vertical.reverse progress {
    transform:
      translateX(var(--progress-input-width))
      rotate(90deg);
  }
</style>

<script>
  export default {
    props: {
      min: { type: Number, default: 0 },
      max: { type: Number, default: 0 },
      value: { type: Number, required: true },

      reverse: { type: Boolean, default: false },
      vertical: { type: Boolean, default: false },
    },

    computed: {
      progressValue () {
        if (this.reverse) {
          return this.max - this.value
        } else {
          return this.value
        }
      }
    },

    methods: {
      handleInput (event) {
        this.$emit('change', Number(event.target.value))
      }
    }
  }
</script>
