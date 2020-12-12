import { baseUrl } from "./config";

export const flashcardService = {
  addFlashCard,
  getFlashCards,
  deleteFlashCard,
  editFlashCard,
};

function deleteFlashCard(id) {
  var user = JSON.parse(localStorage.getItem("user"));
  var jwt = user.token;

  var requestOptions = {
    method: "DELETE",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      id: id,
    }),
  };

  return fetch(`${baseUrl}/cards/delete_card`, requestOptions)
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function getFlashCards(group) {
  var user = JSON.parse(localStorage.getItem("user"));
  var jwt = user.token;

  var requestOptions = {
    method: "GET",
    headers: { "Content-Type": "application/json" },
  };

  return fetch(
    `${baseUrl}/cards/get_cards?jwt=` + jwt + `&group=` + group,
    requestOptions
  )
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function editFlashCard(front, back, importance, one_sided, id) {
  var user = JSON.parse(localStorage.getItem("user"));
  var jwt = user.token;

  var requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      front: front,
      back: back,
      importance: importance,
      one_sided: one_sided,
      id: id,
    }),
  };

  return fetch(`${baseUrl}/cards/edit_card`, requestOptions)
    .then(handleResponse)
    .then((resp) => {
      return resp;
    });
}

function addFlashCard(group, front, back, importance, one_sided) {
  var user = JSON.parse(localStorage.getItem("user"));
  var jwt = user.token;

  var requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jwt: jwt,
      group: group,
      front: front,
      back: back,
      importance: importance,
      one_sided: one_sided,
    }),
  };

  return fetch(`${baseUrl}/cards/new_card`, requestOptions)
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
