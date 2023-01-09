" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: plouvel <marvin@42.fr>                     +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/06/01 17:59:19 by plouvel           #+#    #+#              "
"    Updated: 2023/01/09 11:48:17 by plouvel          ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'https://github.com/morhetz/gruvbox'

Plug 'powerline/powerline'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'pantharshit00/vim-prisma'

Plug 'https://github.com/42Paris/42header'

call plug#end()

let mapleader = " "

" Easily navigate through panels

let g:user42 = 'plouvel'
let g:mail42 = 'plouvel@student.42.fr'

nnoremap <leader>h <C-W><Left>
nnoremap <leader>j <C-W><Down>
nnoremap <leader>k <C-W><Up>
nnoremap <leader>l <C-W><Right>

" Often used tab command

nnoremap <leader>p :tabp<CR>
nnoremap <leader>n :tabn<CR>
nnoremap <leader>c :w<CR>:tabclose<CR>

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
set foldcolumn=1						"Enable mouse to open and close folds
set nofoldenable						"Open files without closed folds

filetype indent on						"Enable indentation rules that are file-type specific
set tabstop=4							"Indent using four spaces
set shiftwidth=4						"When shifting, indent using four spaces
set autoindent							"New lines inherit the indentation of previous lines
set listchars=tab:>-
set smarttab							"Insert “tabstop” number of spaces with the “tab” key
set smartindent							"Do smart autoindenting when starting a new line

set backspace=indent,eol,start

set backupdir=~/.cache/vim				"Directory to store backup files
set dir=~/.cache/vim					"Directory to store swap files

autocmd BufWinEnter *.c,*.h set cc=80	"Set colum max to 80 with .c and .h files.
syntax on

" COC.NVIM
"
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-clangd', 'coc-docker', 'coc-rust-analyzer', 'coc-sql', 'coc-yaml', 'coc-sh', 'coc-prisma', 'coc-prettier', 'coc-copilot']

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
