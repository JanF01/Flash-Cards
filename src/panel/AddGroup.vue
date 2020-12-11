<template>
  <div id="addgroup">
    <div class="container">
      <h2>NAME</h2>
      <input type="text" v-model="name" maxlength="45" />
      <h2>COLOR</h2>
      <input
        type="color"
        style="width: 100px;height:100px;"
        @input="changeColor($event)"
        id="palet"
      />
      <CardGroup
        v-bind:color="color"
        v-bind:title="name"
        v-bind:id="id"
        v-bind:owner="owner"
        v-bind:amount="amount"
        class="card"
      />
      <button v-on:click="saveGroup()" v-if="edit">SAVE CHANGES</button>
      <button v-on:click="createGroup()" v-else>ADD GROUP</button>

      <span v-on:click="closeCreateGroup" class="shut">
        <font-awesome-icon icon="times" />
      </span>
      <span v-on:click="askForDelete" v-if="edit" class="trash">
        <font-awesome-icon icon="trash" />
        <br />
        D<br />
        E<br />
        L<br />
        E<br />
        T<br />
        E
      </span>
    </div>
    <DeletePopup
      v-if="deletingGroup"
      v-bind:id="id"
      v-bind:x="x"
      v-bind:y="y"
    />
  </div>
</template>

<script>
import CardGroup from "./CardGroup";
import DeletePopup from "./DeletePopup";
export default {
  name: "AddGroup",
  props: {
    edit: Boolean,
  },
  data: function() {
    return {
      color: "#000000",
      name: "",
      id: 0,
      owner: "0",
      amount: 0,
      x: 0,
      y: 0,
    };
  },
  computed: {
    groupForEdit() {
      return this.$store.state.groupForEdit;
    },
    deletingGroup() {
      return this.$store.state.deletingGroup;
    },
  },
  watch: {
    groupForEdit(newValue) {
      this.name = newValue.title;
      this.color = newValue.color;
      this.id = newValue.id;
      this.owner = newValue.owner;
      this.amount = newValue.amount;
      this.x = newValue.x;
      this.y = newValue.y;

      document.getElementById("palet").value = this.color.substr(0, 7);
    },
  },
  methods: {
    changeColor(event) {
      let color = event.target.value;
      color += "CF";
      this.color = color;
    },
    closeCreateGroup() {
      this.$store.dispatch("changeCreatingStatus", false);
      if (this.edit) {
        this.$store.dispatch("changeEditingStatus");
      }
    },
    createGroup() {
      const { dispatch } = this.$store;
      if (this.name.length < 1) {
        this.$store.dispatch("alert/error", "The title can't be empty");
      } else {
        dispatch("cardgroups/createCardGroup", {
          name: this.name,
          color: this.color,
        });
      }
    },
    saveGroup() {
      const { dispatch } = this.$store;
      if (this.name.length < 1) {
        this.$store.dispatch("alert/error", "The title can't be empty");
      } else {
        dispatch("cardgroups/editCardGroup", {
          name: this.name,
          color: this.color,
          id: this.id,
          owner: this.owner,
          amount: this.amount,
        });
      }
    },
    askForDelete() {
      this.$store.dispatch("changeDeletingStatus", true);
    },
  },
  components: { CardGroup, DeletePopup },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
#addgroup {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  min-height: 100vh;
  background: rgba(0, 0, 0, 0.4);
  .container {
    @include noUserSelect();
    width: 30em;
    min-height: 60vh;
    padding-bottom: 2em;
    position: fixed;
    top: 20vh;
    left: calc(50% - 15em);
    z-index: 20;
    background: linear-gradient(
      to bottom right,
      $dark_red 50%,
      $light_red 50.1%
    );

    .trash {
      font-size: 1.6em;
      position: absolute;
      top: 0.5em;
      left: 0.5em;
      color: $white;
      text-align: center;
      font-weight: 700;
      line-height: 1.25em;
      cursor: pointer;
      transition: 0.2s all;
      &:hover {
        transform: scale(0.9);
      }
    }
    @include borderRadius(0.2em);
    display: flex;
    flex-direction: column;
    align-items: center;
    h2 {
      color: white;
      font-family: "Manrope", sans-serif;
      font-size: 1.2em;
      letter-spacing: 0.1em;
    }
    input[type="text"] {
      border: none;
      padding: 0.5em;
      font-family: "Manrope", sans-serif;
      background: none;
      border-bottom: white solid 0.3em;
      width: 50%;
      outline: none;
      color: white;
    }

    .card {
      min-width: 60%;
      margin-top: 5%;
    }
    .shut {
      position: absolute;
      top: 2%;
      right: -1.8em;
      color: white;
      font-size: 1.8em;
      display: block;
      background: $light_red;
      padding: 0.3em 0.6em 0.3em 0.6em;
      display: flex;
      align-items: center;
      justify-content: flex-end;
      width: 0.7em;
      z-index: -1;
      transition: all 0.2s;
      &:hover {
        cursor: pointer;
        transform: scale(0.95);
        right: -1.6em;
      }
    }
    button {
      @include noAppearance();
      @include borderRadius(0.2em);
      border: none;
      font-family: "Manrope", sans-serif;
      font-size: 1em;
      letter-spacing: 0.07em;
      font-weight: 700;
      padding: 0.55em 0.9em 0.55em 0.9em;
      width: 14em;
      margin-top: 8%;
      color: white;
      position: relative;
      background: linear-gradient(
        180deg,
        $v_dark_red 90%,
        rgb(255, 255, 255) 90.1%
      );

      transition: all 0.2s;
      &:hover {
        filter: brightness(1.2);
        transform: scale(0.96);
      }
      &::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(
          220deg,
          rgb(175, 18, 57, 0) 87%,
          rgb(255, 255, 255) 87.8%
        );
      }

      cursor: pointer;
      @include sm {
        margin-top: 13%;
      }
    }

    @include xs {
      min-height: calc(100% - 3em);
      width: 100%;
      left: 0;
      top: 3em;
      padding-top: 1em;
    }
  }
}
</style>
