" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi'
Plugin 'scrooloose/syntastic'
Plugin 'derekwyatt/vim-scala'
Plugin 'scrooloose/nerdtree'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()

" Loading closetag on HTMLish files
"" au FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
"" au FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

" Some syntax specific stuff
au BufRead,BufNewFile *.erb,*.html,*.coffee,*.ml,*.scss,*.css set sw=2

filetype plugin indent on

" Tab behavior
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=80
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

autocmd FileType python setlocal foldmethod=indent
set foldlevel=99

" Remap VIM 0 to first non-blank character
map 0 ^

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set ffs=unix,dos,mac
set viminfo^=%

" Loading & Reading
set autoread
nmap <leader>w :w!<cr>
set wildignore=*.o,*~,*.pyc

" Turn on the WiLd menu
set wildmenu

"Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search related
set ignorecase
set smartcase
set hlsearch
set incsearch

" Syntax and color scheme
syntax enable
colorscheme desert
set background=dark

" Navigating
" Buffer
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nmap <leader>nn :NERDTreeToggle<CR>

set fileencodings=ucs-bom,utf-8,cp936,gb18030

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

" Cscope bindings
" nmap <C-[>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" nmap <C-[>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" nmap <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" nmap <C-[>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" nmap <C-[>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" nmap <C-[>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" nmap <C-[>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" nmap <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Bind <- and -> to something useful
map <right> :bn<cr>
map <left> :bp<cr>

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Status line
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ L%l:C%c

" YouCompleteMe commands
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nmap <F4> :YcmDiags<CR>

au BufRead,BufNewFile *.c,*.cpp let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
au BufRead,BufNewFile *.py let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/python/ycm/server/tests/testdata/client_data/.ycm_extra_conf.py'


" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

set list listchars=trail:.,extends:>
autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    &hlsearch=a:1
  end
    return oldhlsearch
endfunction
