Configuração do Nginx para NodeJS e Django
Este repositório descreve como configurar o Nginx para funcionar com aplicativos NodeJS e Django em um ambiente Docker.

Passos
1. Preparação
Antes de começar, garanta que você tenha o Docker e o Docker Compose instalados em sua máquina.

2. Dockerfile
Crie um Dockerfile para o Nginx em seu projeto. Este arquivo é necessário para construir uma imagem Docker do Nginx.

3. Configuração do Nginx
O arquivo default.conf contém a configuração do Nginx. Inicialmente, configuramos para ouvir apenas a porta 80 (HTTP) e rotear o tráfego para os aplicativos NodeJS e Django. Mais tarde, adicionamos suporte SSL.

Aqui está a configuração básica sem SSL na pasta /conf.d arquivo nossl.conf:

```nginx

# Configuração para o aplicativo Django

server {
    listen 80;
    server_name django.guarda.sol.app.br;

    location / {
        proxy_pass http://django:8000;
        ...
    }
}

# Configuração para o aplicativo NodeJS
server {
    listen 80;
    server_name nodejs.guarda.sol.app.br;

    location / {
        proxy_pass http://nodejs:3000;
        ...
    }
}
```
4. Certbot
Para adicionar suporte SSL, usamos o Certbot. Primeiro, configuramos o Nginx sem SSL. Depois, usamos o Certbot para solicitar e instalar certificados SSL. Atualize a configuração do Nginx para incluir as rotas SSL após obter os certificados.

5. Docker Compose
Usamos o Docker Compose para gerenciar múltiplos contêineres. O arquivo docker-compose.yml descreve como os contêineres interagem entre si.

Exemplo de configuração do docker-compose.yml:

```yaml
services:
  nginx:
    image: nginx
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d
    ports:
      - "80:80"
      - "443:443"
  nodejs:
    build:
      context: ./NodeJs
  django:
    build:
      context: ./django_aws_image
```

Este read.me faz parte de um projeto maior. 
comandos para pedir certificado
certbot --nginx -d django.guarda.sol.app.br -d nodejs.guarda.sol.app.br

