import Vue from 'vue'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import { library } from '@fortawesome/fontawesome-svg-core'

import {
  faArrowLeft,
  faBars,
  faCaretDown,
  faCaretUp,
  faHome,
} from '@fortawesome/free-solid-svg-icons'

library.add(faArrowLeft)
library.add(faBars)
library.add(faCaretDown)
library.add(faCaretUp)
library.add(faHome)

Vue.component('font-awesome-icon', FontAwesomeIcon)
