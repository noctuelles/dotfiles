call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'NLKNguyen/papercolor-theme'

Plug 'powerline/powerline'

Plug 'ycm-core/YouCompleteMe'

Plug 'https://github.com/42Paris/42header'

call plug#end()
 
let mapleader = " "

" Easily navigate through panels

let g:mail42 = 'plouvel@student.42.fr'

nnoremap <leader>h <C-W><Left>
nnoremap <leader>j <C-W><Down>
nnoremap <leader>k <C-W><Up>
nnoremap <leader>l <C-W><Right>

" Easy comment !

nnoremap <leader>cl ma^i//<ESC>`a
nnoremap <leader>cd ma^2x<ESC>`a
nnoremap <leader>s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap <leader>S :exec "normal a".nr2char(getchar())."\e"<CR>

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
set foldcolumn=1						"Enable mouse to open and close folds
set nofoldenable						"Open files without closed folds

filetype indent on						"Enable indentation rules that are file-type specific
set tabstop=4							"Indent using four spaces
set shiftwidth=4						"When shifting, indent using four spaces
set autoindent							"New lines inherit the indentation of previous lines
set smarttab							"Insert “tabstop” number of spaces with the “tab” key
set smartindent							"Do smart autoindenting when starting a new line

set backupdir=~/.cache/vim				"Directory to store backup files
set dir=~/.cache/vim					"Directory to store swap files

autocmd BufWinEnter *.c,*.h set cc=80	"Set colum max to 80 with .c and .h files.
syntax on

let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" #### POWERLINE ###

set rtp+=$HOME/.local/lib/python3.8/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set background=light
colorscheme PaperColor

function! Class(ClassName)                                                                                              
    "==================  editing header file =====================                                                       
     let header = a:ClassName.".hpp"
     :vsp %:h/.hpp
     call append(0,"#ifndef ".toupper(a:ClassName)."_CLASS_H")
     call append(1,"#define ".toupper(a:ClassName)."_CLASS_H")
     call append(2," ")
     call append(3,"class ".a:ClassName )
     call append(4, "{")
     call append(5, "	public:")
	 call append(6, "")
     call append(7, "		".a:ClassName."(void);")
	 call append(8, "		".a:ClassName."(".a:ClassName." const & src);")
     call append(9, "		~".a:ClassName."(void);")
	 call append(10, "")
	 call append(11, "		".a:ClassName." &	operator=(".a:ClassName." const & rhs);")
	 call append(12,  "")
     call append(13, "	private:")
     call append(14, "};")
     call append(15,"#endif // ".toupper(a:ClassName)."_CLASS_H")                                                              
     :execute 'write' header                                                                                             
   "================== editing source file ========================                                                      
     let src    = a:ClassName.".cpp"
     :vsp %:h/.cpp
     call append(0,"#include \"".a:ClassName.".hpp\"")
     call append(1,"")
     call append(2,a:ClassName."::".a:ClassName."()")
     call append(3,"{")
     call append(4,"//ctor ")
     call append(5,"}")
     call append(6,"")
     call append(7,"")
     call append(8,a:ClassName."::~".a:ClassName."()")
     call append(9,"{")
     call append(10,"//dtor ")
     call append(11,"}")
     :execute 'write' src
endfunction
