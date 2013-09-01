" source $VIMRUNTIME/vimrc_example.vim
" This must be first, because it changes other options as a side effect.
set nocompatible
set backspace=indent,eol,start
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  autocmd FileType html imap <C-space> <C-y>,
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")
"
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" ====================================
" My Part Begin
" ���ñ���
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese,latin-1

" �к�
set number
colorscheme molokai
syntax enable
syntax on
set tags=tags;
set autochdir
set wildmenu	" ��������ǿģʽ
set scrolloff=4	" ������С��������

function! s:setFontSize(size)
	execute printf('set guifontwide=WenQuanYi\ Micro\ Hei:h%f', a:size)
endfunction
call s:setFontSize(9)
command! -nargs=1 FontSize call s:setFontSize(<f-args>)

"  about tab setting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set guioptions-=T " ���ع�����
set guioptions-=m " ���ز˵���
set guioptions-=r " ���ش�ֱ������
set guioptions-=L " ���ش�ֱ������
set guioptions-=b " ����ˮƽ������

set ignorecase	" ���Դ�Сд
set incsearch		" do incremental searching
set smartcase	" ���������ݰ�����дʱ������ignorecase

set display=lastline " ��ֹһ�г������ڸ߶ȿ�����
"set cursorline	"������ǰ��
"set cursorcolumn
set cc=81 " ���ý�����β

" hi cursorline guibg=#002244
" hi cursorcolumn guibg=#222230

"����mode lines (��ȫ��ʩ�� 
set nomodeline 
"�Զ�д�뻺���� 
set autowrite 
"��ֹ������ʱ�ļ�
set noswapfile
set nobackup		" do not keep a backup file, use versions instead
"���ü����幫��
set clipboard=unnamed
" {{	ӳ����
	"Set mapleader
	let mapleader = ","
	let g:mapleader = ","

	nnoremap <M-v> <C-v>
	"ע��
	nmap <silent> <F3> ,x
	vmap <silent> <F3> ,x
	imap <silent> <F3> ,x
	" ����F1ΪESC
	nmap <silent> <F1> <ESC>
	vmap <silent> <F1> <ESC>
	imap <silent> <F1> <ESC>
	" ����TabΪ%
	nmap <silent> <Tab> %
	vmap <silent> <Tab> %

	nmap ; :
	" ��������
	nmap <C-j> <C-W>j
	nmap <C-k> <C-W>k
	nmap <C-h> <C-W>h
	nmap <C-l> <C-W>l
	" ȥ����β^M
	nmap <leader>M :%s/\r\(\n\)/\1/g<CR>
	"������_VIMRC
	nmap <leader>V :source $MYVIMRC<CR>

	nmap <leader>v :vsp<CR>
	nmap <leader>s :sp<CR>
	nmap <leader>w :w!<CR>
	inoremap <C-U> <C-G>u<C-U>
	map Q gq
	" Increase Number
	noremap <C-I> <C-A>
	" Decrease Number
	nnoremap <C-O> <C-X>
	" replace this word
	nmap dp Pldwbyw

	nmap <silent> <F9> :make <CR>
" }}
" =============================
" plugins
call pathogen#infect() "���������

" for powerline
set laststatus=2
let g:Powerline_symbols='fancy'

" NERDTree
" {
" ����wΪNerdTree�л�
nmap <silent> <F12> :NERDTreeToggle <CR>

" }
set undofile                " Save undo's after file closes
set undodir=$VIM/vimfiles/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


" �Զ����� ��ɫ����ƥ��
"let g:rainbow_active = 1
"let g:rainbow_operators = 1
"
"�ֶ����� ��ɫ����ƥ��
nmap <silent> <F12> :RainbowToggle<CR>

" �����ļ���������
au BufRead,BufNewFile *.json set filetype=javascript
au BufRead,BufNewFile *.iced set filetype=coffee
au BufRead,BufNewFile *.js set autoread
au FileType python set shiftround expandtab softtabstop=4 tabstop=4 shiftwidth=4 


"Reteach arrow key
"{{
function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-e>
  end
  let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
  if line(".") == line("$")
    return
  end
  let l:line = getline(line(".") + 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .+1d
    ''
    call cursor(line("."), l:colsave)
  end
endfunction

function! DelEmptyLineAbove()
  if line(".") == 1
    return
  end
  let l:line = getline(line(".") - 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .-1d
    silent normal! <C-y>
    call cursor(line("."), l:colsave)
  end
endfunction

function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction


" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
    " normal mode
	nmap <silent> <left> <<
	nmap <silent> <right> >>
    nnoremap <silent> <up> <esc>:call DelEmptyLineAbove()<cr>
    nnoremap <silent> <down> <esc>:call AddEmptyLineAbove()<cr>
	nnoremap <silent> <c-up> <esc>:call DelEmptyLineBelow()<cr>
    nnoremap <silent> <c-down> <esc>:call AddEmptyLineBelow()<cr>

    " visual mode
    vmap <silent> <left> <
    vmap <silent> <right> >
	vnoremap <silent> <up> <esc>:call DelEmptyLineAbove()<cr>gv
    vnoremap <silent> <down> <esc>:call AddEmptyLineAbove()<cr>gv
    vnoremap <silent> <c-up> <esc>:call DelEmptyLineBelow()<cr>gv
    vnoremap <silent> <c-down> <esc>:call AddEmptyLineBelow()<cr>gv

    " insert mode
	imap <silent> <left> <c-d>
    imap <silent> <right> <c-t>
    inoremap <silent> <up> <esc>:call DelEmptyLineAbove()<cr>a
    inoremap <silent> <down> <esc>:call AddEmptyLineAbove()<cr>a
    inoremap <silent> <c-up> <esc>:call DelEmptyLineBelow()<cr>a
    inoremap <silent> <c-down> <esc>:call AddEmptyLineBelow()<cr>a

	" exchange lines
    nnoremap  <s-up> :call <SID>swap_up()<CR>
	nnoremap  <s-down> :call <SID>swap_down()<CR>
    inoremap  <s-up> <esc>:call <SID>swap_up()<CR>a
    inoremap  <s-down> <esc>:call <SID>swap_down()<CR>a
    " disable modified versions we are not using
    nnoremap  <s-left> <nop>
    nnoremap  <s-right> <nop>
    vnoremap  <s-up> <nop>
	vnoremap  <s-down> <nop>
    vnoremap  <s-left> <nop>
    vnoremap  <s-right> <nop>
    inoremap  <s-left> <nop>
    inoremap  <s-right> <nop>
endfunction

call SetArrowKeysAsTextShifters()

"nmap <silent> <Tab> %
"vmap <silent> <Tab> %


let g:user_emmet_expandabbr_key = '<c-e>'
