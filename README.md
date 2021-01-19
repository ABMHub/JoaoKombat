# JoaoKombat

## Trabalho final da matéria "Organização e Arquitetura de Computadores" na UnB, 2020.1

### Descrição

O trabalho consiste na criação do famoso jogo "Mortal Kombat 2" em Assembly RISC-V. No fim, o grupo chegou bem perto do resultado, conseguindo implementar todos os personagens jogáveis e partidas completamente funcionais.

O kombate, em si, é diferente do jogo original, pois não tivemos tempo para fazer com que dois personagens se movessem simultaneamente, então enquanto um personagem estiver se movimentando, o outro terá que esperar.

O Shao Kanh e o Kintaro, os dois chefões/bosses do jogo, não foram implementados, pois estouramos o limite do segmento de dados e não conseguimos adicionar mais sprites (inclusive, tivemos que retirar três cenários do jogo para que todos os 12 personagens base fossem jogáveis).

Para jogar, simplesmente execute o Rars14_Custom4.jar na pasta "Mortal Kombat", abra as ferramentas/tools "Bitmap Display" e "Keyboard and display MMIO simulator", clique em "Conectar ao programa" em ambas, monte o código e execute.

### Controles

- Movimentação: w a s d
- Cambalhota para frente: e
- Cambalhota para trás: q
- Chute forte: z
- Chute fraco: x
- Soco fraco: c
- Soco forte: v
- Block: f
- Poder: 'barra de espaço'

## README usado no desenvolvimento

### Comando úteis:
```
git add . -> salva todas as alterações feitas na pasta (pode ser revertível)
git commit -m "comentário" -> salva permanentemente as mudanças no repositório
git push -> manda as mundanças pros amiguinhos (repositório remoto)
```
```
git pull -> pega as mudanças no repositório remoto e mescla com suas mudanças locais (cuidado com conflitos!!!)
```
```
git branch nome_branch -> cria uma branch com o nome que você escolher
git switch nome_branch -> muda de uma branch para a outra
```
*(a branch principal é sempre master)*
```
git reset --hard -> reseta suas mudanças para o commit mais recentes
```

### Todo-List

01. [X] Pintar o fundo 
02. [X] Pintar o personagem 
03. [X] Fazer o personagem se mover pra frente (deixando um rastro msm)
04. [X] Fazer o personagem se mover pra frente apagando o rastro dele e repintando com o fundo
05. [X] Fazer o personagem se mover pra frente com animação
06. [X] Fazer o personagem se mover para trás, pular e agachar
07. [X] Fazer o personagem dar um soco
08. [X] Fazer o personagem dar um chute
09. [X] Verificar se houve colisão e aplicar o dano se tiver
10. [X] Criar poderzinho
11. [X] Criar personagens diferentes
12. [X] Criar os menus
13. [X] Fazer o relatório na madrugada do dia da apresentação
14. [X] Frames dançantes