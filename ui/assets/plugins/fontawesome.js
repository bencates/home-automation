import Vue from 'vue'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import { library } from '@fortawesome/fontawesome-svg-core'

import { faHome } from '@fortawesome/free-solid-svg-icons'

library.add(faHome)

Vue.component('font-awesome-icon', FontAwesomeIcon)
