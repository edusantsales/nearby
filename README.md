![Capa](https://github.com/user-attachments/assets/be271173-d5f9-42f8-a7b2-ead43b224893)

# 📍 Nearby

**Nearby** é um aplicativo mobile de clube de benefícios que oferece cupons para utilização em estabelecimentos próximos a você. Com uma interface intuitiva e funcionalidades robustas, o aplicativo proporciona uma experiência única para usuários em busca de ofertas locais.

## 🚀 Tecnologias Utilizadas

- **Frontend**:
  - [Swift](https://swift.org/): Linguagem de programação utilizada para o desenvolvimento do aplicativo iOS.
  - [UIKit](https://developer.apple.com/documentation/uikit): Framework para construção da interface gráfica no iOS.

- **Backend**:
  - [Node.js](https://nodejs.org/): Ambiente de execução para JavaScript no servidor.
  - [Express](https://expressjs.com/): Framework web para Node.js, facilitando a criação de APIs RESTful.
  - [TypeScript](https://www.typescriptlang.org/): Superset do JavaScript que adiciona tipagem estática ao código.
  - [Prisma ORM](https://www.prisma.io/): ORM utilizado para interagir com o banco de dados SQLite.
  - [SQLite](https://www.sqlite.org/index.html): Banco de dados relacional leve e incorporado.
  - [Zod](https://github.com/colinhacks/zod): Biblioteca de validação de esquemas para TypeScript e JavaScript.

- **Comunicação**:
  - [Axios](https://axios-http.com/): Cliente HTTP baseado em promessas para realizar requisições à API.
 
## 🎨 Layout do Projeto

Você pode visualizar o layout do projeto através [desse link](https://www.figma.com/community/file/1448070647757721748). É necessário ter conta no [Figma](http://figma.com/) para acessá-lo.

## 🌟 Funcionalidades

- **Exploração de Benefícios Próximos**: Descubra cupons e ofertas disponíveis em estabelecimentos próximos à sua localização.
- **Filtro dos Locais por Categorias**: Filtre os estabelecimentos próximos à sua localização por categorias.
- **Informações dos Estabelecimentos**: Obtenha informações de contato e endereço dos estabelecimentos participantes.
- **Resgate de Cupons**: Resgate cupons diretamente pelo aplicativo e utilize-os nos estabelecimentos participantes.

## 🛠️ Como Executar o Projeto

Para clonar e executar esta aplicação, você precisará ter o **Node.js**, **npm** (ou **yarn**) e o **Xcode** instalados no seu computador.

1. **Clonar este repositório:**

   ```bash
   git clone https://github.com/edusantsales/nearby.git
   ```

2. **Acessar o diretório do projeto:**

   ```bash
   cd nearby
   ```

### Backend:

1. **Acessar o diretório da aplicação back-end:**
   
    ```bash
   cd nearby-api
   ```

2. **Instalar as dependências do back-end:**

   ```bash
   npm install
   ```

3. **Iniciar o servidor back-end:**

   ```bash
   npm start
   ```

### Frontend (iOS):

1. **Acessar o diretório do aplicativo iOS:**

   ```bash
   cd nearby
   ```

2. **Abrir o projeto no Xcode:**

   ```bash
   open Nearby.xcodeproj
   ```

3. **Instalar as dependências do CocoaPods:**

   ```bash
   pod install
   ```

4. **Executar o aplicativo no simulador ou dispositivo físico através do Xcode.** 📱

## 📂 Estrutura do Projeto

- **backend/**: Contém o código-fonte do servidor Node.js com Express, incluindo as rotas da API, configurações do Prisma e validações com Zod.
- **ios/**: Contém o código-fonte do aplicativo iOS desenvolvido em Swift utilizando UIKit.

## 🎯 Aprendizados e Desafios

Durante o desenvolvimento deste projeto, foram adquiridos conhecimentos em:

- **Integração de Back-End e Front-End**: Aprendizado sobre como conectar um servidor Node.js com um aplicativo iOS.
- **Construção de Telas com UIKit**: Aprendizado sobre construção de telas e componentes, uso do auto layout e navegação entre telas usando UIKit.
- **Gerenciamento de Estado no iOS**: Implementação do padrão arquitetural MVVM-C para estruturar e gerenciar a aplicação de forma eficiente.
- **Linguagem de Programação Swift**: Utilização da linguagem de programação swift para estruturação e manuseio dos dados, além de recursos de gerenciamento de mémoria.
