<template>
  <div id="start" class="main">
    <Navigation />
    <Logo />
    <Login
      v-if="this.$store.state.background == 'login'"
      class="reg"
      v-bind:class="{ mobile: this.$store.state.signAction == 'login' }"
    />
    <Register
      v-if="this.$store.state.background == 'login'"
      class="reg"
      v-bind:class="{ mobile: this.$store.state.signAction == 'register' }"
    />
  </div>
</template>

<script>
import Logo from "./Logo";
import Navigation from "./Navigation";
import Login from "./Login";
import Register from "./Register";
import { router } from "../helpers";
export default {
  name: "Start",
  components: {
    Logo,
    Navigation,
    Login,
    Register,
  },
  mounted() {
    if (this.$store.state.authentication.status.loggedIn) router.push("/panel");
  },
};
</script>

<style lang="scss">
@import "../mixins/mixins.scss";
#start {
  min-width: 100%;
  height: 100vh;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  &.main {
    background: #1a1a1d;
  }
  @include sm {
    .reg {
      display: none;
      &.mobile {
        display: block;
      }
    }
  }
}
</style>
