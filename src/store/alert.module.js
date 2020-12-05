import { throwAlert } from "../helpers";
export const alert = {
  namespaced: true,
  state: {
    type: null,
    message: null,
  },
  actions: {
    success({ commit }, message) {
      commit("success", message);
    },
    error({ commit }, message) {
      commit("error", message);
    },
    clear({ commit }) {
      commit("clear");
    },
  },
  mutations: {
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
    clear(state) {
      state.type = null;
      state.message = null;
      throwAlert(state.message, state.type, 3500, "top");
    },
  },
};
