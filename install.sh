#!/usr/bin/env bash
export PATH=usr/local/bin:$PATH # Put user installed binaries at front of path
brew install vim
brew install ctags
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/dense-analysis/ale.git
git clone https://github.com/psf/black.git
git clone https://github.com/junegunn/fzf.git
git clone https://github.com/junegunn/fzf.vim.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/python-mode/python-mode.git
git clone https://github.com/gu-fan/simpleterm.vim.git
git clone https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/vim-vdebug/vdebug.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/tpope/vim-dadbod.git
git clone https://github.com/tpope/vim-dispatch.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/ludovicchabant/vim-gutentags.git
git clone https://github.com/aquach/vim-http-client.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/tpope/vim-obsession.git
git clone https://github.com/prettier/vim-prettier.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/janko/vim-test.git
git clone https://github.com/mattn/webapi-vim.git
git clone https://github.com/ycm-core/YouCompleteMe.git
git clone https://github.com/fatih/vim-go.git
