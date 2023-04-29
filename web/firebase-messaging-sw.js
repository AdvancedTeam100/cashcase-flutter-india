importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js"
);

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;

firebase.initializeApp({
  apiKey: "AIzaSyB29Rl1IKWA-sTP-gHvlrN7scS7hO4Mp4s",
  authDomain: "cashfuse-60939.firebaseapp.com",
  projectId: "cashfuse-60939",
  storageBucket: "cashfuse-60939.appspot.com",
  messagingSenderId: "521109211624",
  appId: "1:521109211624:web:1f3cec9c3cbbfea4c53c5d",
  measurementId: "G-KBPRBBZRYC",
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true,
    })
    .then((windowClients) => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      return registration.showNotification("New Message");
    });
  return promiseChain;
});
self.addEventListener("notificationclick", function (event) {
  console.log("notification received: ", event);
});
