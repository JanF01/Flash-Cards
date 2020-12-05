<template>
  <div id="panel" class="main">
    <button v-on:click="handleSubmit()">Log out</button>
  </div>
</template>

<script>
import { router } from "../helpers";
export default {
  name: "Panel",
  components: {},
  methods: {
    handleSubmit() {
      this.$store.dispatch("authentication/logout");
      router.push("/");
    },
  },
};
</script>

<style lang="scss">
@import "../mixins/mixins.scss";
#panel {
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
