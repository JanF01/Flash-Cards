<template>
  <div id="revise">
    <div class="fake-textarea">
      {{ content }}
    </div>
    <div class="buttons" v-if="end">
      <button v-on:click="isHard">Hard</button>
      <button v-on:click="isOk">OK</button>
      <button v-on:click="isEasy">Easy</button>
    </div>
    <div class="buttons" v-if="!end">
      <button v-on:click="showAnswer" class="show">
        Show Answer
      </button>
    </div>
  </div>
</template>

<script>
import { flashcardService } from "../services";
export default {
  name: "ReviseCard",
  data: () => {
    return {
      content: "",
      end: false,
      list: [],
      id: 0,
    };
  },
  methods: {
    setUpFlashCard() {
      if (typeof this.list[this.id] !== "undefined") {
        this.content = this.list[this.id].front;
        if (parseInt(this.list[this.id].one_sided)) {
          this.end = true;
        }
      } else {
        this.$store.dispatch("changeReviseStatus", false);
      }
    },
    showAnswer() {
      this.content = this.list[this.id].back;
      this.end = true;
    },
    isEasy() {
      flashcardService
        .updateFlashCard(
          this.list[this.id].id,
          0,
          this.list[this.id].seconds,
          this.list[this.id].importance
        )
        .then((response) => {
          if (response && response == "success") {
            this.id++;
            this.end = false;
            this.setUpFlashCard();
          } else {
            this.$store.dispatch(
              "alert/error",
              "There happened to be a conflict while reviewing the flashcard"
            );
          }
        });
    },
    isOk() {
      flashcardService
        .updateFlashCard(
          this.list[this.id].id,
          1,
          this.list[this.id].seconds,
          this.list[this.id].importance
        )
        .then((response) => {
          if (response && response == "success") {
            this.id++;
            this.end = false;
            this.setUpFlashCard();
          } else {
            this.$store.dispatch(
              "alert/error",
              "There happened to be a conflict while reviewing the flashcard"
            );
          }
        });
    },
    isHard() {
      flashcardService
        .updateFlashCard(
          this.list[this.id].id,
          2,
          this.list[this.id].seconds,
          this.list[this.id].importance
        )
        .then((response) => {
          if (response && response == "success") {
            this.id++;
            this.end = false;
            this.setUpFlashCard();
          } else {
            this.$store.dispatch(
              "alert/error",
              "There happened to be a conflict while reviewing the flashcard"
            );
          }
        });
    },
  },
  mounted() {
    this.list = this.$store.state.flashcards.cardsToRevise;
    this.id = 0;
    this.setUpFlashCard();
  },
  components: {},
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
#revise {
  width: 100%;
  @include flexCenter();
  flex-direction: column;
  .fake-textarea {
    background: $white;
    width: 36%;
    height: 55vh;
    margin-top: 12vh;
    color: black;
    font-size: 1.2em;
    font-family: "Manrope", sans-serif;
    cursor: text;
    padding: 3%;
    @include flexCenter();
    @include noUserSelect();
  }
  .buttons {
    button {
      margin-left: 1.5em;
      &:before {
        display: none;
      }
      &:nth-child(1) {
        margin-left: 0;
        background: linear-gradient(
          180deg,
          $light_red 90%,
          rgb(255, 255, 255) 90.1%
        );
      }
      &:nth-child(2) {
        background: linear-gradient(
          180deg,
          #046096 90%,
          rgb(255, 255, 255) 90.1%
        );
      }
      &:nth-child(3) {
        background: linear-gradient(
          180deg,
          #128954 90%,
          rgb(255, 255, 255) 90.1%
        );
      }
      span {
        position: absolute;
        right: 0.2em;
        top: -0.24em;
        font-size: 3em;
      }
    }

    .show {
      margin-top: 3.5em;
    }
  }
}
</style>
