<template>
  <div id="addflash">
    <p><img src="../assets/list.png" /> {{ title }}</p>
    <div class="switch" v-on:click="switchSide" v-if="!list">
      <span>ONE SIDED</span>
      <div class="ball"></div>
    </div>
    <div class="sides" v-if="!list">
      <div class="front">
        <div class="fake-textarea" v-on:click="focusOnArea('tx1')">
          <span v-on:click="question = ''"
            ><font-awesome-icon icon="eraser"></font-awesome-icon
            ><strong>ERASE</strong></span
          >
          <textarea
            id="tx1"
            v-bind:placeholder="oneside ? 'Content' : 'Question'"
            v-model="question"
            @input="autoGrow($event)"
          ></textarea>
        </div>
      </div>
      <div class="back" v-if="!oneside">
        <div class="fake-textarea" v-on:click="focusOnArea('tx2')">
          <span v-on:click="answer = ''"
            ><font-awesome-icon icon="eraser"></font-awesome-icon
            ><strong>ERASE</strong></span
          >
          <textarea
            id="tx2"
            placeholder="Answer"
            v-model="answer"
            @input="autoGrow($event)"
          ></textarea>
        </div>
      </div>
    </div>
    <div class="buttons" v-if="!list">
      <button class="confirm" v-on:click="createFlashCard" v-if="!edit">
        Add Flash Card
      </button>

      <button class="save" v-if="edit">Save Flash Card</button>
    </div>
    <div class="list">
      <FlashCardList v-if="list" />
    </div>
  </div>
</template>

<script>
import FlashCardList from "./List/FlashCardList";
export default {
  name: "AddFlashCard",
  data: () => {
    return {
      question: "",
      answer: "",
      imp: 1,
      oneside: 0,
      card_id: -1,
      edit: false,
      list: false,
    };
  },
  methods: {
    autoGrow(e) {
      e.target.style.height = "5px";
      e.target.style.height = e.target.scrollHeight + "px";
    },
    focusOnArea(id) {
      document.getElementById(id).focus();
    },
    switchSide() {
      if (!this.oneside) {
        document.getElementsByClassName("ball")[0].style.left = "3.3em";
        document.getElementsByClassName("ball")[0].style.background =
          "rgba(255,255,255,0.6)";
      } else {
        document.getElementsByClassName("ball")[0].style.left = "0";
        document.getElementsByClassName("ball")[0].style.background =
          "rgba(0, 0, 0, 0.678)";
      }
      this.oneside = !this.oneside;
    },
    createFlashCard() {
      const { dispatch } = this.$store;

      dispatch("flashcards/createFlashCard", {
        group_id: this.group_id,
        front: this.question,
        back: this.answer,
        importance: this.imp,
        one_sided: this.oneside,
      });
    },
  },
  computed: {
    title() {
      return this.$store.state.flashcards.group_title;
    },
    group_id() {
      return this.$store.state.flashcards.group_id;
    },
    amount() {
      return this.$store.state.flashcards.amount;
    },
    back() {
      return this.$store.state.flashcards.back;
    },
    front() {
      return this.$store.state.flashcards.front;
    },
    importance() {
      return this.$store.state.flashcards.importance;
    },
    one_sided() {
      return this.$store.state.flashcards.one_sided;
    },
    id() {
      return this.$store.state.flashcards.id;
    },
    checkingList() {
      return this.$store.state.flashcards.list;
    },
  },
  watch: {
    back(newValue) {
      this.answer = newValue;
    },
    front(newValue) {
      this.question = newValue;
    },
    importance(newValue) {
      this.imp = newValue;
    },
    one_sided(newValue) {
      this.oneside = newValue;
    },
    id(newValue) {
      this.card_id = newValue;
    },
    checkingList(newValue) {
      this.list = newValue;
    },
  },
  components: { FlashCardList },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
#addflash {
  @include flexCenter();
  flex-direction: column;
  width: 100%;
  p {
    color: white;
    font-family: "Manrope", sans-serif;
    width: 15em;
    position: relative;
    right: 29.8%;
    bottom: 3em;
    text-align: center;
    padding: 1em 0 1em 0em;
    margin-top: 9.7vh;
    background: $dark_red;
  }
  .switch {
    position: absolute;
    top: 84vh;
    left: 14%;
    background: $dark_red;
    @include borderRadius(0.05em);
    width: 6em;
    height: 1.8em;
    padding: 0.3em;
    color: rgb(224, 224, 224);
    z-index: 1;
    @include noUserSelect();
    cursor: pointer;
    span {
      font-size: 0.95em;
      font-weight: 600;
      letter-spacing: 0.05em;
      display: block;
      width: 100%;
      height: 100%;
      @include flexCenter();
      z-index: 20;
    }
    .ball {
      @include borderRadius(0.1em);
      background: rgba(0, 0, 0, 0.678);
      width: 3.3em;
      height: 2.5em;
      position: absolute;
      top: 0em;
      left: 0em;
      z-index: -1;
      transition: all 0.2s;
    }
  }
  .sides {
    width: 90%;
    margin-left: 3.7%;
    display: flex;
    justify-content: center;
    .front,
    .back {
      margin: 0;
      margin-top: 0vh;
      width: 45em;
      float: left;

      .fake-textarea {
        background: $white;
        width: 90%;
        height: 65vh;
        position: relative;
        cursor: text;
        @include flexCenter();
        span {
          position: absolute;
          bottom: -0.67em;
          right: 0.3em;
          font-size: 2.8em;
          display: flex;
          flex-direction: column;
          strong {
            font-size: 0.4em;
            color: $white;
            margin-top: 0.3em;
            font-weight: 500;
            letter-spacing: 0.05em;
          }

          transition: all 0.2s;
          cursor: pointer;
          &:hover {
            transform: scale(0.93);
          }
        }
        textarea {
          resize: none;
          overflow: hidden;
          min-height: 50px;
          max-height: 100%;
          width: 100%;
          outline: none;
          font-size: 1.2em;
          border: none;
          font-family: "Manrope", sans-serif;
          background: $white;
          font-size: 1.15em;
          text-align: center;
        }
      }
    }
  }
  .buttons {
    margin-top: 5vh;
  }
}
</style>
