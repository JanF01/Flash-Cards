<template>
  <div class="login">
    <section>
      <h2 v-if="this.$store.state.signAction != 'register'">
        You don't have an account yet?
      </h2>
      <h1>SIGN UP</h1>
      <input type="text" placeholder="Login*" v-model="username" />
      <input type="password" placeholder="Password*" v-model="password" />
      <input
        type="password"
        placeholder="Repeat Password*"
        v-model="passRepeat"
      />
      <h2 class="change">
        You already have an account?
        <a v-on:click="goToLogin()">Login</a>
      </h2>
      <button v-on:click="handleSubmit()">CREATE ACCOUNT</button>
    </section>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      username: "",
      password: "",
      passRepeat: "",
      submitted: false,
    };
  },
  methods: {
    goToLogin() {
      this.$store.commit("changeSignAction", "login");
    },
    handleSubmit() {
      if (this.password == this.passRepeat) {
        this.submitted = true;
        const { username, password } = this;
        const { dispatch } = this.$store;
        if (username && password) {
          dispatch("authentication/register", { username, password });
        }
      } else {
        const { dispatch } = this.$store;
        dispatch("alert/error", "The passwords aren't the same");
      }
    },
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
section {
  position: absolute;
  left: 60%;
  h2 {
    margin-top: -1.9em;
  }
  button {
    background: linear-gradient(165deg, black 50%, rgb(58, 58, 58) 50.1%);
  }
  .change {
    margin-top: 2em;
  }
  @include sm {
    left: 10%;
    button {
      background: linear-gradient(165deg, $v_light_red 50%, $light_red 50.1%);
    }
  }
}
</style>
