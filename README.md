# Projeto SIP com Kamailio e Linphone (Sem Criptografia)

## Descrição

Este projeto configura um ambiente SIP utilizando **Kamailio** como servidor de sinalização, e dois **softphones Linphone** para realizar chamadas de voz entre dois usuários, `ashe` e `braum`. O ambiente está configurado com Docker, garantindo a portabilidade e reprodutibilidade do ambiente.

## Arquitetura

- **Kamailio**: Servidor SIP de sinalização, configurado com banco de dados SQLite para persistência de usuários.
- **Linphone**: Softphone SIP utilizado para registrar usuários e realizar chamadas.
- **Docker**: Utilizado para containerizar o ambiente, garantindo a portabilidade e o isolamento dos componentes.

## Estrutura do Projeto

```bash
projeto-kamailio/
├── docker-compose.yml              # Orquestração dos containers
├── Dockerfile-kamailio             # Build da imagem do Kamailio
├── Dockerfile-linphone             # Build da imagem com Linphone GUI
├── init_db.sh                      # Script para inserir usuários no banco SQLite
└── kamailio/
    ├── kamailio.cfg                # Configuração principal do Kamailio
    └── kamailio.db                 # Banco SQLite com tabela subscriber
```
## Pré-Requisitos
- Docker

- Docker Compose

- Acesso a um terminal (Linux ou WSL no Windows)

## Passos para Instalar

##### 1. Clonar o Repositório
```bash
git clone 
cd projeto-kamailio
```
##### 2. Construir e Iniciar os Containers
```bash
docker-compose up --build -d
```
##### 3. Verificar os Containers em Execução
```bash
docker ps -a
```

##### 4. Configuração do Kamailio

O Kamailio está configurado para usar SQLite. O banco de dados e a tabela ```subscriber``` são inicializados automaticamente pelo script ```init_db.sh```, que insere os usuários ```ashe``` e ```braum```.

##### 5. Configuração do Linphone

- Username: ashe
- Password: 1234
- Domain: kamailio
- Proxy: sip:kamailio

##### 6. Teste de Comunicação

Para realizar uma chamada:
###### 1. No Linphone de ```ashe```, insira:
```sip:braum@<IP_DO_SERVIDOR>```

OBS: Para descobrir o IP do Kamailio use o comando:
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kamailio
```
###### 2. Clique no ícone de chamada e aguarde a notificação de ```braum```

###### 3. ```braum``` deve receber a chamada e atender.

##### 7. Debug com sngrep

Você pode usar ```sngrep``` para capturar os pacotes SIP entre os containers:

```bash
docker exec -it kamailio sngrep
```

Isso exibirá os pacotes SIP trocados entre ```ashe``` e ```braum```.
