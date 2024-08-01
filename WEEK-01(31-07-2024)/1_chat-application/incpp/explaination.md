
### Server Code:

```cpp
#include <iostream>
#include <thread>
#include <vector>
#include <string>
#include <cstring>
#include <arpa/inet.h>
#include <unistd.h>
#include <mutex>
```
- **Includes necessary headers**: These headers are required for input/output operations (`iostream`), threading (`thread`), managing a list of clients (`vector`), string operations (`string`, `cstring`), network communication (`arpa/inet.h`), and mutex for thread synchronization (`mutex`).

```cpp
std::vector<int> clients;
std::mutex clients_mutex;
```
- **Global variables**:
  - `clients`: A vector to store the socket file descriptors of connected clients.
  - `clients_mutex`: A mutex to ensure thread-safe operations on the `clients` vector.

```cpp
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
```
- **`handle_client` function**:
  - `char buffer[1024]`: Buffer to store messages received from clients.
  - **`while (true)` loop**: Continuously receives messages from the client.
  - `memset(buffer, 0, sizeof(buffer))`: Clears the buffer.
  - `recv(client_socket, buffer, sizeof(buffer), 0)`: Receives a message from the client.
  - **Error handling**: If `recv` returns `<= 0`, close the client socket and remove it from the clients list.
  - **Broadcasting**: Loops through all clients and sends the received message to all other clients.

```cpp
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
- **`main` function**:
  - `socket(AF_INET, SOCK_STREAM, 0)`: Creates a socket for TCP communication.
  - **`server_addr` struct setup**: Configures the server address structure.
  - `bind(server_socket, (sockaddr*)&server_addr, sizeof(server_addr))`: Binds the socket to the specified IP address and port.
  - `listen(server_socket, 10)`: Listens for incoming connections, with a backlog of 10.
  - **Infinite loop**: Continuously accepts new client connections.
  - `accept(server_socket, (sockaddr*)&client_addr, &client_size)`: Accepts a new client connection.
  - **Client management**: Adds the new client to the clients list and starts a new thread to handle the client.

### Client Code:

```cpp
#include <iostream>
#include <thread>
#include <cstring>
#include <arpa/inet.h>
#include <unistd.h>
```
- **Includes necessary headers**: These headers are required for input/output operations (`iostream`), threading (`thread`), string operations (`cstring`), and network communication (`arpa/inet.h`).

```cpp
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
```
- **`receive_messages` function**:
  - `char buffer[1024]`: Buffer to store messages received from the server.
  - **`while (true)` loop**: Continuously receives messages from the server.
  - `memset(buffer, 0, sizeof(buffer))`: Clears the buffer.
  - `recv(client_socket, buffer, sizeof(buffer), 0)`: Receives a message from the server.
  - **Message display**: Prints received messages to the console.

```cpp
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
- **`main` function**:
  - `socket(AF_INET, SOCK_STREAM, 0)`: Creates a socket for TCP communication.
  - **`server_addr` struct setup**: Configures the server address structure.
  - `inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr)`: Converts the IP address from text to binary form.
  - `connect(client_socket, (sockaddr*)&server_addr, sizeof(server_addr))`: Connects to the server.
  - **Message receiving thread**: Starts a new thread to handle incoming messages from the server.
  - **Message sending loop**: Continuously reads messages from the console and sends them to the server.
  - `close(client_socket)`: Closes the client socket (this line will not be reached due to the infinite loop).

This breakdown should help you understand the core operations and interactions within this client-server chat application.