"  Vim-fortify configs

" autocmd filetype fortifydescription nested setlocal spell complete+=kspell

autocmd filetype fortifyrulepack nested setlocal omnifunc=fortify#complete
autocmd filetype fortifyauditpane nested nmap <buffer><expr> <S-l> ""
autocmd filetype fortifyauditpane nested nmap <buffer><expr> <S-h> ""
autocmd filetype fortifyauditpane nested nmap <buffer><expr> <S-k> ""

let g:fortify_auditpane_width = "35"
let g:fortify_JDKVersion = "11"
let g:fortify_SCAPath = "~/.local/bin/sourceanalyzer"
let g:fortify_pluginpath = "~/.config/nvim/plugged/vim-fortify"
let g:fortify_MemoryOpts = [ "-Xmx4096m", "-Xss24m", "-64" ]
" let g:fortify_DefaultJarPath = "/home/bruce/SCA/Default_Jars/*"
let g:fortify_SRF = '/home/bruce/test_SRF/srf.py'
" let g:fortify_PythonPath = "/usr/lib/python3.8"
" let g:fortify_AndroidJarPath = '/home/bruce/Android/Sdk/platforms/android-30/android.jar'
" let g:fortify_auditpane_width = "45"

let g:fortify_AWBOpts = []

let g:fortify_TranslationOpts = ["-verbose"]
" let g:fortify_TranslationOpts = ["-cp \"/mnt/c/Users/Dude/Scratch/JavaTests/Dataflow_Exercise_2/lib/*\""]
let g:fortify_TranslationOpts = ["-extdirs \"/home/bruce/SCA/Default_Jars\""]
" let g:fortify_TranslationOpts += ['-debug', '-debug-verbose', '-logfile', 'translation.log']
" let g:fortify_TranslationOpts += ["mvn", "com.fortify.sca.plugins.maven:sca-maven-plugin:translate"]
" let g:fortify_TranslationOpts += ["-python-version", "2"]
" let g:fortify_TranslationOpts += ["-gopath", "/home/bruce/.go"]
" let g:fortify_TranslationOpts += ['-project-root', 'sca_build']
"
let g:fortify_ScanOpts = ["-verbose"]
" let g:fortify_ScanOpts += ["-DRuleScriptDebugger=true -DScriptsToDebug=android_privilegewarnings"]
" let g:fortify_ScanOpts += ["-debug", "-debug-verbose", "-logfile", "scan.log"]            " Generate scan logs
" let g:fortify_ScanOpts += ['-Ddf3.debug=/home/bruce/Scratch/JavaTests/src/taint.log']                             " Dump taint log
" let g:fortify_ScanOpts += ['-Dcom.fortify.sca.followImports=false']                       " Do not translate and analyze all libraries that you require in your code
" let g:fortify_ScanOpts += ['-Ddebug.dump-nst']                                            " For debugging purposes dumps NST files between Phase 1 and Phase 2 of analysis.
" let g:fortify_ScanOpts += ['-Ddebug.dump-cfg']                                            " For debugging purposes controls dumping Basic Block Graph to file.
" let g:fortify_ScanOpts += ['-Ddebug.dump-raw-cfg']                                        " Dump the cfg which is not optimized by dead code elimination
" let g:fortify_ScanOpts += ['-Ddebug.dump-ssi']                                            " For debugging purposes dump ssi graph.
" let g:fortify_ScanOpts += ['-Ddebug.dump-cg']                                             " For debugging purposes dump call graph.
" let g:fortify_ScanOpts += ['-Ddebug.dump-vcg']                                            " For debugging purposes dump virtual call graph deferred items.
" let g:fortify_ScanOpts += ['-Ddebug.dump-model']                                          " For debugging purposes data dump of model attributes.
" let g:fortify_ScanOpts += ['-Ddebug.dump-call-targets']                                   " For debugging purposes dump call targets for each call site
" let g:fortify_ScanOpts += ['-Ddebug.dump-structural-tree']                                " Dumps the structural tree, Lots of output
" let g:fortify_ScanOpts += ['-Dic.debug=issue_calculator.log']                             " Dump issue calculator log
" let g:fortify_ScanOpts += ['-Dcom.fortify.sca.ThreadCount=1']                             " Disable multi-threading
" let g:fortify_ScanOpts += ['-project-root', 'sca_build']
" let g:fortify_ScanOpts += ['---show-files']

" Structural Debugger
"
" let g:fortify_ScanOpts += ['-Dcom.fortify.sca.debug.rule=D23F2325,test.go,9 -debug -verbose']

function! s:fzf_nst_files()
    let buffer_path = resolve(expand('%:p'))
    let pattern = buffer_path . '.nst'
    if exists("g:fortify_NSTRoot") && g:fortify_NSTRoot != ""
        let home = g:fortify_NSTRoot
    else 
        let home = glob('~')
    endif
    if exists("g:fortify_SCAVersion") && g:fortify_SCAVersion != ""
        let sca_version = 'sca'. string(g:fortify_SCAVersion)
    else
        call GetSCAVersion()
        let sca_version = 'sca'. string(g:fortify_SCAVersion)
    endif
    let root = home . '/.fortify/' . sca_version . '/build'
    let command = 'rg --files -g "**' . pattern . '" ' . root
    call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '+s -e --ansi --prompt ""',
        \ }))
endfunction

function! s:fzf_rulepack_files()
    " let command = 'rg --files -g "**/src/*.xml" ~/rules'
    let command = 'rg --files -g "**" ~/rules'
    call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '+s -e --ansi --prompt ""',
        \ }))
endfunction

function! s:fzf_rulepack_descriptions()
    let command = 'rg --files -g "**/descriptions/en/*.xml" ~/rules'
    call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '+s -e --ansi --prompt ""',
        \ }))
endfunction

" LEADER MAPPINGS {{{

" Open Rules Dir
nnoremap <Leader>or :e ~/rules<Return>
nnoremap <leader>n :call <SID>fzf_nst_files()<Return>
nnoremap <leader>r :call <SID>fzf_rulepack_files()<Return>
nnoremap <leader>d :call <SID>fzf_rulepack_descriptions()<Return>

" Translate
nnoremap <Leader>t :Translate %<Return>

" Scan
nnoremap <Leader>s :Scan<Return>

" Scan with rulepack
nnoremap <Leader>S :Scan %<Return>

" Scan with rulepack and no default rules
nnoremap <Leader>SS :Scan % --no-default-rules<Return>

" Clone Rule
nnoremap <Leader>c :CloneRule<Return>

" Clone Rule
nnoremap <Leader>C :CommentRule<Return>

" Indent Rule
nnoremap <Leader>i :IndentRule<Return>

" New Rule ID
nnoremap <Leader>I :NewRuleID<Return>

" Swap value/pattern
nnoremap <Leader>v :PatternValue<Return>


" Paste with new RuleID 
" nnoremap <Leader>p :PasteWithNewRuleID<Return>

" }}}
