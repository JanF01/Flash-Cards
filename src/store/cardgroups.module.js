import { groupService } from "../services";

export const cardgroups = {
  namespaced: true,
  state: {
    offset: 0,
    emptyX: -1,
    emptyY: -1,
    groups: [[], [], [], [], [], [], [], [], [], []],
    addedNew: 0,
  },
  actions: {
    deleteCardGroup({ dispatch, state, commit }, data) {
      groupService.deleteGroup(data.id).then((response) => {
        if (response == "success") {
          commit("deleteCardGroup", { dispatch });
          state.groups[parseInt(data.x)].splice(parseInt(data.y), 1);

          for (let i = parseInt(data.y); i <= 9; i++) {
            if (typeof state.groups[parseInt(data.x)][i] !== "undefined") {
              state.groups[parseInt(data.x)][i].y =
                parseInt(state.groups[parseInt(data.x)][i].y) - 1;
            }
          }
          dispatch("moveCardGroups", state.groups);
          setTimeout(() => {
            dispatch("getCardGroups");
          }, 30);
        } else {
          dispatch(
            "alert/error",
            "There happened to be a confict while deleting the group",
            { root: true }
          );
        }
      });
    },
    editCardGroup({ dispatch, commit }, data) {
      groupService
        .editGroup(data.name, data.color, data.amount, data.id, data.owner)
        .then((response) => {
          if (response == "success") {
            commit("editCardGroup", { dispatch });
            dispatch("getCardGroups");
          } else {
            dispatch(
              "alert/error",
              "There happened to be a confict while editing the group",
              { root: true }
            );
          }
        });
    },
    createCardGroup({ dispatch, state, commit }, data) {
      if (state.emptyX != -1 && state.emptyY != -1) {
        groupService
          .createGroup(data.name, data.color, state.emptyX, state.emptyY)
          .then((response) => {
            if (response == "success") {
              commit("createCardGroup", { dispatch });
              dispatch("getCardGroups");
            } else {
              dispatch(
                "alert/error",
                "There happened to be a confict while creating the group",
                { root: true }
              );
            }
          });
      } else {
        dispatch("alert/error", "You have no more space for new groups", {
          root: true,
        });
      }
    },
    getCardGroups({ dispatch, commit }) {
      groupService.getGroups().then((response) => {
        if (response && response != "Błąd" && response != undefined) {
          commit("updateGroups", { dispatch, response });
        } else {
          dispatch("alert/error", "You have no card groups!", { root: true });
        }
      });
    },
    moveCardGroups({ dispatch, state }, columns) {
      console.log(state.groups);
      groupService.moveGroups(columns).then((response) => {
        if (!response || response != "success") {
          dispatch(
            "alert/error",
            "There was an conflict while trying to move the group!",
            { root: true }
          );
        } else {
          state.emptyX = -1;
          state.emptyY = -1;
          for (let i = 0; i < 10; i++) {
            for (let y = 0; y < 10; y++) {
              if (typeof state.groups[i][y] === "undefined") {
                state.emptyX = i;
                state.emptyY = y;
                break;
              }
            }
            if (state.emptyX != -1) {
              break;
            }
          }
        }
      });
    },
    moveRight({ dispatch, commit }) {
      commit("moveRight", { dispatch });
    },
    moveLeft({ dispatch, commit }) {
      commit("moveLeft", { dispatch });
    },
  },
  mutations: {
    deleteCardGroup(state, { dispatch }) {
      dispatch("alert/success", "The group has been deleted", {
        root: true,
      });
      dispatch("changeEditingStatus", null, {
        root: true,
      });
    },
    editCardGroup(state, { dispatch }) {
      dispatch("alert/success", "The group has been edited", {
        root: true,
      });
      dispatch("changeEditingStatus", null, {
        root: true,
      });
    },
    createCardGroup(state, { dispatch }) {
      dispatch("alert/success", "The group has been created", {
        root: true,
      });
      dispatch("changeCreatingStatus", false, {
        root: true,
      });
    },
    updateGroups(state, { dispatch, response }) {
      dispatch("alert/success", "Your card groups have been loaded", {
        root: true,
      });
      state.emptyX = -1;
      state.emptyY = -1;
      state.groups = [[], [], [], [], [], [], [], [], [], []];
      for (let i = 0; i < response.length; i++) {
        response[i].id = parseInt(response[i].id);
        response[i].amount = parseInt(response[i].amount);
        state.groups[response[i].x][response[i].y] = response[i];
      }

      console.log(state.groups);
      for (let i = 0; i < 10; i++) {
        for (let y = 0; y < 10; y++) {
          if (typeof state.groups[i][y] === "undefined") {
            state.emptyX = i;
            state.emptyY = y;
            break;
          }
        }
        if (state.emptyX != -1) {
          break;
        }
      }
    },
    moveRight(state, { dispatch }) {
      if (state.offset < 5) {
        console.log(state.offset);
        state.offset++;
      } else {
        dispatch("alert/error", "That's the limit", { root: true });
      }
    },
    moveLeft(state, { dispatch }) {
      if (state.offset > 0) {
        state.offset--;
      } else {
        dispatch("alert/error", "That's the first column already", {
          root: true,
        });
      }
    },
  },
};
