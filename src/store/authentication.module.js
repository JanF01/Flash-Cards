import { userService } from "../services";
import { router } from "../helpers";

const user = JSON.parse(localStorage.getItem("user"));
const initialState = user
  ? { status: { loggedIn: true }, user }
  : { status: {}, user: null };

export const authentication = {
  namespaced: true,
  state: initialState,
  actions: {
    login({ dispatch, commit }, { username, password }) {
      commit("loginRequest", { username });

      userService.login(username, password).then(
        (user) => {
          if (user.token) {
            commit("loginSuccess", user);
            router.push("/panel");
          } else if (user == "Brak użytkownika") {
            dispatch("alert/error", "User doesn't exist", { root: true });
          } else if (user == "Błędne hasło") {
            dispatch("alert/error", "Incorrect password", { root: true });
          } else {
            dispatch("alert/error", user, { root: true });
          }
        },
        (error) => {
          commit("loginFailure", error);
          dispatch("alert/error", error, { root: true });
        }
      );
    },
    register({ dispatch, commit }, { username, password }) {
      commit("loginRequest", { username });

      userService.register(username, password).then(
        (user) => {
          if (user.token) {
            commit("loginSuccess", user);
            router.push("/panel");
          } else if (user == "Nazwa użytkownika zajęta") {
            dispatch("alert/error", "This username is already in use", {
              root: true,
            });
          } else {
            dispatch("alert/error", user, { root: true });
          }
        },
        (error) => {
          commit("loginFailure", error);
          dispatch("alert/error", error, { root: true });
        }
      );
    },
    logout({ commit }) {
      userService.logout();
      commit("logout");
    },
  },
  mutations: {
    loginRequest(state, user) {
      state.status = { loggingIn: true };
      state.user = user;
    },
    loginSuccess(state, user) {
      state.status = { loggedIn: true };
      state.user = user;
    },
    loginFailure(state) {
      state.status = {};
      state.user = null;
    },
    logout(state) {
      state.status = {};
      state.user = null;
    },
  },
};
