import Vue from "vue";
export function throwAlert(message, type, length, pos) {
  Vue.$toast.open({
    message: message,
    type: type,
    position: pos,
    duration: length,
  });
}
