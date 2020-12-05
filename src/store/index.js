import Vue from "vue";
import Vuex from "vuex";

import { alert } from "./alert.module";
import { authentication } from "./authentication.module";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    background: "main",
    signAction: "login",
    newAlert: false,
  },
  actions: {
    changeBackkground({ commit }, data) {
      commit("changeBackground", data);
    },
    changeSignAction({ commit }, data) {
      commit("changeSignAction", data);
    },
    newAlert({ commit }) {
      commit("newAlert");
    },
  },
  mutations: {
    changeBackground(state, payload) {
      state.background = payload;
    },
    changeSignAction(state, payload) {
      state.signAction = payload;
    },
    newAlert(state) {
      state.newAlert = true;
    },
  },
  modules: {
    alert,
    authentication,
  },
});
