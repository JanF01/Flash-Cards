<template>
  <div id="list">
    <div class="id">#{{ id + 1 }}</div>
    <div class="title" v-html="title"></div>
    <div class="edit">
      <span v-on:click="editFlashcard"
        ><font-awesome-icon icon="edit"></font-awesome-icon
      ></span>
      <span v-on:click="openDeletePopup"
        ><font-awesome-icon icon="trash"></font-awesome-icon
      ></span>
    </div>
    <DeletePopup v-if="deleting" v-bind:id="id" x="0" y="0" />
  </div>
</template>

<script>
import DeletePopup from "../DeletePopup";
export default {
  name: "ListElement",
  computed: {
    deleting() {
      return this.$store.state.deleting;
    },
  },
  props: {
    id: Number,
    title: String,
  },
  methods: {
    editFlashcard() {
      this.$store.dispatch("changeListStatus", false);
      this.$store.dispatch("flashcards/setValues", {
        card_id: this.id,
      });
      window.scrollTo(0, 0);
    },
    openDeletePopup() {
      this.$store.dispatch("flashcards/setValues", {
        group_title: this.$store.state.flashcards.group_title,
        group_id: this.$store.state.flashcards.group_id,
        amount: this.amount,
        back: "",
        front: "",
        importance: 1,
        one_sided: 0,
        id: -1,
      });
      this.$store.dispatch("changeDeletingStatus", { s: true, id: this.id });
    },
  },
  components: { DeletePopup },
};
</script>

<style scoped lang="scss">
@import "../../mixins/mixins.scss";
#list {
  display: flex;
  align-items: center;
  color: white;
  font-family: "Manrope", sans-serif;
  font-size: 1.1em;
  width: 37em;
  line-height: 1.7em;
  .id {
    min-width: 2em;
    text-align: center;
    border-bottom: solid 0.3em $dark_red;
    padding: 0.5em;
    background: $dark_red;
    margin-top: 1em;
  }
  .title {
    width: 27em;
    margin-top: 1em;
    letter-spacing: 0.01em;
    text-align: left;
    border-bottom: solid 0.3em $dark_red;

    padding: 0.5em;
    padding-left: 0.9em;
  }
  .edit {
    margin-left: 0.5em;
    margin-top: 0.5em;
    display: flex;
    span {
      font-size: 1.4em;
      display: block;
      margin-left: 0.6em;
      cursor: pointer;
      color: $white;
      transition: 0.16s all;
      &:hover {
        transform: scale(0.94);
      }
    }
  }
}
</style>
