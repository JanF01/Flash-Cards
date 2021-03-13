import { baseUrl } from "./config";

export const userService = {
  login,
  logout,
  register,
};

function login(username, password) {
  const requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ username, password }),
  };

  return fetch(`${baseUrl}/users/login.php`, requestOptions)
    .then(handleResponse)
    .then((user) => {
      if (user.token) {
        localStorage.setItem("user", JSON.stringify(user));
      }

      return user;
    });
}

function register(username, password) {
  const requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ username, password }),
  };

  return fetch(`${baseUrl}/users/register`, requestOptions)
    .then(handleResponse)
    .then((user) => {
      if (user.token) {
        localStorage.setItem("user", JSON.stringify(user));
      }

      return user;
    });
}

function logout() {
  localStorage.removeItem("user");
}

function handleResponse(response) {
  return response.text().then((text) => {
    const data = text && JSON.parse(text);
    if (!response.ok) {
      if (response.status === 401) {
        logout();
        location.reload();
      }
      const error = (data && data.message) || response.statusTest;
      return Promise.reject(error);
    }
    return data;
  });
}
