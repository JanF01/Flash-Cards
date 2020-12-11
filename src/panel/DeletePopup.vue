<template>
  <div id="deletepopup">
    <div class="container">
      <h2>
        Are you sure you want to delete this group?<br />
        All the created cards will be deleted with it!
      </h2>
      <div class="buttons">
        <button v-on:click="deleteGroup">
          YES
        </button>
        <button v-on:click="closeDeletePopup">
          NO
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "DeletePopup",
  props: {
    id: Number,
    x: String,
    y: String,
  },
  methods: {
    deleteGroup() {
      const { dispatch } = this.$store;

      dispatch("cardgroups/deleteCardGroup", {
        id: this.id,
        x: this.x,
        y: this.y,
      });

      this.closeDeletePopup();
    },
    closeDeletePopup() {
      this.$store.dispatch("changeDeletingStatus", false);
    },
  },
  components: {},
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
.container {
  @include noUserSelect();
  width: 40em;
  min-height: 10em;
  padding-bottom: 2em;
  position: fixed;
  top: calc(50vh - 5em);
  left: calc(50% - 20em);
  z-index: 20;
  background: linear-gradient(to bottom right, $dark_red 50%, $light_red 50.1%);

  @include borderRadius(0.2em);
  display: flex;
  flex-direction: column;
  align-items: center;
  h2 {
    color: white;
    font-family: "Manrope", sans-serif;
    font-size: 1.2em;
    letter-spacing: 0.1em;
    padding: 1.4em 2.2em 1em 2.2em;
    font-weight: 500;
    line-height: 1.7em;
    text-align: center;
  }
  .buttons {
    width: 100%;
    @include flexCenter();
    button {
      @include noAppearance();
      @include borderRadius(0.2em);
      border: none;
      font-family: "Manrope", sans-serif;
      font-size: 1em;
      letter-spacing: 0.07em;
      font-weight: 700;
      padding: 0.55em 0.9em 0.55em 0.9em;
      width: 14em;
      margin: 2% 4% 4% 4%;
      color: white;
      position: relative;
      background: linear-gradient(
        180deg,
        $v_dark_red 90%,
        rgb(255, 255, 255) 90.1%
      );

      transition: all 0.2s;
      &:hover {
        filter: brightness(1.2);
        transform: scale(0.96);
      }

      cursor: pointer;
      @include sm {
        margin-top: 7%;
      }
    }
  }
}
</style>
