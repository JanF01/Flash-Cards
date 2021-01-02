<template>
  <div id="panel">
    <div
      class="pomodoroPopup"
      v-on:click="goToPomodoro"
      v-bind:class="{ changeColor: this.$store.state.background == 'pomodoro' }"
    >
      <div class="squares" v-if="this.$store.state.background == 'pomodoro'">
        <div class="line">
          <div class="box"></div>
          <div class="box"></div>
        </div>
        <div class="line">
          <div class="box"></div>
          <div class="box"></div>
        </div>
      </div>
      <span class="clock" v-if="this.$store.state.background != 'pomodoro'">
        <font-awesome-icon icon="stopwatch"></font-awesome-icon>
      </span>
    </div>
    <Navigation />
    <div v-if="!addingFlashCard && !reviseFlashCard">
      <draggable
        v-for="cardGroupColumn of cardGroupColumns.slice(
          this.$store.state.cardgroups.offset,
          this.$store.state.cardgroups.offset + 5
        )"
        :key="cardGroupColumn.id"
        :list="cardGroupColumn"
        tag="ul"
        group="columns"
        @end="moveEnd()"
        :animation="230"
        filter=".no-drag"
        ghost-class="moving-group"
        :move="checkMove"
      >
        <li v-for="cardgroup of cardGroupColumn" :key="cardgroup.id">
          <CardGroup
            v-bind:color="cardgroup.color"
            v-bind:title="cardgroup.name"
            v-bind:id="cardgroup.id"
            v-bind:owner="cardgroup.owner"
            v-bind:amount="cardgroup.amount"
            v-bind:pos_x="cardgroup.x"
            v-bind:pos_y="cardgroup.y"
          />
        </li>
      </draggable>
    </div>
    <AddGroup v-if="newGroup || editGroup" v-bind:edit="editGroup" />
    <AddFlashCard v-if="addingFlashCard" />
    <ReviseCard v-if="reviseFlashCard" />
    <Pomodoro v-if="this.$store.state.background == 'pomodoro'" />
  </div>
</template>

<script>
import Navigation from "./Navigation";
import CardGroup from "./CardGroup";
import AddGroup from "./AddGroup";
import AddFlashCard from "./AddFlashCard";
import ReviseCard from "./ReviseCard";
import Pomodoro from "../start/Pomodoro";
export default {
  name: "Panel",
  data: function() {
    return {
      drag: false,
      cardGroupColumns: [[], [], [], [], [], [], [], [], [], []],
      //   [[
      //     { id: 2, name: "Matematyka Geometria", color: "#123091CF" },
      //     { id: 3, name: "Matematyka Logarytmy", color: "#123091CF" },
      //     { id: 4, name: "Matematyka Potęgi", color: "#123091CF" },
      //     { id: 5, name: "Matematyka Funkcja Wykładnicza", color: "#227051CF" },
      //   ],
      //   [
      //     { id: 10, name: "Informatyka C++", color: "#227051CF" },
      //     { id: 11, name: "Matematyka Całki", color: "#227051CF" },
      //     { id: 12, name: "Matematyka I", color: "#123091CF" },
      //     { id: 13, name: "Matematyka II", color: "#227051CF" },
      //   ],
      //   [
      //     { id: 10, name: "Matematyka III", color: "#823021CF" },
      //     { id: 11, name: "Matematyka II", color: "#123091CF" },
      //     { id: 12, name: "Matematyka II", color: "#823021CF" },
      //     { id: 13, name: "Matematyka II", color: "#823021CF" },
      //   ],
      //   [
      //     { id: 19, name: "Matematyka II", color: "#823021CF" },
      //     { id: 29, name: "Matematyka II", color: "#329091CF" },
      //     { id: 132, name: "Matematyka II", color: "#329091CF" },
      //     { id: 242, name: "Matematyka II", color: "#329091CF" },
      //   ],
      //   [
      //     { id: 5555, name: "Matematyka III", color: "#823021CF" },
      //     { id: 124, name: "Matematyka II", color: "#123091CF" },
      //     { id: 123213, name: "Matematyka II", color: "#823021CF" },
      //     { id: 4444, name: "Matematyka II", color: "#823021CF" },
      //   ],
      //   [],
      //   [],
      //   [],
      //   [],
      //   [],
      // ],
    };
  },
  computed: {
    newGroup() {
      return this.$store.state.newGroup;
    },
    editGroup() {
      return this.$store.state.editingGroup;
    },
    addingFlashCard() {
      return this.$store.state.addingFlashCard;
    },
    reviseFlashCard() {
      return this.$store.state.revising;
    },
    offset() {
      return this.$store.state.cardgroups.offset;
    },
    columns() {
      return this.$store.state.cardgroups.groups;
    },
  },
  watch: {
    columns() {
      setTimeout(() => {
        this.cardGroupColumns = this.$store.state.cardgroups.groups;
      }, 70);
    },
  },
  components: {
    Navigation,
    CardGroup,
    AddGroup,
    AddFlashCard,
    ReviseCard,
    Pomodoro,
  },
  methods: {
    checkMove(e) {
      return e.to.children.length < 10;
    },
    moveEnd() {
      for (let i = 0; i < 10; i++) {
        for (let y = 0; y < this.cardGroupColumns[i].length; y++) {
          this.cardGroupColumns[i][y].x = i;
          this.cardGroupColumns[i][y].y = y;
        }
      }
      this.updateDatabase();
    },
    updateDatabase() {
      const { dispatch } = this.$store;
      dispatch("cardgroups/moveCardGroups", this.cardGroupColumns);
    },
    goToPomodoro() {
      if (this.$store.state.background != "pomodoro")
        this.$store.dispatch("changeBackground", "pomodoro");
      else this.$store.dispatch("changeBackground", "main");
    },
  },
  mounted() {
    const { dispatch } = this.$store;
    dispatch("cardgroups/getCardGroups");
    setTimeout(() => {
      this.cardGroupColumns = this.$store.state.cardgroups.groups;
    }, 100);
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
#panel {
  min-width: 100%;
  min-height: 240vh;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: #1a1a1d;

  .pomodoroPopup {
    position: fixed;
    bottom: 3.45em;
    left: -0.3em;
    height: 3em;
    width: 3.5em;
    padding: 0.2em 0.7em 0.2em 0.9em;
    background: $light_red;
    color: white;
    font-size: 1.15em;
    font-weight: 600;
    letter-spacing: 0.06em;

    &.changeColor {
      background: $v_light_red;
      z-index: 30;
    }
    .squares {
      display: flex;
      flex-direction: column;
      width: 84%;
      min-height: 95%;
      .line {
        @include flexCenter();
        min-width: 90%;
        min-height: 45%;
        .box {
          min-width: 40%;
          margin-left: 7%;
          background: white;
          min-height: 85%;
          margin-top: 10%;
        }
        &:nth-child(2) {
          margin-top: 3%;
        }
      }
    }
    .clock {
      font-size: 2.3em;
      margin-top: 0.1em;
      color: white;
      z-index: 1;
    }
    @include flexCenter();
    flex-direction: column;
    transition: all 0.2s;
    @include borderRadius(0.24em);
    &:hover {
      cursor: pointer;
      padding-left: 1.8em;
    }
  }
  Navigation {
    position: fixed;
    top: 0;
    left: 0;
  }
  @include sm {
    .reg {
      display: none;
      &.mobile {
        display: block;
      }
    }
  }

  ul {
    float: left;
    width: 18%;
    list-style-type: none;
    margin: 0;
    padding: 0;
    margin: 1%;
    margin-top: 3.5em;
    min-height: 230vh;
    @include bxl {
      width: 29%;
      margin: 2%;
      margin-top: 3.5em;
    }
    @include sm {
      width: 46%;
      margin: 2%;
      margin-top: 8em;
    }
  }
}
</style>

<style lang="scss">
.moving-group {
  filter: brightness(140%);
}
</style>
