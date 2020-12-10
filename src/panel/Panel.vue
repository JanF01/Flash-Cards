<template>
  <div id="panel">
    <Navigation />
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
    <AddGroup v-if="newGroup || editGroup" v-bind:edit="editGroup" />
  </div>
</template>

<script>
import Navigation from "./Navigation";
import CardGroup from "./CardGroup";
import AddGroup from "./AddGroup";
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
  components: { Navigation, CardGroup, AddGroup },
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
  background-image: url("../assets/backgroundStyle.png");
  background-repeat: repeat;

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
