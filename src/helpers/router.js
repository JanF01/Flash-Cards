import Router from "vue-router";

import Start from "../start/Start";
import Panel from "../panel/Panel";

export const router = new Router({
  mode: "history",
  routes: [
    { path: "/", component: Start },
    { path: "/panel", component: Panel },
    { path: "*", redirect: "/" },
  ],
});

router.beforeEach((to, from, next) => {
  const publicRoutes = ["/"];

  const authRequired = !publicRoutes.includes(to.path);
  const loggedIn = localStorage.getItem("user");

  if (to.path == "/logout") {
    const { dispatch } = this.$store;
    dispatch("authentication/logout");
  }

  if (authRequired && !loggedIn) {
    return next("/");
  }

  next();
});
