import { flashcardService } from "../services";

export const flashcards = {
  namespaced: true,
  state: {
    group_id: 0,
    group_title: "",
    amount: -1,
    saveBack: "",
    saveFront: "",
    back: "",
    front: "",
    importance: 1,
    one_sided: 0,
    id: -1,
    list: [],
    cardsToRevise: [],
    soonest: [],
  },
  getters: {
    getSoonest: (state) => (data) => {
      for (let i = 0; i < state.soonest.length; i++) {
        if (state.soonest[i].card_group_id == data.group_id) {
          return state.soonest[i];
        }
      }
    },
  },
  actions: {
    resetFlashCards({ commit, dispatch }, data) {
      flashcardService.resetFlashCards(data.group_id).then((response) => {
        if (response == "success") {
          commit("resetFlashCards", { dispatch });
        } else {
          dispatch(
            "alert/error",
            "There happened to be a conflict while reseting revision time",
            { root: true }
          );
        }
      });
    },
    getSoonest({ commit, dispatch }) {
      flashcardService.getSoonestCards().then((response) => {
        if (response && response != "Błąd") {
          commit("getSoonest", response);
        } else {
          dispatch(
            "alert/error",
            "There happened to be a conflict while getting cards",
            { root: true }
          );
        }
      });
    },
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
    editFlashCard({ commit, state, dispatch }, data) {
      flashcardService
        .editFlashCard(
          data.front,
          data.back,
          data.importance,
          data.one_sided,
          state.id
        )
        .then((response) => {
          if (response == "success") {
            commit("editFlashCard", { dispatch });
          } else if (response == "empty card") {
            dispatch(
              "alert/error",
              "One of the sides is empty. Use one sided option if needed.",
              { root: true }
            );
          } else {
            dispatch(
              "alert/error",
              "There happened to be a conflict while editing the flashcard",
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
    getFlashCards({ commit, dispatch, rootGetters }, data) {
      flashcardService.getFlashCards(data.group_id).then((response) => {
        if (response && response != "Błąd" && response != undefined) {
          commit("getFlashCards", { dispatch, response, rootGetters });
        } else {
          dispatch(
            "alert/error",
            "There happened to be a conflict while downloading the flashcards",
            { root: true }
          );
        }
      });
    },
    setValues({ commit, state }, data) {
      if (data.card_id != undefined) {
        if (state.id == -1) {
          state.saveBack = state.back;
          state.saveFront = state.front;
        }
        commit("setValues", {
          group_id: state.group_id,
          group_title: state.group_title,
          amount: state.amount,
          back: state.list[data.card_id].back,
          front: state.list[data.card_id].front,
          importance: state.list[data.card_id].importance,
          one_sided: parseInt(state.list[data.card_id].one_sided),
          id: state.list[data.card_id].id,
        });
      } else commit("setValues", data);
    },
  },
  mutations: {
    resetFlashCards(state, { dispatch }) {
      dispatch(
        "alert/success",
        "The revision time for this group has been set to now",
        {
          root: true,
        }
      );
    },
    getSoonest(state, response) {
      state.soonest = response;
    },
    deleteFlashCard(state, { dispatch }) {
      dispatch("alert/info", "Flashcard deleted", {
        root: true,
      });
    },
    getFlashCards(state, { dispatch, response, rootGetters }) {
      state.list = [];
      state.list = response;

      if (rootGetters["getRevising"]) {
        var dateArray = [];
        var dateParts = [];
        var now = new Date() / 1000;

        state.cardsToRevise = [];

        for (let i = 0; i < state.list.length; i++) {
          dateArray = state.list[i].last_check.split(" ");
          dateParts = [dateArray[0].split("-"), dateArray[1].split(":")];

          let secondsSince =
            new Date(
              dateParts[0][0],
              dateParts[0][1] - 1,
              dateParts[0][2],
              dateParts[1][0],
              dateParts[1][1],
              dateParts[1][2]
            ) / 1000;

          let delay = state.list[i].seconds;
          let difference = now - secondsSince;

          if (difference >= delay) state.cardsToRevise.push(state.list[i]);
        }

        if (state.cardsToRevise.length < 1) {
          dispatch("changeBeforeRevision", false, { root: true });
          dispatch(
            "alert/info",
            "Nothing to revise yet, you can force the revision in the settings",
            { root: true }
          );
        } else {
          dispatch("changeBeforeRevision", false, { root: true });
          dispatch("changeReviseStatus", true, { root: true });
        }
      }
    },
    editFlashCard(state, { dispatch }) {
      dispatch("alert/success", "The flashcard has been edited", {
        root: true,
      });
      dispatch(
        "flashcards/getFlashCards",
        { group_id: state.group_id },
        { root: true }
      );
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
      state.front = "";
      state.back = "";
    },
    setValues(state, payload) {
      state.group_id = payload.group_id;
      state.group_title = payload.group_title;
      state.amount = payload.amount;
      state.back = payload.back;
      state.front = payload.front;
      if (state.back.length < 1 && state.front.length < 1) {
        state.back = state.saveBack;
        state.front = state.saveFront;
      }

      state.importance = payload.importance;
      state.one_sided = payload.one_sided;
      state.id = payload.id;
    },
  },
};
