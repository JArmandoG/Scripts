_HTML='''<tr><td><img alt="dp-banner" src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/561ab490-ce63-4634-9310-33493fe1ea1c/Screen_Shot_2022-03-27_at_23.20.24.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220328%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220328T053147Z&X-Amz-Expires=86400&X-Amz-Signature=fba39f7a87ed316c0c58b12da454380c4e6ae23cfa8e8c38f3ad0e057a590685&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen%2520Shot%25202022-03-27%2520at%252023.20.24.png%22&x-id=GetObject" width="100%" style="margin: 0; border: 0; padding: 0; display: block;"></td></tr> <br> <br>Hola, <a href="https://google.com">esta</a> es una URL!'''

_P=$(echo 'OXpmUFRqeFpRdDRZSENxSQ==' | base64 -d)
_E=$(echo 'am9obmRvbnltMTIzQGdtYWlsLmNvbQ==' | base64 -d)
_RELAY=$(echo 'IHNtdHAtcmVsYXkuc2VuZGluYmx1ZS5jb206NTg3' | base64 -d)

sendemail \
		-xu $_E \
		-xp $_P \
		-s $_RELAY \
		-f "ag@deltaprotect.com" \
		-t $1 \
		-u "Goot spoofed?" \
		-m $_HTML
