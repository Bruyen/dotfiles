" lightline
execute 'source' fnameescape(expand('~/.config/nvim/lightline.vim'))

" VIM-POLYGLOT
let g:polyglot_disabled = ["xml", "java", "vim"]
let g:no_csv_maps = 1

" ================ PLUGINS ================ {{{
" Plug stuff
call plug#begin('~/.config/nvim/plugged')
    Plug 'https://github.houston.softwaregrp.net/Fortify-SSR/vim-fortify'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'pbogut/fzf-mru.vim'
    Plug 'rhysd/committia.vim'                                    " Generates multiple panes for git commits
    Plug 'nvim-lua/completion-nvim'                               " Completion with LSP
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " General Completion
    Plug 'vim-scripts/DeleteTrailingWhitespace'                   " Deletes trailing whitespace
    Plug 'eclipse/eclipse.jdt.ls'                                 " Java LSP
    Plug 'rhysd/git-messenger.vim'
    Plug 'Yggdroot/indentLine'                                    " Shows indentation guides
    Plug 'lukas-reineke/indent-blankline.nvim'                    " Shows Indentation guide for blank lines
    Plug 'itchyny/lightline.vim'                                  " Lightweight statusline
    Plug 'AndrewRadev/linediff.vim'                               " Selective diffs
    Plug 'neovim/nvim-lspconfig'                                  " LSP
    Plug 'mfussenegger/nvim-jdtls'                                " LSP extention
    Plug 'junegunn/rainbow_parentheses.vim'                       " Colors inner parenthesis
    Plug 'majutsushi/tagbar'                                      " Displays tags for current file
    Plug 'ap/vim-buftabline'                                      " Tabs for each buffer
    Plug 't9md/vim-choosewin'                                     " Chose Buffer
    Plug 'alvan/vim-closetag'                                     " Autocloses XHTML tags
    Plug 'tpope/vim-commentary'                                   " Comment shortcuts
    Plug 'ap/vim-css-color'                                       " highlights color values
    Plug 'tpope/vim-fugitive'                                     " Git wrapper
    Plug 'airblade/vim-gitgutter'                                 " Shows git changes
    Plug 'ludovicchabant/vim-gutentags'                           " Generates tag files
    Plug 'machakann/vim-highlightedyank'                          " Highlights most recent yanked
    Plug 'tommcdo/vim-lion'                                       " Text alignment 
    Plug 'andymass/vim-matchup'                                   " Highlights matching bracket/texts
    Plug 'Yilin-Yang/vim-markbar'                                 " Shows availes Vim markers
    Plug 'matze/vim-move'                                         " Move selections
    Plug 'sheerun/vim-polyglot'                                   " Collection of language packs
    Plug 'airblade/vim-rooter'                                    " Changes the working directory to the project root
    Plug 'google/vim-searchindex'                                 " Shows current index of searches
    Plug 'kshenoy/vim-signature'                                  " Displays Vim marks
    Plug 'chaoren/vim-wordmotion'                                 " Word Navigation
    Plug 'tomasr/molokai'                                         " Colorscheme
    Plug 'fmoralesc/molokayo'                                     " Colorscheme
    Plug 'morhetz/gruvbox'                                        " Colorscheme
call plug#end()

" TODO: lightline configs; pwd + filename

" File Explorer
" Plug 'Shougo/defx.nvim'
" Plug 'kristijanhusak/defx-git'
" Plug 'kristijanhusak/defx-icons'
" Plug 'kyazdani42/nvim-tree.lua"
" Plug 'kyazdani42/nvim-web-devicons'

" Surrounds text in matching text
" Plug 'machakann/vim-sandwich'

" Code Snippet generation
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" theme
set background=dark
colorscheme gruvbox

" choosewin configs
nmap <c-w><c-w> <plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 0 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline
let g:choosewin_color_overlay = {
        \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
        \ 'cterm': [25, 25]
        \ }
let g:choosewin_color_overlay_current = {
        \ 'gui': ['firebrick1', 'firebrick1'],
        \ 'cterm': [124, 124]
        \ }

" " " ULTISNIPS
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" fzf configs
nnoremap <c-p> :FZF<Return>
nnoremap <c-f> :Rg<Return>
" TODO: Integrate FZF properly
" nnoremap <c-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<Return>
nnoremap <leader>b :Buffers<Return>
nnoremap <leader>h :FZFFreshMru --prompt ""<Return>
let $FZF_DEFAULT_OPTS='--no-inline-info --margin=1,2 --color=dark ' .
    \ '--color=fg:#d0d0d0,bg:#020511,hl:#0088ff '.
    \ '--color=fg+:#ffc600,bg+:#020511,hl+:#ffc600 '.
    \ '--color=marker:#3ad900,spinner:#967efb,header:#0088ff '.
    \ '--color=info:#020511,prompt:#0088ff,pointer:#0088ff'

" let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let g:fzf_layout = {}
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(30)
  let width = float2nr(90)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" RAINBOW PARENTHESIS
autocmd WinEnter,BufEnter * nested call s:enableRainbowParentheses()
autocmd WinEnter,BufEnter {} nested call s:enableRainbowParentheses()
function! s:enableRainbowParentheses() abort
    if index(g:special_buffers, &filetype) == -1 && exists(":RainbowParentheses")
        " Activate
        silent execute "RainbowParentheses"
    elseif exists(":RainbowParentheses")
        " Deactivate
        silent execute "RainbowParentheses!"
    endif
endfunction

" MATCHUP
let g:loaded_matchparen        = 1
let g:loaded_matchit           = 1 
let g:matchup_matchparen_status_offscreen = 0 " Do not show offscreen closing match in statusline
let g:matchup_matchparen_nomode = "ivV\<c-v>" " Enable matchup only in normal mode
let g:matchup_matchparen_deferred = 1         " Defer matchup highlights to allow better cursor movement perform

" MARKUP
nmap <Leader>m <Plug>ToggleMarkbar
let g:markbar_width = 25
let g:markbar_enable_peekaboo = v:false
let g:markbar_marks_to_display = 'abcdefghijklmnopqrstuvwyzABCDEFGHIJKLMNOPQRSTUVWYZ'
let g:markbar_num_lines_context = 3

" GITGUTTER 
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 0
let g:magit_refresh_gitgutter = 1
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bb9900 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight GitGutterAddLineNr    guibg=#009900 ctermbg=2
highlight GitGutterChangeLineNr guibg=#bb9900 ctermbg=3
highlight GitGutterDeleteLineNr guibg=#ff2222 ctermbg=1

" INDENTLINE
let g:indentLine_fileTypeExclude = g:special_buffers 
let g:indentLine_faster     = 1
let g:indentLine_conceallevel = 2

" VIM-MOVE
let g:move_map_keys = 0
vmap <C-S-Down> <Plug>MoveBlockDown
vmap <C-S-Up> <Plug>MoveBlockUp
vmap <C-S-Left> <Plug>MoveBlockLeft
vmap <C-S-Right> <Plug>MoveBlockRight

" VIM-BUFTABLINE
let g:buftabline_show = 2
let g:buftabline_indicators = 1
let g:buftabline_separators = 1

" VIM-WORDMOTION
let g:wordmotion_prefix = '<Leader>'

" VIM-CLOSETAG
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.jsp'
let g:closetag_filetypes = 'html,xhtml,phtml,fortifyrulepack,xml,jsp'
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsp,*.html'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,fortifyrulepack'

" VIM-ROOTER
" let g:rooter_use_lcd = 1
let g:rooter_cd_cmd="lcd"
let g:rooter_patterns = ['build.gradle', 'pom.xml', '.git/']
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" completion-nvim
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" nvim-lsp
lua <<EOF
    local nvim_lsp = require'lspconfig'
    local configs = require'lspconfig/configs'
    configs.gopls = {
        default_config = {
            cmd = {'/home/bruce/.go/bin/gopls'};
            filetypes = { "go", "gomod" };
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
            end;
            settings = {};
        };
    }

    local java_root = nvim_lsp.util.root_pattern('.project', 'pom.xml', 'project.xml', '.git');
    configs.jdtls = {
        default_config = {
            cmd = {'jdtls'};
            filetypes = {'java'};
            root_dir = function(fname)
                return java_root(fname) or vim.loop.os_homedir()
            end;
            settings = {};
        };
    }
    nvim_lsp.gopls.setup{}
    nvim_lsp.jdtls.setup{}
EOF
lua require'lspconfig'.pyls.setup{}

" Deoplete configs
" TODO: Disable for LSP enabled languages
autocmd FileType java call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd FileType py call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd BufEnter * nested if getfsize(@%) < 100000 | call deoplete#enable() | endif
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \ 'auto_complete_delay': 300,
    \ 'smart_case': v:true,
    \ })

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 2000

" VIM-LION
let g:lion_squeeze_spaces = 1 " align around a given char: gl<character>

" git-messenger
let g:git_messenger_no_default_mappings = 1
