<template>
  <div id="group">
    <div class="grupa" v-bind:style="{ background: color }">
      <p>
        {{ titleChanged }}
        <span v-on:click="openEditWindow">
          <font-awesome-icon icon="cog" class="no-drag"></font-awesome-icon>
        </span>
      </p>
      <div class="content no-drag">
        <div class="bot no-drag">ID:{{ id }}</div>
      </div>
      <div class="buton no-drag" v-on:click="openAddingFlashCard">
        <div class="no-drag">
          Add Flash Card
          <span>
            <font-awesome-icon icon="plus" class="no-drag"></font-awesome-icon>
          </span>
        </div>
      </div>
      <div class="buton learn no-drag">
        <div class="no-drag">
          Revise Flash Cards
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "CardGroup",
  props: {
    title: String,
    id: Number,
    color: String,
    owner: String,
    amount: Number,
    pos_x: String,
    pos_y: String,
  },
  computed: {
    titleChanged() {
      if (this.title.length > 24) {
        return this.title.substr(0, 24) + "...";
      } else {
        return this.title;
      }
    },
  },
  methods: {
    openEditWindow() {
      if (this.id != 0)
        this.$store.dispatch("changeEditingStatus", {
          id: this.id,
          title: this.title,
          color: this.color,
          owner: this.owner,
          amount: this.amount,
          x: this.pos_x,
          y: this.pos_y,
        });
    },
    openAddingFlashCard() {
      this.$store.dispatch("changeAddingStatus", true);
      this.$store.dispatch("flashcards/setValues", {
        group_title: this.title,
        group_id: this.id,
        amount: this.amount,
        back: "",
        front: "",
        importance: 1,
        one_sided: 0,
        id: -1,
      });
    },
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
.grupa {
  width: 100%;
  min-height: 20vh;
  color: white;
  font-family: "Manrope", sans-serif;
  margin-top: 1em;
  position: relative;
  box-shadow: 0em 0.4em 0.5em -0.25em rgb(0, 0, 0);
  p {
    height: 2em;
    margin: 0;
    padding: 0.5em;
    letter-spacing: 0.05em;
    font-size: 1em;
    background: $v_dark_red;
    display: flex;
    align-items: center;
    position: relative;
    cursor: -moz-grab;
    cursor: grab;
    span {
      font-size: 1.5em;
      position: absolute;
      right: 0.5em;
      top: 0.3em;
      cursor: pointer;
      display: block;
      transition: 0.19s all;
      &:hover {
        transform: scale(1.1) rotate(10deg);
        filter: brightness(140%);
      }
    }
  }
  .content {
    min-height: 80%;
    min-height: 15vh;
  }
  .bot {
    position: absolute;
    bottom: 0;
    right: 0;
    padding: 0.2em;
  }
  .buton {
    position: absolute;
    top: 3.3em;
    left: 0em;
    font-size: 1em;
    display: flex;
    align-items: center;
    div {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0.6em;
      cursor: pointer;
      background: $dark_red;
      transition: 0.2s all;
      &:hover {
        padding-left: 1.4em;
      }
      span {
        margin-left: 0.3em;
        text-shadow: 0.03em 0.03em 0.1em black;
      }
    }

    &.learn {
      top: 6.2em;
    }
  }
}
</style>
