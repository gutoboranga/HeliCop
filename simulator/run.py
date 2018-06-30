# -*- coding: utf-8 -*-
import socket
from connection import wait_for_connection, create_socket
from simulation import main as start_simulation


def main():
    # cria o socket para conectar
    sock = create_socket(4000)

    print("Aguardando conexão no ip: ")
    print(socket.gethostbyname(socket.getfqdn()))

    # aguarda o app mobile pedir pra conectar
    success = wait_for_connection(sock)

    # se correu tudo bem
    if success:
        start_simulation(sock)
    else:
        exit("Erro ao tentar conectar com o app mobile")

        
if __name__ == "__main__":
    main()
    