import { baseUrl } from "./config";
import { tokenToData } from "../helpers";

export const groupService = {
  createGroup,
  getGroups,
  moveGroups,
  editGroup,
  deleteGroup,
};

function createGroup(name, color, pos_x, pos_y) {
  var user = JSON.parse(localStorage.getItem("user"));
  var user_id = tokenToData(user).id;
  var jwt = user.token;

  var requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      user_id: user_id,
      name: name,
      color: color,
      pos_x: pos_x,
      pos_y: pos_y,
    }),
  };

  return fetch(`${baseUrl}/cards/new_group`, requestOptions)
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function editGroup(name, color, amount, id, owner) {
  var user = JSON.parse(localStorage.getItem("user"));
  var jwt = user.token;

  console.log(arguments);
  var requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      name: name,
      id: id,
      color: color,
      amount: amount,
      owner: owner,
    }),
  };

  return fetch(`${baseUrl}/cards/edit_group`, requestOptions)
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function getGroups() {
  var user = JSON.parse(localStorage.getItem("user"));
  var user_id = tokenToData(user).id;
  var jwt = user.token;

  var requestOptions = {
    method: "GET",
    headers: { "Content-Type": "application/json" },
  };

  return fetch(
    `${baseUrl}/cards/get_groups?jwt=` + jwt + "&user_id=" + user_id,
    requestOptions
  )
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function moveGroups(groups) {
  var user = JSON.parse(localStorage.getItem("user"));
  var user_id = tokenToData(user).id;
  var jwt = user.token;

  var requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      groups: groups,
      user_id: user_id,
    }),
  };

  return fetch(`${baseUrl}/cards/move_groups`, requestOptions)
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function deleteGroup(id) {
  var user = JSON.parse(localStorage.getItem("user"));
  var user_id = tokenToData(user).id;
  var jwt = user.token;

  var requestOptions = {
    method: "DELETE",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      group_id: id,
      user_id: user_id,
    }),
  };

  return fetch(`${baseUrl}/cards/delete_group`, requestOptions)
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function handleResponse(response) {
  return response.text().then((text) => {
    const data = text && JSON.parse(text);
    if (!response.ok) {
      const error = (data && data.message) || response.statusTest;
      return Promise.reject(error);
    }
    return data;
  });
}
