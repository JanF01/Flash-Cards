import { flashcardService } from "../services";

export const flashcards = {
  namespaced: true,
  state: {
    group_id: 0,
    group_title: "",
    amount: -1,
    back: "",
    front: "",
    importance: 1,
    one_sided: 0,
    id: -1,
    list: [],
  },
  actions: {
    deleteFlashCard({ commit, state, dispatch }, data) {
      flashcardService
        .deleteFlashCard(state.list[data.id].id)
        .then((response) => {
          if (response == "success") {
            commit("deleteFlashCard", { dispatch });
            state.list.splice(data.id, 1);
          } else {
            dispatch(
              "alert/error",
              "There happened to be a conflict while deleting the card",
              { root: true }
            );
          }
        });
    },
    createFlashCard({ commit, dispatch }, data) {
      flashcardService
        .addFlashCard(
          data.group_id,
          data.front,
          data.back,
          data.importance,
          data.one_sided
        )
        .then((response) => {
          if (response == "success") {
            commit("createFlashCard", { dispatch });
          } else if (response == "empty card") {
            dispatch(
              "alert/error",
              "One of the sides is empty. Use one sided option if needed.",
              { root: true }
            );
          } else {
            dispatch(
              "alert/error",
              "There happened to be a conflict while creating the flashcard",
              { root: true }
            );
          }
        });
    },
    getFlashCards({ commit, dispatch }, data) {
      flashcardService.getFlashCards(data.group_id).then((response) => {
        if (response && response != "Błąd" && response != undefined) {
          commit("getFlashCards", response);
        } else {
          dispatch(
            "alert/error",
            "There happened to be a conflict while downloading the flashcards",
            { root: true }
          );
        }
      });
    },
    setValues({ commit }, data) {
      commit("setValues", data);
    },
  },
  mutations: {
    deleteFlashCard(state, { dispatch }) {
      dispatch("alert/info", "Flashcard deleted", {
        root: true,
      });
    },
    getFlashCards(state, data) {
      state.list = [];
      state.list = data;
    },
    createFlashCard(state, { dispatch }) {
      dispatch("alert/success", "The flashcard has been created", {
        root: true,
      });
      dispatch(
        "flashcards/getFlashCards",
        { group_id: state.group_id },
        { root: true }
      );
    },
    setValues(state, payload) {
      state.group_id = payload.group_id;
      state.group_title = payload.group_title;
      state.amount = payload.amount;
      state.back = payload.back;
      state.front = payload.front;
      state.importance = payload.importance;
      state.one_sided = payload.one_sided;
      state.id = payload.id;
    },
  },
};
