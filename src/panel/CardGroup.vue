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
      <div class="buton learn no-drag" v-on:click="openRevisingFlashCard">
        <div class="no-drag">
          Revise Flash Cards
        </div>
      </div>
      <div class="time no-drag">
        <div class="no-drag" v-if="!timestamp">
          {{ changingTime }}
        </div>
        <div class="no-drag bell" v-if="timestamp">
          <font-awesome-icon icon="bell" class="icon"></font-awesome-icon>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "CardGroup",
  data: () => {
    return {
      timeD: 0,
      timeH: 0,
      timeM: 0,
      timeS: 0,
      time: "",
      timestamp: false,
      interval: null,
    };
  },
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
    changingTime() {
      return this.time;
    },
    soon() {
      return this.$store.getters["flashcards/getSoonest"]({
        group_id: this.id,
      });
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
      const { dispatch } = this.$store;
      dispatch("flashcards/getFlashCards", {
        group_id: this.id,
      });

      this.$store.dispatch("changeAddingStatus", true);
      this.$store.dispatch("changeListStatus", false);
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
    addTime() {
      this.timeS--;
      if (this.timeS == -1 && this.timeM > 0) {
        this.timeM--;
        this.timeS = 59;
      } else if (this.timeS == -1 && this.timeH > 0) {
        this.timeH--;
        this.timeM = 59;
        this.timeS = 59;
      } else if (this.timeS == -1 && this.timeD > 0) {
        this.timeD--;
        this.timeH = 24;
        this.timeM = 59;
        this.timeS = 59;
      }

      let h = this.timeH;
      let m = this.timeM;
      let s = this.timeS;

      if (this.timeH < 10) {
        h = "0" + this.timeH;
      }
      if (this.timeM < 10) {
        m = "0" + this.timeM;
      }
      if (this.timeS < 10) {
        s = "0" + this.timeS;
      }

      this.time =
        this.timeD != 0
          ? this.timeD + ":" + h + ":" + m + ":" + s
          : this.timeH != 0
          ? h + ":" + m + ":" + s
          : m + ":" + s;
    },
    openRevisingFlashCard() {
      const { dispatch } = this.$store;
      dispatch("changeBeforeRevision", true);
      dispatch("flashcards/getFlashCards", {
        group_id: this.id,
      });
    },
    setTime(soon) {
      let dateArray = soon.last_check.split(" ");
      let dateParts = [dateArray[0].split("-"), dateArray[1].split(":")];

      let lastReview =
        new Date(
          dateParts[0][0],
          dateParts[0][1] - 1,
          dateParts[0][2],
          dateParts[1][0],
          dateParts[1][1],
          dateParts[1][2]
        ) / 1000;

      let now = new Date() / 1000;

      let time = Math.round(soon.seconds - (now - lastReview));

      this.timestamp = time < 0;

      var days = Math.floor(time / 86400);
      var hours = Math.floor(time / 3600);
      var minutes = Math.floor((time - hours * 3600) / 60);
      var seconds = time - hours * 3600 - minutes * 60;

      this.timeD = days;
      this.timeH = hours;
      this.timeM = minutes;
      this.timeS = seconds;

      if (hours < 10) {
        hours = "0" + hours;
      }
      if (minutes < 10) {
        minutes = "0" + minutes;
      }
      if (seconds < 10) {
        seconds = "0" + seconds;
      }

      this.time =
        this.timeD != 0
          ? days + ":" + hours + ":" + minutes + ":" + seconds
          : this.timeH != 0
          ? hours + ":" + minutes + ":" + seconds
          : minutes + ":" + seconds;

      clearInterval(this.interval);
      this.interval = setInterval(this.addTime, 1000);
    },
  },
  watch: {
    soon(newValue) {
      setTimeout(() => {
        this.setTime(newValue);
      }, 100);
    },
  },
  mounted() {
    setTimeout(() => {
      this.setTime(
        this.$store.getters["flashcards/getSoonest"]({
          group_id: this.id,
        })
      );
    }, 100);
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
  .time {
    position: absolute;
    top: 2.6em;
    right: 1em;
    font-size: 1.3em;
    width: 6em;
    text-align: right;
    .bell {
      font-size: 1.5em;
      .icon {
        animation: bellAnimation 2s infinite;
      }
    }
  }
}
</style>
