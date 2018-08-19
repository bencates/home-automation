module.exports = {

  /*
   ** Headers of the page
   */
  head: {
    title: 'home',
    meta: [{
        charset: 'utf-8'
      },
      {
        name: 'viewport',
        content: 'width=device-width, initial-scale=1'
      },
      {
        hid: 'description',
        name: 'description',
        content: 'Home automation control app'
      }
    ],
    link: [{
      rel: 'icon',
      type: 'image/x-icon',
      href: '/favicon.ico'
    }]
  },

  /*
   ** Runtime configuration for the app
   */
  env: {
    WS_SERVER: 'ws://localhost:4000'
  },

  /*
   ** Customize the progress bar color
   */
  loading: {
    color: '#3B8070'
  },

  plugins: [
    '~/plugins/fontawesome'
  ],

  /*
   ** Build configuration
   */
  build: {

    postcss: {
      plugins: {
        /* postcss-cssnext is deprecated and recommends switching to
         * postcss-preset-env */
        'postcss-cssnext': false,
        'postcss-preset-env': {
          stage: 2,
          features: {
            'nesting-rules': true
          }
        }
      }
    },

    /*
     ** Run ESLint on save
     */
    extend(config, {
      isDev,
      isClient
    }) {
      if (isDev && isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  },

  /*
   ** Nuxt root directory
   */
  srcDir: 'assets',

  /*
   ** Generate into Phoenix static directory
   */
  generate: {
    dir: 'priv/static'
  }
}
