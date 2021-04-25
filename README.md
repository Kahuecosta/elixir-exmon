# Projeto EXmon em Elixir (estudo)

### Instalação

- Instalar o Elixir: https://elixir-lang.org/install.html

### Comandos

- Compilar a aplicação
  - `mix compile`
- Rodar os testes
  - `mix test`
- Rodar a plicação
  - `iex -S mix`
- Formata o código
  - `mix format`
- Istalando as dependências
  - `mix deps.get`

### Extensão VSCode

- ElixirLS: Elixir support and debugger

### Regras

- Jogo baseado em turnos onde tem um player contra o computador
- Humano e computador começam com 100 pontos de vida
- A cada rodada, cada um pode fazer um dos 3 movimentos
  - Ataque moderado que dá entre (18-25) de dano
  - Ataque variado que dá entre (10-35) de dano
  - Poder de cura, curando entre (18-25) de vida
- A cada movimento, será exibido na tela o que aconteceu e a situação de cada jogador
- Se o jogador ou computador ficar com 0 de vida, o jogo acaba
  - O resultado final não deve exibir vida negativa
- O jogador humano poderá escolher o nome do seu personagem assim como o nome de seus 3 movimentos

### Comandos para jogar

- `player = Exmon.create_player("Kahue", :chute, :soco, :cura)`
- `Exmon.start_game(player)`
- `Exmon.make_move(:chute)`
- `Exmon.make_move(:soco)`
- `Exmon.make_move(:cura)`

### Teste

- Realizado testes unitários

### Lint pra Elixir

- credo https://github.com/rrrene/credo/blob/master/.credo.exs

### Próximos desafios

- Terminar os testes dos outros módulos
- Sortear qual player começa a partida
- Aumentar a chance do cumputador se curar quando estiver abaixo de 40 pontos de vida
