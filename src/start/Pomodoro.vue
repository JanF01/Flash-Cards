<template>
  <div class="pomodoro">
    <div class="sessions">
      <div
        class="ball"
        v-for="(session, index) of sessionsArray"
        :key="index"
        :style="{
          left: session.left,
          top: session.right,
        }"
      ></div>
    </div>
    <div class="main-timers">
      <div class="focus-time">
        <h3>FOCUS TIME</h3>
        <div class="picker">
          <input type="number" class="minutes" v-model="focusTime" />
          MINUTES
        </div>
        <div class="arrows">
          <img src="../assets/arrowup_yellow.png" v-on:click="focusHigher" />
          <img src="../assets/arrowdown_yellow.png" v-on:click="focusLower" />
        </div>
      </div>
      <div
        class="timer"
        v-on:click="
          () => {
            if (this.time == 0) this.startTime();
          }
        "
      >
        <span class="start" v-if="!session && !inBreak"
          >START<br />
          SESSION</span
        >
        <span class="start" v-if="session || inBreak"
          ><span v-if="session">SESSION</span>
          <span v-if="inBreak">BREAK</span>
          <br />
          {{ timeString }}
        </span>
      </div>
      <div class="break-time">
        <h3>BREAK TIME</h3>
        <div class="picker">
          <input type="number" class="minutes" v-model="breakTime" />
          MINUTES
        </div>
        <div class="arrows">
          <img src="../assets/arrowup_blue.png" v-on:click="breakHigher" />
          <img src="../assets/arrowdown_blue.png" v-on:click="breakLower" />
        </div>
      </div>
    </div>
    <div class="long-break">
      <h3>LONG BRAKE</h3>
    </div>
    <audio preload="auto" src="../assets/bell.wav"></audio>
  </div>
</template>

<script>
export default {
  name: "Pomodoro",
  data: () => {
    return {
      focusTime: 1,
      breakTime: 2,
      time: 0,
      timeH: 0,
      timeM: 0,
      timeS: 0,
      timeString: "",
      sessionsSinceStart: 0,
      sessionsArray: [],
      session: false,
      inBreak: false,
      interval: null,
      endAudio: null,
    };
  },
  methods: {
    startTime() {
      if (!this.session) {
        this.session = true;
        this.inBreak = false;
        this.time = this.focusTime * 60;
        this.sessionsSinceStart++;
        this.$cookie.set("sessionsAmount", this.sessionsSinceStart, 365);
      } else {
        this.session = false;
        this.inBreak = true;
        this.time = this.breakTime * 60;
      }

      var hours = Math.floor(this.time / 3600);
      var minutes = Math.floor((this.time - hours * 3600) / 60);
      var seconds = this.time - hours * 3600 - minutes * 60;

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

      this.timeString =
        this.timeH != 0
          ? hours + ":" + minutes + ":" + seconds
          : minutes + ":" + seconds;

      this.interval = setInterval(() => {
        this.addSeconds();
      }, 1000);
    },
    addSeconds() {
      this.timeS--;
      if (this.timeS == -1 && this.timeM > 0) {
        this.timeM--;
        this.timeS = 59;
      } else if (this.timeS == -1 && this.timeH > 0) {
        this.timeH--;
        this.timeM = 59;
        this.timeS = 59;
      }

      if (this.timeS <= -1) {
        this.endTime();
        return;
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

      this.timeString = this.timeH != 0 ? h + ":" + m + ":" + s : m + ":" + s;
    },
    endTime() {
      clearInterval(this.interval);
      this.endAudio.play();
      if (this.session) {
        this.startTime();
      } else {
        this.time = 0;
        this.session = false;
        this.inBreak = false;
      }
    },
    breakLower() {
      if (this.breakTime > 0) {
        this.breakTime--;
      }
      this.$cookie.set("breakTime", this.breakTime, 96);
    },
    breakHigher() {
      this.breakTime++;
      this.$cookie.set("breakTime", this.breakTime, 96);
    },
    focusLower() {
      if (this.focusTime > 0) {
        this.focusTime--;
      }
      this.$cookie.set("focusTime", this.focusTime, 96);
    },
    focusHigher() {
      this.focusTime++;
      this.$cookie.set("focusTime", this.focusTime, 96);
    },
  },
  mounted() {
    this.endAudio = document.getElementsByTagName("audio")[0];

    this.endAudio.volume = 0.3;

    let focus = this.$cookie.get("focusTime");
    let brek = this.$cookie.get("breakTime");
    let sessions = this.$cookie.get("sessionsAmount");
    if (focus === null) {
      this.focusTime = 30;
    } else {
      this.focusTime = focus;
    }

    if (brek === null) {
      this.breakTime = 10;
    } else {
      this.breakTime = brek;
    }

    if (sessions === null) {
      this.sessionsSinceStart = 0;
      this.sessionsArray.length = 0;
    } else {
      this.sessionsSinceStart = sessions;
      for (let i = 0; i < this.sessionsSinceStart.length; i++) {
        this.sessionsArray.push({
          left: Math.random() * 98 + "%",
          right: Math.random() * 98 + "%",
        });
      }
    }
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
.pomodoro {
  width: 100%;
  height: 100vh;
  position: absolute;
  top: 0;
  left: 0;
  background: $dark_red;
  font-family: "Manrope", sans-serif;
  color: white;

  .sessions {
    position: absolute;
    top: 84.5vh;
    left: 5%;
    width: 95%;
    height: 10vh;
    z-index: 10;
    .ball {
      position: absolute;
      z-index: 19;
      min-width: 1.3%;
      padding-top: 1.3%;
      @include borderRadius(50%);
      background: radial-gradient(
        rgba(107, 209, 12, 0.803) 10%,
        rgba(25, 218, 138, 0.784) 60%
      );
    }
  }
  @include flexCenter();
  h3 {
    position: absolute;
    top: 12%;
    left: 0;
    width: 100%;
    text-align: center;
    font-size: 1.05em;
    letter-spacing: 0.1em;
  }
  .main-timers {
    width: 60%;
    display: flex;
    align-items: center;
    z-index: 24;

    @include noUserSelect();
    .focus-time {
      border: white solid 0.4em;
      background: radial-gradient(
        rgba(130, 192, 16, 0.551),
        rgba(130, 192, 16, 0.321)
      );
      z-index: 24;
      width: 22.5%;
      padding-top: 22.5%;
      @include borderRadius(50%);
      position: relative;

      @include sm {
        width: 22vh;
        padding-top: 22vh;
      }
    }
    .timer {
      border: white solid 0.4em;
      background: $white;
      color: $dark_red;
      width: 48%;
      margin-left: calc(3.5% - 1.2em);
      padding-top: 48%;
      @include borderRadius(50%);
      position: relative;
      cursor: pointer;
      transition: all 0.2s;
      .start {
        position: absolute;
        top: 26.5%;
        font-weight: 800;
        left: 0;
        width: 100%;
        text-align: center;
        color: $dark_red;
        font-size: 4.8em;
        &.time {
          top: 38%;
        }
        @include bxl {
          font-size: 4.5em;
        }
        @include md {
          font-size: 3.9em;
        }
        @include sm {
          font-size: 2.9em;
          top: 29%;
        }
      }
      &:hover {
        transform: scale(0.94);
      }
      @include sm {
        margin-left: 0;
        margin-top: 3vh;
        width: 38vh;
        padding-top: 38vh;
      }
    }
    .break-time {
      border: white solid 0.4em;
      background: radial-gradient(
        rgba(26, 145, 182, 0.521),
        rgba(26, 145, 182, 0.321)
      );
      width: 22.5%;
      padding-top: 22.5%;
      @include borderRadius(50%);
      margin-left: calc(3.5% - 1.2em);
      position: relative;
      z-index: 24;
      .arrows {
        span {
          background: rgba(13, 123, 156, 0.575);
        }
      }
      @include sm {
        margin-left: 0;
        margin-top: 3vh;
        width: 22vh;
        padding-top: 22vh;
      }
    }
    .picker {
      position: absolute;
      width: 100%;
      top: 40%;
      left: 0;
      font-weight: 700;
      letter-spacing: 0.06em;
      @include flexCenter;
      .minutes {
        -moz-appearance: textfield;
        background: none;
        border: none;
        color: white;
        font-family: "Manrope", sans-serif;
        outline: none;

        width: 2.5em;
        font-weight: 800;
        margin-right: 0em;
        font-size: 1.2em;

        &::-webkit-outer-spin-button,
        &::-webkit-inner-spin-button {
          margin: 0;
          opacity: 0;
          pointer-events: none;
          -webkit-appearance: none;
          -webkit-events: none;
          background: black !important;
        }
      }
    }
    .arrows {
      position: absolute;
      width: 100%;
      top: 70%;
      left: 0;
      width: 100%;
      @include flexCenter();
      img {
        width: 44%;
        margin: 2%;
        transition: 0.19s all;
        &:hover {
          transform: scale(0.9);
          cursor: pointer;
        }
      }
    }
    @include sm {
      flex-direction: column;
    }
    @include md {
      width: 82%;
    }
    @include bxl {
      width: 75%;
    }
  }
  .long-break {
    position: absolute;
    left: 63%;
    top: 25%;
    width: 6%;
    @include borderRadius(100%);
    padding-top: 6%;
    background: radial-gradient(
      rgba(47, 26, 182, 0.644),
      rgba(47, 26, 182, 0.349)
    );
    border: white solid 0.3em;
    cursor: pointer;
    transition: 0.2s all;
    &:hover {
      transform: scale(0.9);
    }
    @include noUserSelect();
    h3 {
      height: 100%;
      width: 100%;
      top: -17%;
      left: 0;
      @include flexCenter();
    }
    @include bxl {
      width: 8%;
      padding-top: 8%;
      top: 19%;
      left: 66%;
    }
    @include md {
      width: 10%;
      padding-top: 10%;
      top: 20%;
      left: 67%;
    }
    @include sm {
      width: 12vh;
      padding-top: 12vh;
      top: 66vh;
      left: 71%;
    }
  }
}
</style>
