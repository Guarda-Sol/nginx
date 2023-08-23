
# Configuração do Nginx para o AwsCase

Este repositório descreve como configurar o Nginx para funcionar com aplicativos NodeJS, Django e Java em um ambiente Docker para o projeto `AwsCase`.

## Passos

### Preparação

Antes de começar, garanta que você tenha o Docker e o Docker Compose instalados em sua máquina.

### Docker Compose

Primeiramente, execute o docker-compose a partir do repositório raiz (AwsCase):

```bash
docker-compose up -d
```

### Certbot

Para adicionar suporte SSL, usamos o Certbot. Após ter o Nginx rodando via Docker, siga os passos abaixo:

1. Entre no container do Nginx:

```bash
docker ps # Identifique o ID ou nome do container do Nginx
docker exec -it [CONTAINER_ID_OU_NOME] /bin/bash
```

2. Solicite os certificados SSL:

```bash
certbot --nginx -d django.guarda.sol.app.br -d nodejs.guarda.sol.app.br -d java.guarda.sol.app.br
```

> Lembre-se: Se este projeto for clonado, talvez seja necessário ajustar os endereços conforme seu próprio domínio.

3. Verifique se a configuração `default.conf` foi atualizada com os certificados SSL:

```bash
cat /etc/nginx/conf.d/default.conf
```

Se ela não estiver atualizada com as informações do certificado SSL, você pode precisar alterá-la manualmente.

### Atualização Manual

Como estamos usando volumes do Docker, você pode usar sua própria IDE ou editor de texto para editar os arquivos diretamente em sua máquina. Localize o arquivo `default.conf` em seu sistema e faça as alterações necessárias. 

Alternativamente, se preferir editar dentro do container, você pode usar editores como `nano` ou `vim`:

```bash
nano /etc/nginx/conf.d/default.conf
```

ou 

```bash
vim /etc/nginx/conf.d/default.conf
```

Depois de fazer as alterações, reinicie o serviço do Nginx para que as mudanças entrem em vigor.

```
    nginx -s reload
```

### Finalização

Com tudo configurado, seu Nginx deverá estar encaminhando o tráfego corretamente para os aplicativos e servindo-os com segurança via SSL.

## Contribuição

Sinta-se à vontade para contribuir e melhorar este projeto. Todas as sugestões e contribuições são bem-vindas!

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE.md](LICENSE.md) para mais detalhes.
