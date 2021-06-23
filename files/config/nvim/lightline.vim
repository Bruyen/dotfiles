let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste', ], [ 'indicator', 'column', 'git', ], [ 'filename', ] ],
    \   'right': [ [ 'lsp_status_off', 'lsp_status_on', 'linter_warnings', 'linter_errors' ], [ 'filetype' ], [ 'filename' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ ] ],
    \   'right': [ [ ], [ ] ]
    \ },
    \ 'tabline': {
    \   'left': [ [ 'tabs', ], ],
    \   'right': [ [ 'tabs_usage', ] ],
    \ },
    \ 'component_expand': {
    \   'tabs': 'BufferTabs',
    \   'tabs_usage': 'BufferTitle',
    \   'linter_warnings': 'LSPWarnings',
    \   'linter_errors': 'LSPErrors',
    \   'lsp_status_on': 'LSPStatusOn',
    \   'lsp_status_off': 'LSPStatusOff',
    \ },
    \ 'component_type': {
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'lsp_status_off': 'disabled',
    \   'lsp_status_on': 'enabled',
    \ },
    \ 'component_function': {
    \   'git': 'Git',
    \   'filetype': 'Filetype',
    \   'cwd': 'Cwd',
    \   'filename': 'Filename',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ 'tabline_separator': { 'left': ' ', 'right': ' ' },
    \ 'tabline_subseparator': { 'left': ' ', 'right': ' ' },
    \ }

