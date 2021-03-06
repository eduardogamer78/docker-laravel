# Setup Docker Para Projetos Laravel

### Passo a passo
Clone Repositório
```sh
git clone https://github.com/eduardogamer78/docker-laravel.git
```

Clone os Arquivos do Laravel-8
```sh
git clone https://github.com/laravel/laravel.git laravel-8
```

Crie o Arquivo .env
```sh
cd laravel-8/
cp .env.example .env
```

Atualizar as variáveis de ambiente do arquivo .env
```dosini
APP_NAME=Laravel
APP_URL=https://localhost/

DB_CONNECTION=mysql
DB_HOST=mariadb
DB_PORT=3306
DB_DATABASE=nome_que_desejar_db
DB_USERNAME=root
DB_PASSWORD=root

CACHE_DRIVER=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379
```

Suba os containers do projeto
```sh
docker-compose up -d
```

Acessar o container
```sh
docker-compose exec php-fpm bash
```

Instalar as dependências do projeto
```sh
composer install
```

Gerar a key do projeto Laravel
```sh
php artisan key:generate
```

Acessar o projeto
[https://localhost/](https://localhost/)
