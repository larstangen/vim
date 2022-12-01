source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set nocompatible              " be iMproved, required

" Begin of Vundle block
filetype off
"set shellslash
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/bundle/') 
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-surround'
Plugin 'simeji/winresizer'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vimwiki/vimwiki'

"Disabled plugins
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'plasticboyvim-markdown'
" Plugin 'xolox/vim-notes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
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
" End of Vundle block


""""""""""""""""""""""""""""""""
" keymaps "no space between keys for multi action sets
""""""""""""""""""""""""""""""""
let mapleader=","

" use F5 and ctrl+p to execute python file
nmap <F5> <Esc>:w<CR>:!python %<CR>
nmap <c-p> <Esc>:w<CR>:!python %<CR>
imap <F5> <Esc>:w<CR>:!python %<CR>
inoremap <c-p> <Esc>:w<CR>:!python %<CR>
"Change working directory to HOME
nnoremap <leader>gh :cd ~<cr>
"Replace local _vimrc with git version
nnoremap <leader>r :! python refreshvimrc.py
" using jj to get to Normal mode
imap jj <ESC>
" new line below by hitting ctrl+o and staying in Normal mode
" nmap <C-o> o<Esc>
" comment in python with ctrl + b
" uncomment in python with ctrl + b
nmap <c-b> I#<ESC>j  
" remove highlighting after searching
nnoremap <esc> :noh<return><esc>
" map leader + e to EOL
" nnoremap <leader>e $
" refresh vim from updated source file
nnoremap <leader>s :so $MYVIMRC<cr>
" open source vim file
nnoremap <leader>v :e $MYVIMRC<cr>
" quick action for adding single quotes and commas to line
" run :%normal ,j for whole file
nnoremap <leader>j I'<ESC>A',<ESC>j
" add brackets to entire file
nnoremap <leader>k ggI(<ESC>G$r)<ESC>
" split current line into rows based on spaces
nnoremap <leader>n :s/\s\+/\r/g<cr>
" remove trailing whitespaces
"nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR> 
" save file
nnoremap <leader>w :w<return>
" format json files
nnoremap <leader>f :set ft=javascript<cr>
" change working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>
"split pane navigation shortcuts
 nnoremap <C-J> <C-W><C-J>
 nnoremap <C-K> <C-W><C-K> 
 nnoremap <C-L> <C-W><C-L> 
 nnoremap <C-H> <C-W><C-H> 
"new vertical split
nnoremap <leader>nv :vnew<CR>
"new normal split
nnoremap <leader>ns :new<CR>
 
vnoremap . :norm.<CR>

""""""""""""""""""""""""""""""""
"display settings
""""""""""""""""""""""""""""""""
let g:vimwiki_hl_headers = 1
"set lines=35 columns=125 "window size
set guifont=Consolas:h9 "font an text size
colorscheme koehler " colorscheme
syntax on "syntax highlighting
set t_Co=256 "enable 256 colors
set number
" set relativenumber
set shiftwidth=4 "number of spaces to use for autoindenting
set tabstop=4
set smartcase "ignore case if search pattern is all lowercase, case-sensitive otherwise
set ignorecase
set incsearch "show search matches as you type
set splitbelow
set splitright
set showcmd
set spell spelllang=en_us
autocmd InsertEnter * setlocal spell
autocmd InsertLeave * setlocal nospell
set vb t_vb= "disable error bells
set wrap
set linebreak
set nolist
set textwidth=100
set ve+=onemore
"set colorcolumn=100
"highlight ColorColumn guibg=Green

""""""""""""""""""""""""""""""""
"backup settings
""""""""""""""""""""""""""""""""
set backupdir=$TEMP,$TMP,.
set directory=$TEMP,$TMP,.
set noundofile

" directory info
" tell vim to use parent file directory as current directory
set autochdir

" auto save and load folds
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview
"format json files
autocmd BufNewFile,BufRead *.json set ft=javascript

" set shell=C:\Program Files\Git\git-bash.exe

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
