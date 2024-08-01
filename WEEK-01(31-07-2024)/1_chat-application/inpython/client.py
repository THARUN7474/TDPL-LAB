import socket
import threading
import tkinter as tk
from tkinter import scrolledtext, simpledialog

# GUI setup
class ClientGUI:
    def __init__(self, root, client_socket):
        self.client_socket = client_socket
        self.root = root
        self.root.title("Chat Application")

        self.chat_box = scrolledtext.ScrolledText(self.root)
        self.chat_box.pack(padx=20, pady=5)
        self.chat_box.config(state=tk.DISABLED)

        self.message_entry = tk.Entry(self.root, width=50)
        self.message_entry.pack(padx=20, pady=5)
        self.message_entry.bind("<Return>", self.send_message)

    def send_message(self, event=None):
        message = self.message_entry.get()
        self.client_socket.send(message.encode('utf-8'))
        self.message_entry.delete(0, tk.END)

    def receive_messages(self):
        while True:
            message = self.client_socket.recv(1024).decode('utf-8')
            if message:
                self.chat_box.config(state=tk.NORMAL)
                self.chat_box.insert(tk.END, message + '\n')
                self.chat_box.config(state=tk.DISABLED)
                self.chat_box.yview(tk.END)

def start_client():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 12345))

    root = tk.Tk()
    gui = ClientGUI(root, client_socket)

    threading.Thread(target=gui.receive_messages).start()

    root.mainloop()

if __name__ == "__main__":
    start_client()
