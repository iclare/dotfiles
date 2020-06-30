" Settings
" {{{

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

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode

let g:loaded_matchparen=1             " Don't need this annoyance when linting

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/.config/nvim/tmp/backup  " keep backup files out of the way
  set backupdir+=.
endif
set belloff=all                       " never ring the bell for any reason

" Margin highlight after 100 columns
let &l:colorcolumn=join(range(100, 254), ',')

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

set scrolloff=5                       " start scrolling 5 lines before edge of viewport
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
set sidescrolloff=5                   " same as scrolloff, but for columns
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

set shell=$SHELL                      " use zsh as default shell

" }}}
" Mappings
" {{{

let mapleader="\<Space>"
let maplocalleader="\\"

" Open last buffer.
nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>

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

function! IclareClearRegisters() abort
  let l:regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for l:reg in l:regs
    call setreg(l:reg, [])
  endfor
endfunction
nnoremap <localleader>c :call IclareClearRegisters()<CR>

function! IclareSubstitute(pattern, replacement, flags) abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, a:pattern, a:replacement, a:flags))
    let l:number=l:number + 1
  endfor
endfunction
nnoremap <silent> <Leader>Z :call IclareSubstitute('\s\+$', '', '')<CR>

" Show current file path
nnoremap <Leader>p :echo expand('%')<CR>

" Close all but the current window
nnoremap <Leader>O :only<CR>

" Edit an adjacent file
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" }}}
" Autocmds
" {{{

function! s:IclareVimTest()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

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

    " Save on focus loss
    autocmd FocusLost * :wa

    autocmd BufRead *.{vader,vim}
          \ command! -buffer Vt call s:IclareVimTest()
  augroup END
endfunction

call s:IclareAutocmds()

" }}}
" vim-plug
" {{{

call plug#begin('~/.config/nvim/plugged')
Plug 'AndrewRadev/dsf.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'kshenoy/vim-signature'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'simnalamburt/vim-mundo'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rsi'
Plug 'tyru/caw.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/loupe'
Plug 'wincent/replay'
Plug 'wincent/terminus'
Plug 'wincent/vim-clipper'
call plug#end()

" }}}
" vim-fugitive
" {{{

" show diff view
nnoremap <silent> <LocalLeader>dd :Gvdiffsplit!<CR>
" choose hunk from left
" choose hunk from right
nnoremap <silent> <LocalLeader>dh :diffget //2<CR>
nnoremap <silent> <LocalLeader>dl :diffget //3<CR>

" }}}
" vim-which-key
" {{{

nnoremap <silent> <leader>      :<c-u>WhichKey       '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey       '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual '\'<CR>


" }}}
" editorconfig-vim
" {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" }}}
" indentLine
" {{{

let g:indentLine_char = '⎸'

" }}}
" airline.vim
" {{{

set noshowmode
let g:airline_powerline_fonts = 1

" }}}
" base16-vim
" {{{

let s:basesixteenshell = readfile(expand('~/.base16'), '', 2)
execute 'set background=' . s:basesixteenshell[1]
execute 'colorscheme base16-' . s:basesixteenshell[0]
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" }}}
" loupe
" {{{

nmap <leader>n <Plug>(LoupeClearHighlight)

" }}}
" coc.nvim
" {{{

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-k> to trigger completion.
inoremap <silent><expr> <c-k> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)

augroup auformat
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType sh,vim,rust setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Apply AutoFix to problem on the current line.
nmap <localleader>f <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap <leader>f :Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
nnoremap <silent> <leader>C  :<C-u>CocList vimcommands<cr>
nnoremap <silent> <leader>a  :<C-u>CocList actions<cr>
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>g  :<C-u>CocList grep<cr>
nnoremap <silent> <leader>h  :<C-u>CocList helptags<cr>
nnoremap <silent> <leader>l  :<C-u>CocList<cr>
nnoremap <silent> <leader>m  :<C-u>CocList mru<cr>
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>t  :<C-u>CocList files<cr>

" To get correct comment highlighting in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" }}}
" coc-highlight
" {{{

autocmd CursorHold * silent call CocActionAsync('highlight')

" }}}
" coc-git
" {{{

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gS <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gC <Plug>(coc-git-commit)
nmap <leader>U :CocCommand git.chunkUndo<cr>

" }}}
" coc-yank
" {{{

nnoremap <silent> <leader>Y  :<C-u>CocList -A --normal yank<cr>

" }}}
" coc-snippets
" {{{

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" }}}
" coc-explorer
" {{{

map <leader>e :CocCommand explorer<CR>

" }}}
" coc-rust-analyzer
" {{{

autocmd FileType rust nnoremap <localleader>r :CocCommand rust-analyzer.run<CR>

" }}}
" coc-pairs
" {{{

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" }}}
" vim-clipper
" {{{

call clipper#set_invocation('nc -U ~/.clipper.sock')

" Copy current file path
nnoremap <Leader>P :let @0=expand('%') <Bar> :Clip<CR> :echo expand('%')<CR>

" }}}
" vim-sandwhich
" {{{

" like vim-surround
runtime macros/sandwich/keymap/surround.vim
let g:sandwich#recipes += [
      \   {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
      \   {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
      \   {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
      \   {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['{']},
      \   {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['[']},
      \   {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['(']},
      \ ]

" }}}
" vim-easy-align
" {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" vim-mundo
" {{{

nnoremap <leader>u :MundoToggle<CR>

" }}}
" vim-expand-region
" {{{

map + <Plug>(expand_region_expand)
map _ <Plug>(expand_region_shrink)

" }}}
" vim-operator-replace
" {{{

map - <Plug>(operator-replace)

" }}}
" dsf.vim
" {{{

let g:dsf_no_mappings = 1

nmap dsf <Plug>DsfDelete
nmap csf <Plug>DsfChange

nmap dsnf <Plug>DsfNextDelete
nmap csnf <Plug>DsfNextChange

omap af <Plug>DsfTextObjectA
xmap af <Plug>DsfTextObjectA
omap if <Plug>DsfTextObjectI
xmap if <Plug>DsfTextObjectI

" }}}
" vim:fileencoding=utf-8:foldmethod=marker
