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

" }}}
" Mappings
" {{{

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

function! IclareClearRegisters() abort
  let l:regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for l:reg in l:regs
    call setreg(l:reg, [])
  endfor
endfunction
nnoremap <Leader>cr :call IclareClearRegisters()<CR>

function! IclareSubstitute(pattern, replacement, flags) abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, a:pattern, a:replacement, a:flags))
    let l:number=l:number + 1
  endfor
endfunction
nnoremap <silent> <Leader>zz :call IclareSubstitute('\s\+$', '', '')<CR>


" }}}
" Autocmds
" {{{

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

  augroup END
endfunction

call s:IclareAutocmds()

" }}}
" Plug
" {{{

call plug#begin('~/.config/nvim/plugged')
Plug 'AndrewRadev/dsf.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Yggdroot/indentLine'
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'kshenoy/vim-signature'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psliwka/vim-smoothie'
Plug 'simnalamburt/vim-mundo'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'tyru/caw.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/loupe'
Plug 'wincent/replay'
Plug 'wincent/terminus'
Plug 'wincent/vim-clipper'
call plug#end()

" }}}
" vim-clap
" {{{

" whichkey <leader>c - commands
" whichkey <leader>h - help
" whichkey <leader>l - lists
" whichkey <leader>m - mru
" whichkey <leader>r - ripgrep
" whichkey <leader>t - command-t
" whichkey <leader>j - jumps
nnoremap <leader>c :Clap command<cr>
nnoremap <leader>h :Clap help_tags<cr>
nnoremap <leader>j :Clap history<cr>
nnoremap <leader>l :Clap<cr>
nnoremap <leader>m :Clap history<cr>
nnoremap <leader>r :Clap grep2 --hidden<cr>
nnoremap <leader>t :Clap files --hidden<cr>

" }}}
" vista.vim
" {{{

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" whichkey: <leader>o - outline
nnoremap <leader>o :Vista!!<CR>

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
nmap <silent> gy <Plug>(coc-type-definition)
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
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup auformat
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType sh,vim,rust setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>Qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap iF <Plug>(coc-funcobj-i)
omap iF <Plug>(coc-funcobj-i)
xmap aF <Plug>(coc-funcobj-a)
omap aF <Plug>(coc-funcobj-a)
xmap iC <Plug>(coc-classobj-i)
omap iC <Plug>(coc-classobj-i)
xmap aC <Plug>(coc-classobj-a)
omap aC <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap <leader>F :Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <localleader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <localleader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <localleader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <localleader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <localleader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <localleader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <localleader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <localleader>p  :<C-u>CocListResume<CR>

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
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gC <Plug>(coc-git-commit)

" }}}
" coc-yank
" {{{

nnoremap <silent> <space>Y  :<C-u>CocList -A --normal yank<cr>

" }}}
" coc-lists
" {{{

" easier grep
" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction
" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" grep by motion
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

" grep current word in current buffer
nnoremap <silent> <space>W  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

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
" coc-actions
" {{{

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" }}}
" coc-explorer
" {{{

map <leader>e :CocCommand explorer<CR>

" }}}
" coc-rust-analyzer
" {{{

autocmd FileType rust nnoremap <leader>R :CocCommand rust-analyzer.run<CR>


" }}}
" vim-clipper
" {{{

call clipper#set_invocation('nc -U ~/.clipper.sock')

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
" vim-sneak
" {{{

let g:sneak#s_next = 1

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
