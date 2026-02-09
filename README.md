# Gerador de Senhas

Aplicativo desktop em Delphi (VCL) para gerar senhas fortes, com opções de composição e múltiplos algoritmos de hash. A interface permite configurar o tamanho, selecionar conjuntos de caracteres e gerar senhas aleatórias ou hashes com semente.

## Funcionalidades

- Geração de senhas aleatórias com opções de caracteres (maiúsculas, minúsculas, números e especiais).
- Opção para evitar caracteres ambíguos com lista personalizável (ex.: `O/0`, `I/l/1`).
- Tamanho máximo configurável para o tamanho da senha.
- Configuração de tamanho mínimo, quantidade de senhas e regras obrigatórias por tipo.
- Histórico das senhas geradas com timestamp.
- Cópia automática para a área de transferência (opcional) com limpeza automática e cópia do último item do histórico.
- Indicador de força da senha com recomendações.
- Exportação e limpeza do histórico (TXT, CSV ou JSON).
- Preferências salvas automaticamente.
- Geração de hash com semente e algoritmos MD5, SHA-1, SHA-256 e SHA-512.
- Geração com fonte de aleatoriedade criptográfica quando disponível.

## Como usar

1. Abra o executável da aplicação.
2. Selecione o tamanho da senha, o mínimo e os tipos de caracteres desejados.
3. (Opcional) Marque as opções de evitar caracteres ambíguos e copiar automaticamente.
4. Clique em **Gerar Senha** para obter a senha e ver o histórico.
5. Para gerar hash, marque **Senha com HASH**, selecione o algoritmo, preencha senha e semente e clique em **Gerar Senha**.

## Estrutura do projeto

- `src/Main.pas`: lógica principal da aplicação.
- `src/Main.dfm`: layout do formulário e componentes visuais.
- `GeradorSenha.dproj` / `GeradorSenha.dpr`: arquivos do projeto Delphi.

## Requisitos

- Delphi (VCL) com os componentes utilizados no formulário.
