# Remote Desktop Manager
Aplicativo utilizado para conectar e gerenciar a Conexão de Área de Trabalho Remota do Windows.

![Gerenciador de Área de Trabalho Remota do Windows](https://github.com/EmanoelFrt/RemoteDesktopManager/assets/95585581/bbbf3d5e-c7c7-4c4e-8a26-12e393b7a15b)

# 💻 Funcionalidades
- Na tela inicial, é possível adicionar, editar ou excluir clientes de conexão.
- Para cada cliente é possível cadastrar um ou vários acessos.
- Ao definir um acesso, é necessário informar a descrição e o IP do mesmo. Login e senha são opcionais.
- Para conectar em uma área de trabalho remota, basta cadastrar um cliente, um acesso e clicar em conectar.
- Ao clicar em conectar, será feita uma chamada via mtsc.exe para a área de trabalho remota e será definido o seu usuário para o acesso atual, assim impossibilitando qualquer outro usuário de conectar no mesmo, já que o mtsc.exe só aceitará uma conexão por vez para cada acesso.

## ✔️ Técnicas e tecnologias utilizadas

- ``IDE Delphi 10.3``
- ``Firebird``
- ``Paradigma de orientação a objetos``
- ``Conexão de Área de Trabalho Remota do Windows``

# 🛠️ Abrir e rodar o projeto
- O único pré-requisito para conseguir utilizar o **Remote Desktop Manager** é ter instalado o **Firebird 3.0 ou superior**.
- Para compilar o projeto, é necessário utilizar a **IDE Delphi 10.3 ou superior**.
- Se precisar somente utilizar o programa sem compilar, faça o download deste repositório, vá até a pasta **Win32/Debug/** e execute o **GerenciadorTS.exe**.


