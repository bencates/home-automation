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
   ** Customize the progress bar color
   */
  loading: {
    color: '#3B8070'
  },

  /*
   ** Build configuration
   */
  build: {

    /*
     ** Third-party dependencies
     */
    vendor: [
      '~~/deps/phoenix/priv/static/phoenix.js'
    ],

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