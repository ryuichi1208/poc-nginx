import socket
import time

from datetime import datetime

host = '0.0.0.0'
port = 8080
bind_address = (host, port)

backlog_size = 2

def server_loop():
    if not args.target:
        args.target = '0.0.0.0'
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((args.target, args.port))

    server.listen(5)
    while True:
        client_socket, addr = server.accept()
        client_thread = Thread(target=client_handler, args=[client_socket,])
        client_thread.start()

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(bind_address)
    server_socket.listen(backlog_size)

    print('[{}] Server startup'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S')))

    try:
        client_socket, addr = server_socket.accept()
        remote_addr = client_socket.getpeername()
        print('[{}] - handle connection, start - {}'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S'), remote_addr))
        with client_socket:
            while True:
                time.sleep(1)

    except KeyboardInterrupt:
        print('[{}] Server stop'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
