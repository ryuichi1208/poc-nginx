#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

int
main(int argc, char *argv[])
{
    struct sockaddr_in server;
    int sock;
    char buf[32];
    char *deststr;
    unsigned int **addrptr;

    if (argc != 2) {
        printf("Usage : %s dest\n", argv[0]);
        return 1;
    }
    deststr = argv[1];

    sock = socket(AF_INET, SOCK_STREAM, 0);

    if (sock < 0) {
        perror("socket");
        return 1;
    }

    server.sin_family = AF_INET;
    server.sin_port = htons(80); /* HTTPのポートは80番です */

    server.sin_addr.s_addr = inet_addr(deststr);
    if (server.sin_addr.s_addr == 0xffffffff) {
        struct hostent *host;

        host = gethostbyname(deststr);
        if (host == NULL) {
            if (h_errno == HOST_NOT_FOUND) {
                printf("host not found : %s\n", deststr);
            } else {
                printf("%s : %s\n", hstrerror(h_errno), deststr);
            }
            return 1;
        }

        addrptr = (unsigned int **)host->h_addr_list;

        while (*addrptr != NULL) {
	        server.sin_addr.s_addr = *(*addrptr);

	        if (connect(sock,
		        (struct sockaddr *)&server,
		        sizeof(server)) == 0) {
                break;
            }

            addrptr++;
        }

        if (*addrptr == NULL) {
            perror("connect");
		    return 1;
        }
    } else {
        if (connect(sock,(struct sockaddr *)&server, sizeof(server)) != 0) {
		    perror("connect");
		    return 1;
        }
    }

    memset(buf, 0, sizeof(buf));
    snprintf(buf, sizeof(buf), "GET / HTTP/1.0\r\n\r\n");

    /* HTTPリクエスト送信 */
    int n = write(sock, buf, (int)strlen(buf));
    if (n < 0) {
        perror("write");
        return 1;
    }

    while (n > 0) {
        memset(buf, 0, sizeof(buf));
        n = read(sock, buf, sizeof(buf));
	    if (n < 0) {
		    perror("read");
		    return 1;
	    }

	 /* 受信結果を標準出力へ表示(ファイルディスクリプタ1は標準出力) */
    write(1, buf, n);
    }

    close(sock);

    return 0;
}
