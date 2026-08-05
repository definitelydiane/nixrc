" Vim-Plug "
call plug#begin('~/.vim/plugs')

" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'runoshun/tscompletejob'
" Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'

" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Better JSON linting "
Plug 'elzr/vim-json', { 'for': 'json' }
let g:vim_json_syntax_conceal = 0

" Typescript highlighting "
" Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript'

" A la Sublime Text"
Plug 'terryma/vim-multiple-cursors'

" Surround.vim "
Plug 'tpope/vim-surround'

" Better Vim commands "
Plug 'tpope/vim-eunuch'

" Screen-centered cursor "
Plug 'reedes/vim-wheel'

" HTML Tag expansion "
Plug 'mattn/emmet-vim'

" Gutter Linting "
Plug 'dense-analysis/ale'

" Editorconfig "
Plug 'editorconfig/editorconfig-vim'

" Git Diff in gutter "
Plug 'airblade/vim-gitgutter'

" Python things "
" Syntax Highlighting "
Plug 'vim-python/python-syntax'

" Rust syntax "
Plug 'rust-lang/rust.vim'

" Clean writing environment "
" Plug 'junegunn/goyo.vim' "

" Code Completion Plugs "
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vue.js syntax highlighting "
Plug 'posva/vim-vue' "
" Plug 'leafoftree/vim-vue-plugin' "

" C# Autocomplete "
" Plug 'OmniSharp/omnisharp-vim'

" Cursor pulse "
Plug 'inside/vim-search-pulse'

"SC Lang"
Plug 'supercollider/scvim'

"Rust"
Plug 'rust-lang/rust.vim'

" Fuzzy search "
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Svelte "
Plug 'evanleck/vim-svelte', {'branch': 'main'}

let g:svelte_indent_script = 0
let g:svelte_indent_style = 0


call plug#end()

let g:ale_fixers = {
	\'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']
\}


syntax on
set re=0
" set termguicolors
set updatetime=300

filetype indent on
set number
set ruler
set noexpandtab
set shiftwidth=2
set tabstop=2
set numberwidth=3
set scrolloff=10
hi LineNr ctermfg=DarkGrey

" Split Panes "
set fillchars+=vert:\ ,stl:\ ,stlnc:\ 
hi VertSplit cterm=NONE ctermbg=0

" Status Lines "
hi StatusLineNC ctermfg=0 ctermbg=NONE
hi StatusLine ctermfg=Grey ctermbg=NONE

" Syntax "
" hi LineNr ctermfg=Grey ctermbg=NONE
hi EndOfBuffer ctermfg=Black ctermbg=NONE
hi Comment ctermfg=Grey ctermbg=NONE
hi vimGroup ctermfg=Green
" For Kasugano:
hi vimOption ctermfg=Cyan
hi vimHiAttrib ctermfg=Cyan
hi vimUsrCmd ctermfg=Cyan

" hi vimHiAttrib ctermfg=Blue
" hi vimUsrCmd ctermfg=Blue
hi vimCommentTitle ctermfg=DarkYellow
hi vimHiCTerm ctermfg=Green
hi vimHiCtermFgBg ctermfg=Green

" hi Include ctermfg=Yellow ctermbg=NONE
" old hi StorageClass ctermfg=Blue ctermbg=NONE
" hi Type ctermfg=2 ctermbg=NONE
" hi Statement ctermfg=4 ctermbg=NONE
hi ColorColumn ctermbg=0
hi SignColumn ctermbg=NONE
hi GitGutterAdd ctermfg=Green ctermbg=NONE
hi GitGutterChange ctermfg=Yellow ctermbg=NONE
hi GitGutterDelete ctermfg=Red ctermbg=NONE
hi ALEError ctermfg=White ctermbg=5
hi ALEErrorSign ctermfg=White ctermbg=5
hi ALESpellBad ctermfg=White ctermbg=5
hi SpellBad ctermfg=White ctermbg=5
hi ALEStyleError ctermfg=White ctermbg=5
hi ALEWarning ctermfg=White ctermbg=Red

hi CocErrorFloat ctermfg=Black ctermbg=Gray

" Bindings "
map \n :NERDTreeToggle<CR>
inoremap jj <Esc>
noremap <Space> :w<CR>
noremap QQ :wq<CR>
noremap ff :ALEFix<CR>

noremap af :b#<CR>
noremap gf :GitFiles<CR>
noremap sf :Files<CR>
noremap pf <C-^>
noremap so :source ~/.vimrc<CR>

noremap <silent><nowait> aaf :e#<CR>
noremap afn :e#
noremap ss :call SynStack()<CR>

noremap == <C-a>
noremap -- <C-x>

" CoC Bindings "
" inoremap <silent><expr> <ENTER> pumvisible() ? coc#_select_confirm() : '\<C-g>u\<tab>'
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : '<tab>'
" Enter to autocomplete
" inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
" 			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Functions "

function! SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunc

function! StatusLineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?' '.l:branchname.' ':''
endfunc

function! IsCurBuffer(buff)
	let num = bufnr('%')
	return nm == buff ? 1 : 0
endfunc

set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=%{(&modified?'\+':'\ ')}
set statusline+=\ %{mode()}
" Uncomment for glyphs
" set statusline+=\ \ 
set statusline+=\  
set statusline+=%#SignColumn#
" set statusline+=%=%*\ \ %{StatusLineGit()}
" set statusline+=%=%*\ \ 
set statusline+=%=%*

set backspace=indent,eol,start
set nowrap

autocmd FileType typescriptreact let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js']

" Language Server configs
" if executable('typescript-language-server')
" 	au User lsp_setup call lsp#register_server({
" 		\ 'name': 'typescript-language-server',
" 		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
" 		\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
" 		\ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
" 		\ })
" endif
" 
" " Register Typescript for asyncomplete
" call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
" 		\ 'name': 'tscompletejob',
" 		\ 'allowlist': ['typescript'],
" 		\ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
" 		\ }))
