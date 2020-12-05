<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "app",
  components: {},
};
</script>

<style lang="scss">
@import "mixins/mixins.scss";
body {
  width: 100%;
  margin: 0 auto;
  height: 100vh;
}
</style>
