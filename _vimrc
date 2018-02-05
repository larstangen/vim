source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=$HOME/.vim/bundle/Vundle.vim/
"call vundle#begin('$HOME/.vim/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"Plugin 'python-mode/python-mode'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""
" keymaps "no space between keys for multi action sets
""""""""""""""""""""""""""""""""
let mapleader=","

" use F5 and ctrl+p to execute python file
nmap <F5> <Esc>:w<CR>:!python %<CR>
nmap <c-p> <Esc>:w<CR>:!python %<CR>
imap <F5> <Esc>:w<CR>:!python %<CR>
inoremap <c-p> <Esc>:w<CR>:!python %<CR>
" using jj to get to Normal mode
imap jj <ESC>
" new line below by hitting ctrl+o and staying in Normal mode
nmap <C-o> o<Esc>
" comment in python with ctrl + b
nmap <c-b> 0i#<ESC>  
" uncomment in python with ctrl + b
"nmap <C-S-B> 0x 
" remove highlighting after searching
nnoremap <esc> :noh<return><esc>
" map leader + e to EOL
nnoremap <leader>e $
nnoremap <leader>s :so $MYVIMRC<cr>
nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap <leader>j I'<ESC>A',<ESC>j


""""""""""""""""""""""""""""""""
"searching            
""""""""""""""""""""""""""""""""
set ignorecase

""""""""""""""""""""""""""""""""
"display settings
""""""""""""""""""""""""""""""""
set lines=35 columns=125 "window size
set guifont=Consolas:h9 "font and text size
colorscheme koehler "colorscheme
syntax on "syntax highlighting
filetype plugin indent on "get filetype automatically
set t_Co=256 "enable 256 colors
set number

""""""""""""""""""""""""""""""""
"backup settings
""""""""""""""""""""""""""""""""
set backupdir=$TEMP,$TMP,.
set directory=$TEMP,$TMP,.
set noundofile

" directory info
" tell vim to use parent file directory as current directory
set autochdir


" formatting
" set tab equal to four places
set tabstop=4


set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

