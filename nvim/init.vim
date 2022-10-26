" NOTE: Command to query where a command is set:
" :verbose set <setting>?

" ================ GENERAL ================ {{{
set autowrite                                                     " Write on shell/make command
set nrformats=alpha,hex,octal                                     " Increment/decrement numbers. C-a,a (tmux), C-x
set shell=/usr/bin/zsh                                            " ZSH ftw!
set visualbell                                                    " Silent please
set ffs=unix,dos                                                  " Use Unix EOL
set hidden                                                        " Hide buffers when unloaded
set inccommand=nosplit                                            " Live preview for :substitute
set fileencoding=utf-8
set encoding=utf-8
set nottimeout
set ignorecase                                                    " Makes searching case insensitive
set smartcase                                                     " Case sensitive search if you enter an Uppercase letter
set backspace=eol,start,indent
set spell                                                         " Enables Spell checker
set updatetime=750                                                " CursorHold waiting time

hi SpellBad ctermfg=034 ctermbg=016 guifg=#00af00 guibg=#000000
hi SpellCap ctermfg=106 ctermbg=020 guifg=#97af00 guibg=#0000d7
hi Search   guibg=#ffffff guifg=#00ff00
hi Search cterm=NONE ctermfg=010 ctermbg=008

" ========================================= }}}

" ================ SYNTAX/LAYOUT ================ {{{
syntax enable
set wrap                                                          " Wrap lines visually
set sidescroll=0                                                  " Side scroll when wrap is disabled
set linebreak                                                     " Wrap lines at special characters instead of at max width
set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:%          " Showing trailing whitespace
set list                                                          " Show whitespace

" =============================================== }}}

" ================ LANGUAGE SPECIFICS ================ {{{
let msql_sql_query = 1                                            " Better mysql highlight
let python_highlight_all = 1                                      " Better python highlight
let c_comment_strings=1                                           " Strings and numbers inside a comment
let c_syntax_for_h=1                                              " .h are C
let php_htmlInStrings = 1                                         " Highlight HTML in PHP strings
let php_sql_query = 1                                             " Highligh SQL in PHP
let g:java_space_errors = 1
let g:java_comment_strings = 1
let java_highlight_all=1                                          " Better java highlight
let java_highlight_debug=1                                        " Highlight debug statement (println...)
let java_highlight_java_lang_ids=1                                " Highlight identifiers in java.lang.*
let java_highlight_functions="style"                              " Follow Java guidelines for Class and Function naming
let g:java_mark_braces_in_parens_as_errors = 1
let java_minlines = 150                                           " Start syntax sync 150 above current line
let java_comment_strings=1                                        " Strings and numbers inside a comment
let g:sh_no_error = 1                                             " Shell scrpting highlighting fixes
let g:markdown_fenced_languages = ['python', 'java', 'vim']       " Highlight fenced code
" ==================================================== }}}

" ================ FOLDING ================ {{{
set foldmethod=manual                                             " Fold manually (zf)
set foldcolumn=0                                                  " Do not show fold levels in side bar
" ========================================= }}}

" ================ UI ================ {{{
set cursorline                                                    " Print cursorline
set guioptions=-Mfl                                               " nomenu, nofork, scrollbar
set laststatus=2                                                  " status line always on
set showtabline=2                                                 " always shows tabline
set lazyredraw                                                    " Don't update the display while executing macros
set number                                                        " Print the line number
set norelativenumber                                              " Disable relative line numbers
set scrolloff=5                                                   " 5 lines margin to the cursor when moving
set tw=1000                                                       " TextWitdh ulra high since its used for active window highlighting
set t_Co=256                                                      " 256 colors
set t_ut=
set ttyfast                                                       " Faster redraw
set showcmd                                                       " Show partial commands in status line
set noshowmode                                                    " Dont show the mode in the command line
set incsearch                                                     " Search as you type
set hlsearch                                                      " Highlight all search results

if (has("termguicolors"))                                         " Set true colors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
" ===================================== }}}

" ================ MOUSE ================ {{{
behave xterm                                                      " Behave like xterm
if has('mouse')
    set mouse=a                                                   " Mouse support
    if !has('nvim')
        set ttymouse=xterm2
    endif
    set mousefocus                                                " Autofocus
    set mousehide                                                 " Hide mouse pointer while typing
endif
" ======================================= }}}

" ================ AUTOCOMPLETION ================ {{{
set wildmenu 
set wildmode=longest,full
set wildoptions=tagfile
set wildignorecase
set complete=.,w,b,u,U,i,d,t
set completeopt=menu,longest
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=build/*,tmp/*,vendor/cache/*,bin/*
set wildignore+=.sass-cache/*
set wildignore+=*DS_Store*
set wildignore+=log/**
set wildignore+=tmp/**
" ================================================ }}}

" ================ BACKUP/SAVE ================ {{{
set wb                                                            " Make a backup before overwriting
set nobackup                                                      " But don't keep it
set noswapfile                                                    " Swap is evil
set undofile                                                      " Maintain undo history between sessions
silent !mkdir ~/.config/nvim/tmp > /dev/null 2>&1                 " Create tmp directory if it does not exist already
set directory=~/.config/nvim/tmp                                  " But do it always in the same place
set backupdir=~/.config/nvim/tmp                                  " But do it always in the same place
set undodir=~/.config/nvim/tmp                                    " But do it always in the same place
au FocusLost * :silent! wall
"set viewoptions=cursor,folds                                      " Set view options for saving/restoring
" ============================================== }}}

" ================ IDENT/STYLE ================ {{{
set autoindent                                                    " Auto-ident
set smartindent                                                   " Smart ident
set shiftround                                                    " Round indent to multiple of 'shiftwidth'
set smarttab                                                      " Reset autoindent after a blank line
set expandtab                                                     " Tabs are spaces
set tabstop=4                                                     " How many spaces on tab
set softtabstop=4                                                 " One tab = 4 spaces
set shiftwidth=4                                                  " Reduntant with above
set breakindent                                                   " Wrapped lines will maintain indentation
set formatoptions=l                                               " Do not break current line while in insert mode
set lbr                                                           " Do not wrap line in the middle of word
set showbreak=...                                                 " Prepend '...' to wrapped lines
" ============================================= }}}

" ================ Mappings ================ {{{

" quit all windows
command! Q execute "qa!"

" because I can't type 
command! Wq execute "wq"

" because typing is hard
command! W execute "w"

" debug syntax
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" do python things...
nnoremap <F2> :echo system('python2 "' . expand('%') . '"')<cr>
nnoremap <F3> :echo system('python3 "' . expand('%') . '"')<cr>

" navigate faster
noremap <space>h ^
noremap <space>l g_
nnoremap <Space>j 15j
nnoremap <Space>k 15k

" escape to normal mode in insert mode
inoremap jk <ESC>

" shifting visual block should keep it selected
vnoremap < <gv
vnoremap > >gv

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<Return>

" automatically jump to end of text you yanked
vmap y ygv<Esc>

" quickly select text you pasted
noremap gP `[v`]`]`

" highlight last inserted text
nnoremap gI `[v`]

" go up/down one visual line
map j gj
map k gk

" go to Beggining or End of line
nnoremap B ^
nnoremap E $

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

" disable arrow keys
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Mapping tab to autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" jump to last visited location
nnoremap <S-k> <C-^>

" save me from 1 files :)
cabbrev w1 <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'w!' : 'w1')<CR>

" resize splits
nnoremap <silent> > :exe "vertical resize +5"<Return>
nnoremap <silent> < :exe "vertical resize -5"<Return>
nnoremap <silent> + :exe "resize +1"<Return>
nnoremap <silent> _ :exe "resize -1"<Return>

" ================================================ }}}


" ================ LEADER MAPPINGS ================ {{{

" Comma is your leader
let mapleader = "," 

" Refresh syntax highlighting
" noremap <Leader>S <ESC>:syntax sync fromstart<Return>
" inoremap <Leader>S <ESC>:syntax sync fromstart<Return>

" Refresh document
nnoremap <Leader>e :e!<Return>

" Remove trailing spaces
nnoremap <Leader><Space> :%s/\s\+$//<Return>

" Edit init.vim
nnoremap <Leader>V :e ~/.config/nvim/init.vim<Return>

" Source init.vim
nnoremap <Leader>so :so ~/.config/nvim/init.vim<Return>

" Save file
nnoremap <Leader>w :w<Return>

" Write as sudo
nnoremap <Leader>W :w !sudo tee % > /dev/null

" Toggle line wrapping
nnoremap <Leader>sw :set wrap!<Return>

" Close current buffer but do not close window 
nnoremap <Leader>q :bp\|bd #<CR>

" paste keeping the default register
vnoremap <Leader>p "_dP

" set paste mode
nnoremap <Leader>sp :set paste!<Return>

" copy & paste to system clipboard
vmap <Leader>y "+y

" show/hide line numbers
nnoremap <Leader>n :set nonumber!<Return>

" Run php script
nnoremap <Leader>x :!php %<Return>

" Toggle VimFiler Explorer Window
nnoremap <Leader>f :VimFilerExplorer -toggle<Return>

" Toggle VimFiler
nnoremap <Leader>F :VimFiler<Return>

" Execute open file
nnoremap <Leader>. :!%:p<Return>

" Toggle Tagbar
nnoremap <Leader>O :TagbarToggle<Return>

" Show syntax highlighting groups for word under cursor
nmap <Leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" ================================================== }}}

"
" ================ AUTOCOMMANDS ==================== {{{
"
" disable paste mode when leaving Insert mode
autocmd InsertLeave * set nopaste

" augroup numbertoggle
"     autocmd!
"     autocmd BufEnter * set relativenumber
"     autocmd BufLeave * set norelativenumber
" augroup END

augroup active_win
    " dont show column
    " autocmd BufEnter *.* :set colorcolumn=0

    " show cursor line only in active windows
    autocmd FocusGained,VimEnter,WinNew,WinEnter,BufWinEnter * setlocal cursorline
    autocmd FocusLost,WinLeave * setlocal nocursorline

    " highlight active window
    autocmd FocusGained,VimEnter,WinNew,WinEnter,BufWinEnter * set winhighlight=Normal:Normal,EndOfBuffer:EndOfBuffer,SignColumn:Normal,VertSplit:EndOfBuffer
    autocmd FocusLost,WinLeave * set winhighlight=Normal:NormalNC,EndOfBuffer:EndOfBufferNC,SignColumn:NormalNC,VertSplit:EndOfBufferNC

    " TODO: Update statusline
"    " hide statusline on non-current windows
"    autocmd FocusGained,VimEnter,WinNew,WinEnter,BufWinEnter * call StatusLine()
"    autocmd FocusLost,WinLeave * call StatusLineNC()
augroup END

autocmd TermOpen * setlocal nonumber norelativenumber

" ================= END AUTOCOMMANDS =============== }}}
"
" ================ GLOBALS ========================= {{{
"
let g:special_buffers = ['help', 'fortifytestpane', 'fortifyauditpane', 'defx', 'qf', 'vim-plug', 'fzf', 'magit']
let g:previous_buffer = 0
let g:is_previous_buffer_special = 0
" ================ END GLOBALS ===================== }}}
"
" ================== FUNCTIONS ===================== {{{
"
" TODO:
" function! SetAliases() abort
" endfunction
" autocmd VimEnter * call SetAliases()

function! BufferSettings() abort
    if index(g:special_buffers, &filetype) == -1
        " cycle through buffers on regular buffers
        nnoremap <silent><buffer><S-l> :bnext<Return>
        nnoremap <silent><buffer><S-h> :bprevious<Return>
        set colorcolumn=80
    else
        " disable buffer cycling on special buffers
        nnoremap <silent><buffer><S-l> <Nop>
        nnoremap <silent><buffer><S-h> <Nop>
        set colorcolumn=0
    endif
endfunction
autocmd WinEnter,BufEnter * nested call BufferSettings()

" ================== END FUNCTIONS ================= }}}

if &compatible
    set nocompatible
endif

filetype off
filetype plugin indent on

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" Disable netrw.vim
let g:loaded_netrwPlugin = 1

" Plugins
execute 'source' fnameescape(expand('~/.config/nvim/plugins.vim'))
" Fortify plugin configs
" execute 'source' fnameescape(expand('~/.config/nvim/fortify.vim'))
