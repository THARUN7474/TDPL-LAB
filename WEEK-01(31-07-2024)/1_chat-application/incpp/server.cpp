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
