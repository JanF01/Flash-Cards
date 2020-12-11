import { baseUrl } from "./config";

export const flashcardService = {
  addFlashCard,
};

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
