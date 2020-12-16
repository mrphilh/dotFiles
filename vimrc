set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" added nerdtree
Plug 'scrooloose/nerdtree'
"
" You Complete me autocompleter
"Plug 'Valloric/YouCompleteMe'

"Rust Autocomplete
Plug 'racer-rust/vim-racer'

Plug 'airblade/vim-rooter'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'

" Syntax highlighting
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'Docker/Docker'
Plug 'vim-scripts/groovy.vim'
Plug 'chriskempson/base16-vim', {'do': 'git checkout dict_fix'}
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'mattn/webapi-vim'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" All of your Plugins must be added before the following line
call plug#end()            " required

filetype plugin indent on    " required

set encoding=UTF-8
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number

set list
set listchars=tab:!·,trail:·

autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

colorscheme base16-brewer
let g:python_highlight_all = 1
" Rust formating
let g:rustfmt_autosave = 1
"Syntastic config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Key Shortcuts
map <leader>n :NERDTreeToggle<CR>
nmap <leader>t :FZF<CR>
"Highlighting nonsense
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"Powerline configs
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
" misc settings
highlight clear LineNr
highlight clear SignColumn

" Ale configuration
let g:racer_cmd = "/home/p/.cargo/bin/racer"
"let g:ale_completion_enabled = 1
let g:racer_experimental_completer=1
let g:ale_python_auto_pipenv=1
let g:ale_linters = {
\   'python':['pycodestyle'],
\   'rust': ['analyzer'],
\   'go':['go-langserver'],
\}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
