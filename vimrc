call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'pmsorhaindo/syntastic-local-eslint.vim'
Plug 'Yggdroot/indentLine'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'tpope/vim-bundler'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/matchit.zip'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'ternjs/tern_for_vim'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-tbone'
Plug 'pmeinhardt/thrasher'

" Syntaxes
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'isRuslan/vim-es6'
Plug 'plasticboy/vim-markdown', { 'for': 'mkd' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'chase/vim-ansible-yaml', { 'for': 'ansible' }
Plug 'lambdatoast/elm.vim'
Plug 'vim-scripts/VimClojure'
Plug 'rust-lang/rust.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Themes
Plug 'junegunn/seoul256.vim'
Plug 'gregsexton/Muon'
Plug 'vim-scripts/256-grayvim'
Plug 'croaker/mustang-vim'
Plug 'CruizeMissile/Revolution.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'reedes/vim-colors-pencil'
Plug 'scwood/vim-hybrid'
Plug 'Lokaltog/vim-distinguished'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Productivity
Plug 'mnick/vim-pomodoro'

" JavaScript setup

call plug#end()

" ---------------------------------------------------------------------------
" Global file type settings
" ---------------------------------------------------------------------------

set encoding=utf-8
set nocompatible

set nofoldenable
set number
set showmatch
set ignorecase
set hlsearch
set title
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set noswapfile
set pastetoggle=<C-\>
set guioptions-=r
set guioptions-=L
set tw=80

" ---------------------------------------------------------------------------
" Local file type settings
" ---------------------------------------------------------------------------
" autocmd FileType javascript setlocal shiftwidth=4 tabstop=4

cnoremap <SPACE><SPACE> <ENTER>
inoremap jj <esc>
nnoremap ; :

" re-open read-only files with sudo
cnoremap w!! w !sudo sh -c "cat > %"

" code search with zeal
nnoremap gz :!zeal --query "<cword>"&<CR><CR>

" window navigation
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
"nnoremap <tab> <c-w>w
"nnoremap <S-tab> <c-w>W

nnoremap <tab> gt
nnoremap <S-tab> gT

" ----------------------------------------------------------------------------
" syntastic setup
" ----------------------------------------------------------------------------

let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['python', 'javascript', 'jsx' ],
                            \ 'passive_filetypes': [] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
let g:syntastic_javascript_checkers = ['eslint']

" let g:airline#extensions#tabline#enabled = 1
" let g:airline_section_y = '#%{bufnr("%")}'
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" show max 30 search results (default is 10)
let g:ctrlp_match_window = 'max:30'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.bundle$',
  \ 'file': 'tags$',
  \ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" ----------------------------------------------------------------------------
" general setup
" ----------------------------------------------------------------------------

nnoremap <C-N> :NERDTreeToggle<CR>

nnoremap <C-A> :Ack!<space>

syntax enable
set t_Co=256
colorscheme OceanicNext
set background=dark

nnoremap <F5> :GundoToggle<CR>
nnoremap <C-E> :TagbarToggle<CR>
map <C-c> "+y<CR>

set noshowmode
let g:airline_powerline_fonts = 1
let g:limelight_conceal_ctermfg = 1

" remove white space on save
autocmd BufWritePre * :%s/\s\+$//e

" file type tweaks
au BufRead,BufNewFile *.hamlc set ft=haml

" ----------------------------------------------------------------------------
" <F6> | Color scheme selector
" ----------------------------------------------------------------------------
function! s:rotate_colors()
	if !exists('s:colors_list')
		let s:colors_list =
					\ sort(map(
					\ filter(split(globpath(&rtp, "colors/*.vim"), "\n"), 'v:val !~ "^/usr/"'),
					\ "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"))
	endif
	if !exists('s:colors_index')
		let s:colors_index = index(s:colors_list, g:colors_name)
	endif
	let s:colors_index = (s:colors_index + 1) % len(s:colors_list)
	let name = s:colors_list[s:colors_index]
	execute 'colorscheme' name
	redraw
	echo name
endfunction
nnoremap <F6> :call <SID>rotate_colors()<cr>

" TODO make this work :)
function! Pandoc()
	let l:from = expand("%:p")
	let l:to = expand("%:p:r")
	!pandoc expand("%:p") -o expand("%:p:r")
endfunction

function! SeeAll()
  if !exists("g:SeeTabEnabled")
    let g:SeeTabEnabled = 1
    let g:SeeTab_list = &list
    let g:SeeTab_listchars = &listchars
    set listchars=tab:\|\·,trail:~,extends:>,precedes:<,space:\·
    set list
  else
    let &list = g:SeeTab_list
    let &listchars = &listchars
    silent! exe "hi ".substitute(g:SeeTabSpecialKey,'xxx','','e')
    unlet g:SeeTabEnabled g:SeeTab_list g:SeeTab_listchars
  endif
endfunc
com! -nargs=0 SeeAll :call SeeAll()

" Duration of a pomodoro in minutes (default: 25)
let g:pomodoro_time_work = 25
"
" " Duration of a break in minutes (default: 5)
let g:pomodoro_time_slack = 5
"
" " Log completed pomodoros, 0 = False, 1 = True (default: 0)
let g:pomodoro_do_log = 0
"
" " Path to the pomodoro log file (default: /tmp/pomodoro.log)
let g:pomodoro_log_file = "/tmp/pomodoro.log"
set statusline=%#ErrorMsg#%{PomodoroStatus()}%#StatusLine#
