<template>
  <div class="login">
    <section>
      <h1>SIGN IN</h1>
      <input
        type="text"
        placeholder="Login*"
        v-model="username"
        @keyup="checkIfEnter"
      />
      <input
        type="password"
        placeholder="Password*"
        v-model="password"
        @keyup="checkIfEnter"
      />
      <h2 class="change">
        You don't have an account yet?
        <a v-on:click="goToRegister()">Register</a>
      </h2>
      <button v-on:click="handleSubmit()">LOG IN</button>
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
      submitted: false,
    };
  },
  computed: {
    loggingIn() {
      return this.$store.state.authentication.status.loggingIn;
    },
  },
  methods: {
    goToRegister() {
      this.$store.dispatch("changeSignAction", "register");
    },
    checkIfEnter(e) {
      if (e.keyCode == 13 || e.which == 13 || e.key == "enter") {
        this.handleSubmit();
      }
    },
    handleSubmit() {
      this.submitted = true;
      const { username, password } = this;
      const { dispatch } = this.$store;
      if (username && password) {
        dispatch("authentication/login", { username, password });
      } else {
        dispatch(
          "alert/error",
          "Make sure to fill in your username and your password"
        );
      }
    },
  },
};
</script>

<style scoped lang="scss">
@import "../mixins/mixins.scss";
section {
  z-index: 20;
  position: absolute;
  left: 10%;
  button {
    background: linear-gradient(165deg, $v_light_red 50%, $light_red 50.1%);
  }
}
</style>

<style lang="scss">
@import "../mixins/mixins.scss";

section {
  font-family: "Manrope", sans-serif;
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 30%;
  height: 100vh;
  justify-content: center;
  h1 {
    font-size: 1.4em;
    font-weight: 600;
    letter-spacing: 0.05em;
    margin-bottom: 0.3em;
  }
  h2 {
    font-size: 1.09em;
    letter-spacing: 0.02em;
  }
  @include md {
    position: absolute;
    left: 0;
  }
  input[type="text"],
  input[type="password"] {
    @include noAppearance();
    font-family: "Manrope", sans-serif;
    width: 100%;
    background: none;
    border: none;
    border-bottom: solid $white 0.2em;
    padding: 0.4em 0.4em 0.4em 0.4em;
    font-size: 1.1em;
    color: $white;
    margin-top: 3em;
    &::placeholder {
      color: rgb(216, 216, 216);
    }
    @include xl {
      width: 70%;
    }
    @include sm {
      width: 95%;
    }
    @include xs {
      width: 80%;
    }
  }
  button {
    @include noAppearance();
    @include borderRadius(0.2em);
    border: none;
    font-family: "Manrope", sans-serif;
    font-size: 1.1em;
    letter-spacing: 0.07em;
    font-weight: 700;
    padding: 0.55em 0.9em 0.55em 0.9em;
    width: 14em;
    margin-top: 3em;
    color: white;
    cursor: pointer;
    @include sm {
      margin-top: 2em;
    }
  }

  .change {
    margin-top: 2.4em;
    font-size: 1em;
    display: none;
    z-index: 15;
    a {
      color: #ffb7d3;
      cursor: pointer;
      z-index: 15;
    }
    @include sm {
      display: block;
    }
  }

  @include sm {
    width: 50%;
    margin-left: 15%;
  }
  @include xs {
    margin-top: -5%;
    width: 90%;
    margin-left: -5%;
    text-align: center;
  }
}
</style>
