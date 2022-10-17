" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: plouvel <marvin@42.fr>                     +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/06/01 17:59:19 by plouvel           #+#    #+#              "
"    Updated: 2022/10/17 11:58:28 by plouvel          ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'https://github.com/morhetz/gruvbox'

Plug 'NLKNguyen/papercolor-theme'

Plug 'powerline/powerline'

Plug 'ycm-core/YouCompleteMe'

Plug 'https://github.com/42Paris/42header'

"  Plug 'jeaye/color_coded'

Plug 'https://github.com/preservim/nerdcommenter'

Plug 'airblade/vim-gitgutter'

Plug 'vim-utils/vim-man'

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

set backspace=indent,eol,start

set backupdir=~/.cache/vim				"Directory to store backup files
set dir=~/.cache/vim					"Directory to store swap files

autocmd BufWinEnter *.c,*.h set cc=80	"Set colum max to 80 with .c and .h files.
syntax on

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

augroup QuickNotes
    autocmd!
    autocmd BufWinLeave *.md execute "mkview! " . expand('<afile>:p:h') . "/." . expand('<afile>:t') . ".view"
    autocmd BufWinEnter *.md execute "silent! source " . expand('%:p:h') . "/." . expand('%:t') . ".view"
augroup END

let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" #### POWERLINE ###

set rtp+=$HOME/.local/lib/python3.10/site-packages/powerline/bindings/vim

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

let g:gruvbox_italicize_comments='1'
let g:gruvbox_contrast_light='hard'
set bg=light

colorscheme gruvbox

function! IHeader(Title)
	let str = a:Title
	let strlen = len(a:Title)
	let sharp_c = 80 - 8 - strlen
	let i = 0

	execute ':normal! A' . "/* "
	while i < sharp_c / 2
		execute ':normal! A' . "#"
		let i += 1
	endwhile

	execute ':normal! A' . " "
	execute ':normal! A' . a:Title 
	execute ':normal! A' . " "
	let i = 0
	while i < sharp_c / 2
		execute ':normal! A' . "#"
		let i += 1
	endwhile

	if strlen % 2 != 0
		execute ':normal! A' . "#"
	endif

	execute ':normal! A' . " */"
endfunction
command! -nargs=1 IHeader call IHeader(<f-args>)

function! CoplienClass(ClassName)
	" Header file                                                       

	let header = a:ClassName.".hpp"
	execute "e ".a:ClassName.".hpp"
	redir => stdheader_output
	silent :Stdheader
	redir END

	call append(0, stdheader_output)
	call append(13,"#ifndef ".toupper(a:ClassName)."_CLASS_H")
	call append(14,"# define ".toupper(a:ClassName)."_CLASS_H")
	call append(15," ")
	call append(16,"class	".a:ClassName )
	call append(17, "{")
	call append(18,  "")
	call append(19, "	public:")
	call append(20, "")
	call append(21, "		".a:ClassName."(void);")
	call append(22, "		".a:ClassName."(".a:ClassName." const & src);")
	call append(23, "		~".a:ClassName."(void);")
	call append(24, "")
	call append(25, "		".a:ClassName." &	operator=(".a:ClassName." const & rhs);")
	call append(26,  "")
	call append(27, "	private:")
	call append(28,  "")
	call append(29,  "")
	call append(30, "};")
	call append(31, "")
	call append(32,"#endif // ".toupper(a:ClassName)."_CLASS_H")                                                              
	:execute 'w'

	" Source File (.cpp)

	let src    = a:ClassName.".cpp"
	execute "vsp ".a:ClassName.".cpp"
	redir => stdheader_output
	silent :Stdheader
	redir END

	call append(0, stdheader_output)
	call append(13,"#include \"".a:ClassName.".hpp\"")
	call append(14,"// #include <iostream>")
	call append(15,"")
	call append(16,a:ClassName."::".a:ClassName."()")
	call append(17,"{")
	call append(18,"	// std::cout << \"".a:ClassName." default constructor called.\" << std::endl;")
	call append(19,"}")
	call append(20,"")
	call append(21,a:ClassName."::".a:ClassName."(".a:ClassName." const & src)")
	call append(22,"{")
	call append(23,"	// std::cout << \"".a:ClassName." copy constructor called.\" << std::endl;")
	call append(24,"}")
	call append(25,"")
	call append(26,a:ClassName."::~".a:ClassName."()")
	call append(27,"{")
	call append(28,"	// std::cout << \"".a:ClassName." destructor called.\" << std::endl;")
	call append(29,"}")
	call append(30,"")
	call append(31, "".a:ClassName." &	".a:ClassName."::operator=(".a:ClassName." const & rhs)")
	call append(32,"{")
	call append(33,"	// std::cout << \"".a:ClassName." assignement overload called.\" << std::endl;")
	call append(34,"}")
	:execute 'w'
endfunction
command! -nargs=1 CoplienClass call CoplienClass(<f-args>)

function! InterfaceClass(ClassName)
	" Header file                                                       

	let header = "I".a:ClassName.".hpp"
	execute "e I".a:ClassName.".hpp"

	redir => stdheader_output
	silent :Stdheader
	redir END

	call append(0, stdheader_output)
	call append(13,"#ifndef I".toupper(a:ClassName)."_CLASS_H")
	call append(14,"# define I".toupper(a:ClassName)."_CLASS_H")
	call append(15," ")
	call append(16,"class	I".a:ClassName )
	call append(17, "{")
	call append(18,  "")
	call append(19, "	public:")
	call append(20, "")
	call append(21, "};")
	call append(22,"#endif // I".toupper(a:ClassName)."_CLASS_H")                                                              
	:execute 'w'
endfunction
command! -nargs=1 InterfaceClass call InterfaceClass(<f-args>)
