import Vue from "vue";
import App from "./App.vue";
import store from "./store";
import { router } from "./helpers";
import VueRouter from "vue-router";

import { library } from "@fortawesome/fontawesome-svg-core";
import {
  faAngleDown,
  faAngleDoubleRight,
  faAngleDoubleUp,
  faAngleDoubleLeft,
  faAngleDoubleDown,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import VueToast from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";

Vue.config.productionTip = false;

library.add(
  faAngleDown,
  faAngleDoubleRight,
  faAngleDoubleUp,
  faAngleDoubleLeft,
  faAngleDoubleDown
);

Vue.use(VueToast);
Vue.use(VueRouter);

Vue.component("font-awesome-icon", FontAwesomeIcon);

new Vue({
  el: "#app",
  router,
  store,
  render: (h) => h(App),
});
