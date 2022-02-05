call plug#begin('~/.vim/plugged')

Plug 'pbondoer/vim-42header'

Plug 'preservim/nerdtree'

Plug 'NLKNguyen/papercolor-theme'

Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

call plug#end()
 
let g:hdr42user="plouvel"
let g:hdr42mail="plouvel@student.42.fr"

let mapleader = " "

" Easily navigate through panels

nnoremap <leader>h <C-W><Left>
nnoremap <leader>j <C-W><Down>
nnoremap <leader>k <C-W><Up>
nnoremap <leader>l <C-W><Right>

" Often used tab command

nnoremap <leader>p :tabp<CR>
nnoremap <leader>n :tabn<CR>
nnoremap <leader>c :w<CR>:tabclose<CR>

vnoremap <C-c> "+y
vnoremap <C-x> "+x
map <C-v> "+gP
map <C-e> $
map <C-a> ^
map <C-f> /

map <C-t>n :tabnew<CR>
map <C-t>l :tabl<CR>
map <C-t>f :tabr<CR>
map <F2> :NERDTreeToggle<CR>

set mouse=a								"Enable mouse
set number								"Show line numbers
set showcmd								"Show the last command in bottom bar
set wildmenu							"Visual autocompletion for command menu
set showmatch							"Highlight matching [{()}]
set ruler								"Always show cursor position
set list								"Enable lists
set listchars=tab:\>\-					"Show tabs
set foldmethod=syntax					"Fold based on indention levels
set foldcolumn=1						"Enable mouse to open and close folds
set nofoldenable						"Open files without closed folds

filetype indent on						"Enable indentation rules that are file-type specific
set tabstop=4							"Indent using four spaces
set softtabstop=4						"Number of spaces in <Tab>
set shiftwidth=4						"When shifting, indent using four spaces
set autoindent							"New lines inherit the indentation of previous lines
set smarttab							"Insert “tabstop” number of spaces with the “tab” key
set smartindent							"Do smart autoindenting when starting a new line

set backupdir=~/.cache/vim				"Directory to store backup files
set dir=~/.cache/vim					"Directory to store swap files

autocmd BufWinEnter *.c,*.h set cc=80	"Set colum max to 80 with .c and .h files.
syntax on

" #### POWERLINE ###

set rtp+=$HOME/.local/lib/python3.8/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set background=light
colorscheme PaperColor
