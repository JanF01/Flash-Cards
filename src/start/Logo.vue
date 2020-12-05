<template>
  <div class="logo">
    <div
      class="left_block"
      v-bind:class="{ open: this.$store.state.background == 'nav' }"
    >
      <div class="left_block_inner_1">
        <div
          class="left_block_inner_2"
          v-bind:class="{ red: this.$store.state.background == 'login' }"
        ></div>
      </div>
    </div>
    <div class="content" v-if="this.$store.state.background == 'main'">
      <h1>SIMPLE</h1>
      <h1>FLASH CARDS</h1>
      <h3>WE MAKE IT EASIER</h3>
    </div>
  </div>
</template>

<script>
export default {
  name: "Logo",
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
.logo {
  color: white;
  position: absolute;
  font-family: "Manrope", sans-serif;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  letter-spacing: 0.1em;
  overflow: hidden;

  @include noUserSelect();
  .left_block {
    position: absolute;
    top: -22.5vh;
    left: -20%;
    min-width: 68%;
    min-height: 140vh;
    background: $white;
    transition: all 0.6s;
    @include borderRightRadius(50%);

    &.open {
      top: 0vh;
      min-width: 100%;
      left: 0%;
      @include borderRightRadius(30%);
      .left_block_inner_1 {
        margin-top: 2vh;
        margin-right: 2%;
        @include borderRightRadius(38%);
        .left_block_inner_2 {
          margin-top: 2vh;
          margin-right: 2%;
          @include borderRightRadius(38%);
        }
      }
    }

    @include md {
      left: -30%;
    }
    .left_block_inner_1 {
      background: $light_red;
      min-width: 65%;
      margin-right: 1%;
      margin-top: 5vh;
      min-height: 134vh;
      @include borderRightRadius(50%);
      .left_block_inner_2 {
        background: $dark_red;
        min-width: 63%;
        margin-right: 3%;
        position: relative;
        top: 4vh;
        min-height: 131vh;
        transition: all 0.6s;
        @include borderRightRadius(50%);
        &.red {
          position: absolute;
          min-width: 103.1%;
          @include borderRightRadius(0);
          margin-right: 0%;
          top: 0;
          left: 0;
          @include xs {
            top: -60vh;
            margin-left: -20%;
          }
          @include sm {
            min-width: 178%;
          }
          @include md {
            left: 15%;
          }
        }
      }
    }
    @include xs {
      top: 60vh;
      left: -5%;
      min-width: 100%;
      @include borderRightRadius(42%);
      &.open {
        top: 0vh;
        min-width: 120%;
        left: -10%;
        @include borderRightRadius(5%);
        .left_block_inner_1 {
          margin-top: 2vh;
          margin-right: 14%;
          @include borderRightRadius(50%);
          .left_block_inner_2 {
            margin-top: 2vh;
            margin-right: 3%;
            @include borderRightRadius(50%);
          }
        }
      }
      .left_block_inner_1 {
        margin-top: 2vh;
        margin-right: 0;
      }
    }
  }
  .content {
    margin: 13% 0 0 55%;
    z-index: 10;
    @include md {
      margin: 13% 0 0 45%;
    }
    @include sm {
      margin: 24vh 0 0 42%;
    }
    @include xs {
      position: absolute;
      margin: 19vh 0 0 15%;
    }

    h1 {
      margin: 0;
      font-size: 4.5em;
      font-weight: 800;
      line-height: 1.1em;
      @include xl {
        font-size: 5.5em;
      }
      @include sm {
        font-size: 3.85em;
      }
    }
    h3 {
      margin: 0;
      margin-left: 0.1em;
      font-size: 2.15em;
      letter-spacing: 0.11em;
      word-spacing: 1.31em;
      font-weight: 500;
      @include xl {
        font-size: 2.6em;
      }
      @include sm {
        font-size: 1.85em;

        margin-top: 0.5em;
      }
      @include xs {
        font-size: 1.7em;
        letter-spacing: 0.11em;
        word-spacing: 0.1em;
      }
    }
  }
}
</style>
