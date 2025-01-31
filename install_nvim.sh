git clone --depth 1 https://github.com/folke/lazy.nvim.git ~/.config/nvim/lazy.nvim

#after conf 
nvim +Lazy sync

npm install -g pyright
go install golang.org/x/tools/gopls@latest
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
npm install -g vscode-json-languageserver
