import { throwAlert } from "../helpers";
export const alert = {
  namespaced: true,
  state: {
    type: null,
    message: null,
  },
  actions: {
    info({ commit }, message) {
      commit("info", message);
    },
    success({ commit }, message) {
      commit("success", message);
    },
    error({ commit }, message) {
      commit("error", message);
    },
    default({ commit }, message) {
      commit("default", message);
    },
    clear({ commit }) {
      commit("clear");
    },
  },
  mutations: {
    info(state, message) {
      state.type = "info";
      state.message = message;
      throwAlert(state.message, state.type, 3500, "top");
    },
    success(state, message) {
      state.type = "success";
      state.message = message;
      throwAlert(state.message, state.type, 3500, "top");
    },
    error(state, message) {
      state.type = "error";
      state.message = message;
      throwAlert(state.message, state.type, 3500, "top");
    },
    default(state, message) {
      state.type = "default";
      state.message = message;
      throwAlert(state.message, state.type, 3500, "top");
    },
    clear(state) {
      state.type = null;
      state.message = null;
      throwAlert(state.message, state.type, 3500, "top");
    },
  },
};
