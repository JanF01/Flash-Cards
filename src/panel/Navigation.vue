<template>
  <div id="nav">
    <ul class="monitor">
      <div class="username" v-html="'Welcome, ' + userData.username"></div>
      <li class="plus" v-on:click="changeNewGroupState(true)">
        NEW FLASH CARD GROUP <span><font-awesome-icon icon="plus"/></span>
      </li>
      <div class="arrow left" v-on:click="moveColumnsLeft()">
        <font-awesome-icon icon="angle-left" />
      </div>
      <div class="arrow right" v-on:click="moveColumnsRight()">
        <font-awesome-icon icon="angle-right" />
      </div>
      <li>
        PROFILE
      </li>
      <li v-on:click="handleSubmit()">
        LOG OUT <font-awesome-icon icon="sign-out-alt" />
      </li>
    </ul>
    <ul class="mobile">
      <img
        src="../assets/logo.png"
        class="mobile-logo"
        v-on:click="changeNewGroupState(false)"
      />
      <div class="arrow left" v-on:click="moveColumnsLeft()">
        <font-awesome-icon icon="angle-left" />
      </div>
      <div class="arrow right" v-on:click="moveColumnsRight()">
        <font-awesome-icon icon="angle-right" />
      </div>
      <div
        class="menu-trigger"
        v-on:click="openMenu"
        v-bind:class="{ close: menuOpen }"
      >
        <div class="lin">
          <div class="line"></div>
          <div class="line"></div>
        </div>
        <div class="lin">
          <div class="line"></div>
          <div class="line"></div>
        </div>
      </div>
    </ul>
    <ul class="opened-menu" v-if="menuOpen">
      <li class="plus" v-on:click="changeNewGroupState(true)">
        NEW FLASH CARD GROUP <span><font-awesome-icon icon="plus"/></span>
      </li>
      <li v-on:click="menuOpen = false">
        PROFILE
      </li>
      <li v-on:click="handleSubmit()">
        LOG OUT <span><font-awesome-icon icon="sign-out-alt"/></span>
      </li>
    </ul>
  </div>
</template>

<script>
import { router } from "../helpers";
export default {
  name: "Navigation",
  data: () => {
    return {
      menuOpen: false,
    };
  },
  methods: {
    handleSubmit() {
      this.$store.dispatch("authentication/logout");
      this.menuOpen = false;
      router.push("/");
    },
    moveColumnsRight() {
      const { dispatch } = this.$store;
      dispatch("cardgroups/moveRight");
    },
    moveColumnsLeft() {
      const { dispatch } = this.$store;
      dispatch("cardgroups/moveLeft");
    },
    changeNewGroupState(bool) {
      this.menuOpen = false;
      this.$store.dispatch("changeCreatingStatus", bool);
    },
    openMenu() {
      this.menuOpen = !this.menuOpen;
    },
  },
  computed: {
    userData() {
      return this.$store.state.authentication.userData;
    },
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";

.username {
  position: fixed;
  top: 0.9em;
  left: 1.2em;
  color: white;
  font-family: "Manrope", sans-serif;
  font-size: 1em;
  font-weight: 700;
  @include noUserSelect();
}
.monitor,
.mobile {
  z-index: 20;
  display: flex;
  justify-content: flex-end;
  width: 100%;
  position: fixed;
  margin: 0;
  padding: 0;
  height: 3em;
  align-items: center;
  color: white;
  font-family: "Manrope", sans-serif;
  list-style-type: none;
  background: $dark_red;
  @include noUserSelect();
  li {
    letter-spacing: 0.03em;
    font-weight: 600;
    display: flex;
    align-items: center;
    cursor: pointer;
    justify-content: center;
    min-width: 6em;
    padding: 0 2em 0 2em;
    height: 100%;
    svg {
      margin-left: 0.5em;
      font-size: 1.3em;
    }
    &.plus {
      span {
        font-size: 1.2em;
      }
    }
    &:hover {
      background: $light_red;
    }
  }
  .arrow {
    width: 1.3em;
    font-size: 3em;
    height: 1.1em;
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    z-index: 20;
    @include borderRadius(0.1em);
    top: calc(100vh - 2.3em);
    &:before {
      content: "";
      position: absolute;
      top: 0;
      left: 0em;
      width: 100%;
      height: 100%;
      background: linear-gradient(to top right, white 26%, #ffffff00 27%);
      @include borderRadius(0.1em);
    }
    &.left {
      left: calc(100% - 4.6em);
      background: linear-gradient(to bottom right, white 26%, $v_light_red 27%);
      &:before {
        background: linear-gradient(to top right, white 26%, #ffffff00 27%);
      }
    }
    &.right {
      background: linear-gradient(to bottom left, white 26%, $v_light_red 27%);
      left: calc(100% - 2.5em);
      &:before {
        background: linear-gradient(to top left, white 26%, #ffffff00 27%);
      }
    }
    transition: all 0.2s;
    &:hover {
      cursor: pointer;
      transform: scale(0.96);
    }
  }

  &.monitor {
    @include sm {
      display: none;
    }
  }
  &.mobile {
    display: none;
    .arrow {
      font-size: 2.4em;
      top: calc(10vh - 0.3em);
      &.left {
        left: calc(100% - 3.55em);
      }
      &.right {
        left: calc(100% - 1.85em);
      }
    }
    img {
      position: fixed;
      top: 0.5em;
      left: calc(50% - 1.25em);
      width: 2.5em;
    }
    .menu-trigger {
      width: 2.3em;
      position: fixed;
      top: 0.3em;
      right: 1em;
      cursor: pointer;
      .line {
        width: 100%;
        height: 0.6em;
        background: white;
        margin-top: 0.4em;
      }
      .lin {
        display: flex;
        .line {
          width: 30%;
          margin-left: 10%;
          transition: all 0.3s;
        }
      }
      transition: all 0.3s;
      &.close {
        .lin {
          &:nth-child(1) {
            .line {
              &:nth-child(1) {
                transform: scale(1.4) rotate(45deg);
              }
              &:nth-child(2) {
                transform: scale(1.4) rotate(-45deg);
              }
            }
          }
          &:nth-child(2) {
            .line {
              &:nth-child(1) {
                transform: scale(1.4) rotate(-45deg);
              }
              &:nth-child(2) {
                transform: scale(1.4) rotate(45deg);
              }
            }
          }
        }
      }
    }
    @include sm {
      display: flex;
    }
  }
}
.opened-menu {
  z-index: 21;
  display: flex;
  flex-direction: column;
  width: 100%;
  list-style-type: none;
  position: fixed;
  top: 1.5em;
  left: 0;
  padding: 0;
  font-size: 1.2em;
  color: white;
  font-family: "Manrope", sans-serif;
  li {
    min-height: 5em;
    display: flex;
    align-items: center;
    background: $dark_red;
    justify-content: center;
    span {
      font-size: 1.2em;
      margin-left: 0.5em;
    }
    &:hover {
      background: $light_red;
    }
  }
}
</style>
