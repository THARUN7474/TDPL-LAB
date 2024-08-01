Implementing a client-server chat application using C++ will involve using sockets for networking, threads for handling multiple clients, and a GUI library for the user interface. Here's a simple outline of how you can achieve this:

### Server Code (C++)

The server will handle multiple clients by creating a new thread for each connection.

```cpp
#include <iostream>
#include <thread>
#include <vector>
#include <string>
#include <cstring>
#include <arpa/inet.h>
#include <unistd.h>
#include <mutex>

std::vector<int> clients;
std::mutex clients_mutex;

void handle_client(int client_socket) {
    char buffer[1024];
    while (true) {
        memset(buffer, 0, sizeof(buffer));
        int bytes_received = recv(client_socket, buffer, sizeof(buffer), 0);
        if (bytes_received <= 0) {
            close(client_socket);
            clients_mutex.lock();
            clients.erase(std::remove(clients.begin(), clients.end(), client_socket), clients.end());
            clients_mutex.unlock();
            break;
        }
        clients_mutex.lock();
        for (int client : clients) {
            if (client != client_socket) {
                send(client, buffer, sizeof(buffer), 0);
            }
        }
        clients_mutex.unlock();
    }
}

int main() {
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in server_addr;
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(12345);
    server_addr.sin_addr.s_addr = INADDR_ANY;

    bind(server_socket, (sockaddr*)&server_addr, sizeof(server_addr));
    listen(server_socket, 10);

    std::cout << "Server started..." << std::endl;

    while (true) {
        sockaddr_in client_addr;
        socklen_t client_size = sizeof(client_addr);
        int client_socket = accept(server_socket, (sockaddr*)&client_addr, &client_size);

        clients_mutex.lock();
        clients.push_back(client_socket);
        clients_mutex.unlock();

        std::thread(handle_client, client_socket).detach();
    }

    close(server_socket);
    return 0;
}
```

### Client Code (C++)

The client will connect to the server and communicate via sockets. We'll use a simple console-based interface for this example, but you can extend it with a GUI library like Qt for a more sophisticated interface.

```cpp
#include <iostream>
#include <thread>
#include <cstring>
#include <arpa/inet.h>
#include <unistd.h>

void receive_messages(int client_socket) {
    char buffer[1024];
    while (true) {
        memset(buffer, 0, sizeof(buffer));
        int bytes_received = recv(client_socket, buffer, sizeof(buffer), 0);
        if (bytes_received > 0) {
            std::cout << "Server: " << buffer << std::endl;
        }
    }
}

int main() {
    int client_socket = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in server_addr;
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(12345);
    inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr);

    connect(client_socket, (sockaddr*)&server_addr, sizeof(server_addr));

    std::thread(receive_messages, client_socket).detach();

    std::string message;
    while (true) {
        std::getline(std::cin, message);
        send(client_socket, message.c_str(), message.size(), 0);
    }

    close(client_socket);
    return 0;
}
```

### Explanation

1. **Server Code**:
    - **Socket Setup**: The server creates a socket, binds it to a port, and listens for incoming connections.
    - **Client Handling**: For each client that connects, a new thread is spawned to handle communication. The `handle_client` function receives messages from the client and broadcasts them to all other connected clients.
    - **Synchronization**: A mutex is used to ensure thread-safe access to the list of connected clients.

2. **Client Code**:
    - **Socket Setup**: The client creates a socket and connects to the server.
    - **Message Receiving**: A separate thread is spawned to continuously receive messages from the server and print them to the console.
    - **Message Sending**: The main thread reads user input from the console and sends it to the server.

### Extending with a GUI

For a GUI-based client, you can use libraries like Qt or wxWidgets. Here’s a brief idea of how you might start with Qt:

1. **Install Qt**: Download and install the Qt framework from [Qt's official site](https://www.qt.io/download).
2. **Create a New Qt Project**: Use Qt Creator to create a new project and set up the GUI.
3. **Integrate Networking**: Use `QTcpSocket` for the client-side networking.

This setup gives you a foundational chat application that you can further develop with additional features and a more sophisticated user interface.