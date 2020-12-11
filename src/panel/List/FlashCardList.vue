<template>
  <div id="list">
    <ListElement
      v-for="(flashcard, index) of cards"
      :key="index"
      v-bind:title="getShortenedTitle(flashcard)"
      v-bind:id="index"
    />
  </div>
</template>

<script>
import ListElement from "./ListElement";
export default {
  name: "FlashcardList",
  data: () => {
    return {
      cards: [],
    };
  },
  computed: {
    list() {
      return this.$store.state.flashcards.list;
    },
  },
  watch: {
    list(newValue) {
      this.cards = newValue;
    },
  },
  methods: {
    getShortenedTitle(flashcard) {
      let frontsub = flashcard.front.substr(0, 50);
      let backsub = flashcard.back.substr(0, 50);

      return flashcard.front.length > 0
        ? frontsub == flashcard.front
          ? frontsub
          : frontsub + "..."
        : backsub == flashcard.back
        ? backsub
        : backsub + "...";
    },
  },
  mounted() {
    this.cards = this.$store.state.flashcards.list;
  },
  components: { ListElement },
};
</script>

<style scoped lang="scss">
.list {
  margin-top: 15vh;
  min-width: 100%;
  ListElement {
    min-width: 100%;
  }
}
</style>
