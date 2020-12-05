<template>
  <div>
    <ul class="navigation">
      <img src="../assets/logo.png" v-on:click="backToMain()" />
      <li v-on:click="openMenu()" v-if="this.$store.state.background == 'main'">
        MENU
        <font-awesome-icon icon="angle-double-right" class="menu_arrow" />
        <font-awesome-icon icon="angle-double-up" class="menu_arrow_mobile" />
      </li>
      <li
        v-on:click="closeMenu()"
        v-if="this.$store.state.background == 'nav'"
        class="red"
      >
        <font-awesome-icon icon="angle-double-left" class="menu_arrow" />
        MENU
        <font-awesome-icon icon="angle-double-down" class="menu_arrow_mobile" />
      </li>
    </ul>
    <ul
      v-bind:class="{ show: this.$store.state.background == 'nav' }"
      class="menu"
    >
      <li v-on:click="navigateToLogin()">SIGN IN</li>
      <li>HOW TO USE</li>
      <li>TERMS OF SERVICE</li>
      <li>CONTACT</li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Navigation",
  methods: {
    openMenu() {
      this.$store.commit("changeBackground", "nav");
    },
    closeMenu() {
      this.$store.commit("changeBackground", "main");
    },
    navigateToLogin() {
      this.$store.commit("changeBackground", "login");
    },
    backToMain() {
      this.$store.commit("changeBackground", "main");
    },
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
ul.navigation {
  position: fixed;
  z-index: 22;
  top: 0;
  left: 0;
  display: flex;
  list-style-type: none;
  align-items: center;
  width: 100%;
  height: 10vh;
  padding: 0;
  margin: 0;
  justify-content: flex-end;
  @include noUserSelect();
  img {
    position: fixed;
    z-index: 26;
    top: 1.5em;
    left: 1.5em;
    width: 3em;
  }
  li {
    width: 4.5em;
    padding: 0 3em 0 2em;
    height: 2em;
    font-family: "Manrope";
    font-weight: 600;
    font-size: 1.25em;
    letter-spacing: 0.03em;
    color: white;
    transition: 1s;
    @include flexCenter();
    @include noUserSelect();
    cursor: pointer;
    &.red {
      @include xs {
        color: $dark_red;
        font-weight: 800;
      }
    }

    .menu_arrow,
    .menu_arrow_mobile {
      width: 2em;
      font-size: 1.1em;
    }
    .menu_arrow_mobile {
      display: none;
    }

    @include xs {
      padding: 0 1em 0 1.5em;
      width: 3em;
      .menu_arrow {
        display: none;
      }
      .menu_arrow_mobile {
        margin-right: 1em;
        display: block;
      }
    }
    @include md {
      width: 4em;
      padding: 0 1em 0 1em;
    }
  }
}
ul.menu {
  color: $white;
  position: fixed;
  z-index: 15;
  top: 1.8%;
  font-size: 2em;
  left: 0%;
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  width: 96.1%;
  height: 97.8vh;
  padding: 0;
  list-style-type: none;
  transition: 0.5s all;
  transition-delay: 0.3s all;
  pointer-events: none;
  opacity: 0;
  overflow: hidden;

  &.show {
    pointer-events: all;
    opacity: 1;
  }

  li {
    font-family: "Manrope";
    font-weight: 800;
    letter-spacing: 0.1em;
    background: none;
    width: 50%;
    @include noUserSelect();
    color: $white;
    height: 50%;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.3s;
    &:hover {
      cursor: pointer;
      background: $light_red;
    }
    &:nth-child(3) {
      @include borderTopRightRadius(80%);
    }
    @include xs {
      height: 25%;
      width: 100%;
      justify-content: left;
      padding-left: 10%;
      &:nth-child(3) {
        @include borderTopRightRadius(0);
      }
      &:hover {
        background: $light_red !important;
      }
    }
  }
  @include xs {
    transition: 0.05s all;
    top: 2%;
    left: 0;
    font-size: 1.6em;
    width: 90.2%;
    @include borderTopRightRadius(60%);
    @include borderBottomRightRadius(13%);
  }
}
</style>
