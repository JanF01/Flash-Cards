import Vue from "vue";
import Vuex from "vuex";

import { alert } from "./alert.module";
import { authentication } from "./authentication.module";
import { cardgroups } from "./cardgroups.module";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    newGroup: false,
    background: "main",
    signAction: "login",
    newAlert: false,
    editingGroup: false,
    groupForEdit: { title: "", id: 0, color: "#000000DF" },
  },
  actions: {
    changeEditingStatus({ commit }, data) {
      commit("changeEditingStatus", data);
    },
    changeCreatingStatus({ commit }, data) {
      commit("changeCreatingStatus", data);
    },
    changeBackground({ commit }, data) {
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
    changeEditingStatus(state, payload) {
      state.editingGroup = !state.editingGroup;
      setTimeout(() => {
        if (payload === null) {
          state.groupForEdit = { title: "", id: 0, color: "#000000DF" };
        } else state.groupForEdit = payload;
      }, 100);
    },
    changeCreatingStatus(state, payload) {
      state.newGroup = payload;
    },
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
    cardgroups,
  },
});
