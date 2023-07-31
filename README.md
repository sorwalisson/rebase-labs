# Rebase Labs

Uma app web para listagem de exames médicos.

---

### Tech Stack

* Docker
* Ruby
* Javascript
* HTML
* Bootstrap

---

#### Gems utilizadas
* gem 'sinatra'

* gem 'pg'

* gem 'puma'

* gem 'redis'

* gem 'activesupport'

* gem 'sidekiq'

* gem 'bootstrap', '~> 5.2.3'

* gem 'rspec'

* gem 'capybara'

### Inciar a aplicação

#### Modo Teste (rspec)

Para rodar os testes rspec/capybara deve-se utilizar o comando `sudo docker compose run test`, Feito isso o capybara irá levantar o servidor, basta apertar CTRL + C para derrubar o servidor e os testes rodarão

ps: Não há testes para elementos aplicados através do JS.


#### Rodando a aplicação
Existem dois comandos para subir a aplicação:
- `sudo docker compose up web db redis worker` Nesse comando vc subirá a aplicação e terá acesso ao log dos quatros containers
- `sudo docker compose up web` Nesse comando só tera acesso ao log do compose web, mas os outros 3 containers também estarão rodando

##### Script para inserção de informação no banco de dados.

Após subir a aplicação para inserir os dados do CSV no banco de dados basta entrar no container `sudo docker exec -it web bash` e executar o comando `bundle exec ruby seed.rb`

#### Rotas
#### APIs
* `'/api/tests'`
   Essa rota devolve todos os pacientes e seus exames

* `'api/tests/:token'`
   Essa rota devolve o paciente atrelado ao médico responsável pelo os exames e os exames que possuem o mesmo token.

* `'api/patients/:cpf'`
   Essa rota é uma busca do paciente via cpf, e ela devolve o paciente e todo o histórico de exames desse paciente agrupados por token.

#### Rotas HTML

* `'/upload'`
   Rota para se fazer upload de arquivo CSV. Ao se escolher um arquivo csv e clickar em submit, o JS interrompe o redirecionamento de rota, e atualiza o HTML com mensagem de que o arquivo foi enviado com sucesso. E o arquivo será tratado de forma assíncrona.

* `'/tests'`
   Rota para se fazer pesquisa por token, basta digitar o token do exame e serão exibidas as informações contidas na api `'api/tests/:token'` de uma forma mais user friendly. A apresentação é feita com JS sem redirecionamento de rota

* `'/patients'`

   Rota para busca por CPF, basta digitar o cpf do usuário e será exibido as informações do paciente, junto de um dropdown que ao ser utilizado irá exbir os tokens que pertecem ao paciente, selecionando um dos tokens será exibido os exames daquele token, tudo isso feito através do JS.

<img src="/public/lab.png">

