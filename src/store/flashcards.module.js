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
  },
  actions: {
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
              "There happened to be a confict while creating the flashcard",
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
    createFlashCard(state, { dispatch }) {
      dispatch("alert/success", "The flashcard has been created", {
        root: true,
      });
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
