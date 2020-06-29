" install latest version of vim:
" git clone https://github.com/vim/vim.git
" cd vim/
" ./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=/usr/local/Cellar/python/3.7.0/Frameworks/Python.framework/Versions/3.7/lib/python3.7/config-3.7m-darwin/ --enable-cscope --enable-rubyinterp
" make
" sudo make install
"
" install ctags (I installed it in ~/MyLibraries/):
" wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
" tar -zxvf ctags-5.8.tar.gz
" cd ctags-5.8 && ./configure && make && sudo make install
"
" install pathogen:
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" install plugins:
" cd ~/.vim/bundle
" git clone https://github.com/vim-scripts/syntastic.git
" git clone https://github.com/morhetz/gruvbox.git
" git clone git://github.com/tpope/vim-fugitive.git
" git clone https://github.com/vim-airline/vim-airline
" git clone https://github.com/vim-airline/vim-airline-themes
" git clone https://github.com/majutsushi/tagbar
" git clone https://github.com/airblade/vim-gitgutter
" git clone https://github.com/jreybert/vimagit
" git clone https://github.com/sjbach/lusty
" vim -u NONE -c "helptags vim-fugitive/doc" -c q

" my leader is space:
let mapleader = "\<Space>"
" my local leader is comma (if we didn't do this then comma would reverse the
" direction of the previous t T f F command)
let maplocalleader = ','

" this downloads vim-plug if its missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

silent! if plug#begin()
    Plug       'morhetz/gruvbox'
    Plug   'davidhalter/jedi-vim'
    Plug        'sjbach/lusty'
    Plug      'jalvesaq/Nvim-R'
    Plug 'vim-syntastic/syntastic'
    Plug     'godlygeek/tabular'
    Plug    'majutsushi/tagbar'
    Plug      'jalvesaq/vimcmdline'
    Plug   'vim-airline/vim-airline'
    Plug   'vim-airline/vim-airline-themes'
    Plug         'tpope/vim-fugitive'
    Plug      'airblade/vim-gitgutter'
    Plug      'jreybert/vimagit'
    Plug         'tpope/vim-surround'

  call plug#end()
endif

set nowrap
set ai
set history=750
set undolevels=750
set iskeyword+=_,$,@,%,#,-
syntax on
set hlsearch
set number
filetype plugin on
set mouse=a
set foldmethod=indent
set foldlevel=20

" toggle displaying and hiding numbers with <leader>n
nnoremap <leader>n :set number!<CR>

" mapping jk to esc so it is easy to escape
:inoremap jk <esc>
:vnoremap jk <esc>

" remap vv to :vsplit
nnoremap <silent> vv <C-w>v

" mapping ff to :x (save and exit)
nnoremap ff :x<cr>

" from http://vim.wikia.com/wiki/search_for_visually_selected_text
" use // to search selection in visual mode
vnoremap // y/<c-r>"<cr>

" yank to clipboard from visual mode
vnoremap <c-y> "*y
" paste from clipboard from visual mode
nnoremap <c-p> "*p

" easy access to .vimrc
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" mapping the arrow keys so I dont use them anymore (in order to get used to
" hjkl)
no <down> ddp
no <up> ddkP
no <left> <Nop>
no <right> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" insert user name and timestamp and go into insert mode
nnoremap <C-c>d :r !whoami<CR>$a <esc>"=strftime('%c')<C-M>p0i#' <esc>o
inoremap <C-c>d <esc>:r !whoami<CR>$a <esc>"=strftime('%c')<C-M>p0i#' <esc>o

" moving around splits with jhkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" moving around splits with arrows
nnoremap <Leader><Right> <C-w>l
nnoremap <Leader><Left> <C-w>h
nnoremap <Leader><Up> <C-w>k
nnoremap <Leader><Down> <C-w>j
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :xa<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
nnoremap <Leader>qq :q<CR>

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif
set cursorline

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set noerrorbells
set visualbell
set backspace=indent,eol,start

" I think there is no mor 
"execute pathogen#infect()

set term=xterm-256color
set background=dark
" colorscheme mustang
colorscheme gruvbox

set nobackup
set nowritebackup
set noswapfile

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['pyflakes']

map <leader>t :TagbarToggle<CR>
map <leader>e :copen<CR>
map <leader>ee :cc<CR>
map <leader>en :cnext<CR>
map <leader>mm :set mouse=a<CR>
map <leader>me :set mouse=v<CR>
hi SpellBad cterm=underline ctermbg=red ctermfg=black
let g:tagbar_left = 1


set noruler
set laststatus=2

" make vim updates more frequent. maybe a performance bottleneck?
set updatetime=250


" Git stuff
nnoremap <Leader>m :Magit<CR>

" Jedi stuff
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = "2"
let g:jedi#use_splits_not_buffers = "bottom"

" toggle autopopup on an off (useful when files are big)
function TogglePopup()
    let popup_status = g:jedi#popup_on_dot
    if popup_status == 0
        let g:jedi#popup_on_dot = 1
    else
        let g:jedi#popup_on_dot = 0
    endif
endfunction
nnoremap <leader>. :call TogglePopup()<cr>

" buffer explorer stuff
nnoremap <Leader>O :LustyFilesystemExplorer <CR>
nnoremap <Leader>o :LustyFilesystemExplorerFromHere <CR>
nnoremap <Leader>be :LustyBufferExplorer <CR>
nnoremap <Leader>bg :LustyBufferGrep <CR>

set hidden

:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" autocomplete when pressed tab
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.rules set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake

" insert template rule
" credit to: Paolo Tedesco (https://stackoverflow.com/a/690439/7115450)
function! Rule()
    r~/.templates/rule.txt
endfunction

nnoremap <C-N> :call Rule()<CR>


" -----------------------------------------------------------------
" }}} Nvim-R {{{  #  turn vim into an R environment
" -----------------------------------------------------------------

let R_assign=0 " dont replace _ with <-, i am a big boy

let R_buffer_opts = ""

" remapping the basic :: send line
nmap \ <Plug>RDSendLine
" remapping selection :: send multiple lines
vmap \ <Plug>RDSendSelection
" remapping selection :: send multiple lines + echo lines
vmap \e <Plug>RESendSelection

" run entire paragraph and jump to the line after the paragraph
nmap \\ <localleader>pp }

" -----------------------------------------------------------------
"  Tag setup for R
" -----------------------------------------------------------------
" adopted from: https://github.com/majutsushi/tagbar/wiki#r
" If you use this make sure to refer to the link and make the proper
" adjustments to the ~/.ctags file.
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" -----------------------------------------------------------------
" }}} vim-airline {{{  # beefs the status bar
" -----------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1


" vim-latex setup
let g:tex_flavor='latex'
" Setting lacheck for checking latex because chktex gives too many warnings
" See https://tex.stackexchange.com/a/425501
let g:syntastic_tex_checkers = ['lacheck']

:tnoremap <Esc><Esc> <C-\><C-n>
:tnoremap jk <C-\><C-n>

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
