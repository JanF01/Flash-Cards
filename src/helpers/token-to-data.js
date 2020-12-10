export function tokenToData(user) {
  var base64Url = user ? user.token.split(".")[1] : "";
  if (base64Url.length) {
    var base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
    var jsonPayload = decodeURIComponent(
      atob(base64)
        .split("")
        .map(function(c) {
          return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
        })
        .join("")
    );
    return JSON.parse(jsonPayload);
  } else {
    return {};
  }
}
