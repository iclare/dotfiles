" vim:fileencoding=utf-8:foldmethod=marker

filetype indent plugin on
syntax on

" Allow for per-machine and local overrides
let s:hostfile =
      \ $HOME .
      \ '/.config/nvim/host/' .
      \ substitute(hostname(), "\\..*", '', '') .
      \ '.vim'
if filereadable(s:hostfile)
  execute 'source ' . s:hostfile
endif
let s:vimrc_local=$HOME . '/.config/nvim/init.vim.local'
if filereadable(s:vimrc_local)
  execute 'source ' . s:vimrc_local
endif

"
" Settings {{{
"

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/.config/nvim/tmp/backup  " keep backup files out of the way
  set backupdir+=.
endif
set belloff=all                       " never ring the bell for any reason

" Highlight up to 255 columns
" let &l:colorcolumn='+' . join(range(0, 254), ',+')

set cursorline                        " highlight current line
set diffopt+=foldcolumn:0             " don't show fold column in diff view

if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/.config/nvim/tmp/swap//  " keep swap files out of the way
  set directory+=.
endif

set noemoji                           " don't assume all emoji are double width
set expandtab                         " always use spaces instead of tabs

set fillchars=diff:∙                  " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
set fillchars+=fold:·                 " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
set fillchars+=vert:┃                 " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
set fillchars+=eob:\                  " suppress ~ at EndOfBuffer

set foldmethod=indent                 " not as cool as syntax, but faster
set foldlevelstart=99                 " start unfolded
let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'
function! IclareFoldtext() abort
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction
set foldtext=IclareFoldtext()

set formatoptions+=j                  " remove comment leader when joining comment lines
set formatoptions+=n                  " smart auto-indenting inside numbered lists

set hidden                            " allows you to hide buffers with unsaved changes without being prompted
set inccommand=split                  " live preview of :s results

set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macro playback

set linebreak                         " wrap long lines at characters in 'breakat'

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set modelines=5                       " scan this many lines looking for modeline
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set number                            " show line numbers in gutter

set relativenumber                    " show relative numbers in gutter

set scrolloff=3                       " start scrolling 3 lines before edge of viewport
set shell=sh                          " shell to use for `!`, `:!`, `system()` etc.
set noshiftround                      " don't always indent by multiple of shiftwidth
set shiftwidth=2                      " spaces per tab (when shifting)
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=c                      " completion messages
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

let &showbreak='↳ '                   " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)

set noshowcmd                         " don't show extra info at end of command line

set sidescroll=0                      " sidescroll in jumps because terminals are slow
set sidescrolloff=3                   " same as scrolloff, but for columns
set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace

set softtabstop=-1                    " use 'shiftwidth' for tab/bs at end of line

set spellcapcheck=                    " don't check for capital letters at start of sentence

set splitbelow                        " open horizontal splits below current window
set splitright                        " open vertical splits to the right of the current window

set switchbuf=usetab                  " try to reuse windows/tabs when switching buffers

set synmaxcol=200                     " don't bother syntax highlighting long lines

set tabstop=2                         " spaces per tab
set termguicolors                     " use guifg/guibg instead of ctermfg/ctermbg in terminal

set textwidth=80                      " automatically hard wrap at 80 columns

if exists('$SUDO_USER')
  set noundofile                    " don't create root-owned files
else
  set undodir=~/.config/nvim/tmp/undo  " keep undo files out of the way
  set undodir+=.
  set undofile                      " actually use undo files
endif

set updatecount=80                    " update swapfiles every 80 typed chars
set updatetime=2000                   " CursorHold interval

let s:viminfo='main.shada'
if exists('$SUDO_USER')
  " Don't create root-owned files.
  execute 'set ' . s:viminfo . '='
else
  " Our overrides:
  " - '0 store marks for 0 files
  " - <0 don't save registers
  " - f0 don't store file marks
  " - n: store in ~/.config/nvim/shada/main.shada
  set shada="'0,<0,f0,n~/.config/nvim/shada/" . s:viminfo
  if !empty(glob('~/.config/nvim/shada/' . s:viminfo))
    if !filereadable(expand('~/.config/nvim/shada/' . s:viminfo))
      echoerr 'warning: ~/.config/nvim/shada/' . s:viminfo . ' exists but is not readable'
    endif
  endif
endif

set viewdir=~/.config/nvim/tmp/view   " override ~/.config/nvim/view default
set viewoptions=cursor,folds          " save/restore just these (with `:{mk,load}view`)

set virtualedit=block                 " allow cursor to move where there is no text in visual block mode
set visualbell t_vb=                  " stop annoying beeping for non-error errors
set whichwrap=b,h,l,s,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
set wildcharm=<C-z>                   " substitute for 'wildchar' (<Tab>) in macros
set wildignore+=*.o                   " patterns to ignore during file-navigation
set wildmenu                          " show options as list when switching buffers etc
set wildmode=longest:full,full        " shell-like autocomplete to unambiguous portion

"
" }}}
"

"
" Mappings {{{
"

let mapleader="\<Space>"
let maplocalleader="\\"

" Open last buffer.
nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <A-b> <S-Left>
cnoremap <A-f> <S-Right>

nnoremap Q <nop>

noremap Y y$

" Move between windows.

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

xnoremap <C-h> <C-w>h
xnoremap <C-j> <C-w>j
xnoremap <C-k> <C-w>k
xnoremap <C-l> <C-w>l

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

"
" }}}
"

"
" Autocmds {{{
"

function! s:IclareAutocmds()
  augroup IclareAutocmds
    autocmd!

    autocmd VimResized * execute "normal! \<c-w>="

    " http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
    autocmd VimEnter * autocmd WinEnter * let w:created=1
    autocmd VimEnter * let w:created=1

    " Disable paste mode on leaving insert mode.
    autocmd InsertLeave * set nopaste

    " Save/restore folds and cursor position.
    autocmd BufWritePost,BufLeave,WinLeave ?* if iclare#autocmds#should_mkview() | call iclare#autocmds#mkview() | endif
    autocmd BufWinEnter ?* if iclare#autocmds#should_mkview() | silent! loadview | execute 'silent! ' . line('.') . 'foldopen!' | endif
  augroup END
endfunction

call s:IclareAutocmds()

"
"}}}
"

"
" Plug {{{
"

call plug#begin('~/.config/nvim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'wincent/loupe'
Plug 'wincent/terminus'
call plug#end()

"
"}}}
"

"
" base16-vim {{{
"

let s:basesixteenshell = readfile(expand('~/.base16'), '', 2)
execute 'set background=' . s:basesixteenshell[1]
execute 'colorscheme base16-' . s:basesixteenshell[0]

hi Normal guibg=NONE ctermbg=NONE

"
"}}}
"

"
" loupe {{{
"

nmap <leader>n <Plug>(LoupeClearHighlight)

"
"}}}
"

