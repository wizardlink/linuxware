"   =======
" [ GENERAL ]
"   =======
" This section is dedicated to general settings of the editor.

" Set the encoding
set encoding=utf8
scriptencoding utf8

" Set true colors
set termguicolors

" Set the EOL 'style'
set fileformat=unix

" Set the locale
try
	lang en_US
catch
endtry

" Disable unsafe commands
set secure

" Add subfolders in the path
set path+=**

" Automatically set the directory to the buffer's directory
set autochdir

" Add confirmation dialog when quitting if there are unsaved changes
set confirm

try
	set undodir=~/.config/nvim/undo
	set undofile

	set backupdir=~/.config/nvim/backup
	set backup

	set directory=~/.config/nvim/swap
catch
endtry

"   =======
" [ PLUGINS ]
"   =======
" Section dedicated to plugins and their configurations.

" Initialize plugin manager (vim-plug)
call plug#begin('/etc/nvim/plugins')

" <coc.nvim>
Plug 'neoclide/coc.nvim' " Core plugin
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install --frozen-lockfile'}       " Elixir
Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}         " SQL
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}            " CSS
Plug 'neoclide/coc-eslint', { 'do': 'yarn install --frozen-lockfile' }       " ESLint
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}       " TypeScript
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}           " JSON
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}           " HTML
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}      " Highlighting

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <a-cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Interactive finder
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

" Comment out lines in any* language
Plug 'tpope/vim-commentary'

" Integrate VIM (https://editorconfig.org/)
Plug 'editorconfig/editorconfig-vim'

" Collection of language packs for highlighting
Plug 'sheerun/vim-polyglot'

" Godot syntax highlighting + folding & running scenes
Plug 'habamax/vim-godot'

" HTML5 snippets
Plug 'mattn/emmet-vim' " Snippets

" Configurable statusline
Plug 'itchyny/lightline.vim'

" Configure the statusline
let g:lightline =
			\{
			\ 'colorscheme': 'dracula',
			\ 'component': {
			\   'lineinfo': ' %3l:%-2v',
			\ },
			\ 'component_function': {
			\   'readonly': 'LightlineReadonly',
			\   'fugitive': 'LightlineFugitive'
			\ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' }
			\}

" Helper functions
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

" Dracula colorscheme
Plug 'dracula/vim'

" Make the background 'transparent'
let g:dracula_colorterm=0

" Markdown visualizer
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" specify browser to open preview page
let g:mkdp_browser = 'firefox'

" Graphical debugger
Plug 'puremourning/vimspector'

" Enable default mappings
let g:vimspector_enable_mappings = 'HUMAN'

" Stops the plugin manager
call plug#end()

" Re-enables filetype
filetype plugin indent on    " required! re-enables filetype

"   =========
" [ INTERFACE ]
"   =========
" Section dedicated to configurations that are related to the interface.

" Set the matches for insert mode completion
set complete=.,w,b,u,kspell

" List of options for insert mode completion
set completeopt=longest,menuone,preview,noselect

" Remove ins-complete-menu messages
set shortmess+=c

" Enable hidden buffers, so when quitting a window the buffer stays listed
set hidden

" Sets the behaviour of backspace
set backspace=indent,eol,start

" Ignore case in search patterns
set ignorecase

" Keep the cursor in the same column when moving around
set nostartofline

" Disable line wrapping (visual)
set nowrap

" When splitting windows vertically, put it to the right of the current one
set splitright

" Show completion options on command-line
set wildmenu

" Showcase line numbers relative to current
" 'set number' makes it so the current line shows it's 'true' line number
set number
set relativenumber

" Sets the fold method based on syntax highlight
set foldmethod=syntax

" Shows a column with signs in the left, in case there is any
set signcolumn=auto

" Disable screen redraw while executing commands that haven't been typed
set nolazyredraw

" Don't show current mode in the command-line
set noshowmode

" Override the 'ignorecase' option if it contains upper case characters
set smartcase

" Jumps to nearest search result if there are any
if exists("+incsearch")
	set incsearch
endif

" Set the background 'theme' to dark
set background=dark


" Set a colorscheme if the terminal has colors
if &t_Co > 2 || has("gui_running")
	try
		colorscheme dracula
		" Sets colorscheme
	catch /^Vim\%((\a\+)\)\=:E185/
		" Not available
	endtry
endif

" Enables syntax highlighting if feature is installed
if exists("+syntax")
	syntax on

	" More accurately highlight file
	syntax sync fromstart
endif

" When searching a previous search pattern, highlight all its matches
if exists("+hlsearch")
	set hlsearch
endif

" Enable visual characters for eol, tab, etc
set list

" Set visual characters for eol, tab, etc
set listchars=tab:›–,eol:¶,extends:‹,precedes:‡

" Shows matching brackets when hovering with cursor
set showmatch

" Always show the statusline
set laststatus=2

" Show (partial) command in the last line of the screen
if exists("+showcmd")
	set showcmd
endif

"   ==================
" [ INDENTATION & TEXT ]
"   ==================
" Section dedicated to configurations that are related to indentation and text
" manipulation.

" Indent based on the lines around
set autoindent

" Include angle brackets in matching pairs
set matchpairs+=<:>

" Insert only a single space after punctuation when using join commands
set nojoinspaces

" Adds support for formatting numbered/bullet lists
set formatoptions+=n

" Defaults to tab identation with length of four
set expandtab    " always use spaces
set shiftwidth=2
"set tabstop=4

" Insert smartly the indentation according shiftwidth
if exists("+smarttab")
	set smarttab
endif

" 
if exists("+smartindent")
	set smartindent
endif

"   =========
" [ SHORTCUTS ]
"   =========
" Section dedicated to adding shortcuts

" Set the <leader> to a better key
let mapleader=","

" Change between dark and light backgrounds
function ChangeBackground()
	if &background ==# 'dark'
		set background=light
	elseif &background ==# 'light'
		set background=dark
	endif
endfunction

" Map the function a shortcut
nmap <silent> <leader>tc :call ChangeBackground()<cr>

" Enable spell checking
map <leader>sc :setlocal spell!<cr>

" Remove highlights more quickly
nmap <silent> <leader>n :noh<cr>

" Open NETRW
nnoremap <silent> <leader>t :Vexplore<cr>

" Location list shortcuts
nnoremap <silent> <leader>lo :lopen<cr>
nnoremap <silent> <leader>lc :lclose<cr>
nnoremap <silent> <leader>ln :lnext<cr>
nnoremap <silent> <leader>lp :lprevious<cr>

" <coc.nvim>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" vim-clap
nmap <silent> <leader>vf :Clap files<cr>
nmap <silent> <leader>vg :Clap grep<cr>
nmap <silent> <leader>vm :Clap marks<cr>
