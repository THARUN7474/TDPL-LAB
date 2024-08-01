const socket = io();

const form = document.getElementById('form');
const input = document.getElementById('input');
const messages = document.getElementById('messages');
const typingIndicator = document.getElementById('typingIndicator');

// Assign a random color to the user
const userColor = `#${Math.floor(Math.random() * 16777215).toString(16)}`;

form.addEventListener('submit', function (e) {
  e.preventDefault();
  if (input.value) {
    const message = {
      user: 'User', // TODO: we can add user authentication and keep here his or her username it will be so good too
      color: userColor,
      text: input.value,
      time: new Date().toLocaleTimeString()
    };
    socket.emit('chat message', message);
    input.value = '';
  }
});

input.addEventListener('input', () => {
  socket.emit('typing');
});

socket.on('chat message', function (msg) {
  const item = document.createElement('li');
  item.innerHTML = `<span class="username" style="color: ${msg.color}">${msg.user}</span> [<span class="timestamp">${msg.time}</span>]: ${msg.text}`;
  messages.appendChild(item);
  window.scrollTo(0, document.body.scrollHeight);
});

socket.on('typing', function (user) {
  typingIndicator.textContent = `${user} is typing...`;
  setTimeout(() => {
    typingIndicator.textContent = '';
  }, 2000);
});
