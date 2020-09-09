let mapleader = ","

if (!exists('g:vscode'))
	call plug#begin("~/.vim/plugged")
		" Plugin section
		Plug 'dracula/vim'
    Plug 'joshdick/onedark.vim'
		Plug 'scrooloose/nerdtree'
		Plug 'ryanoasis/vim-devicons'
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		Plug 'jiangmiao/auto-pairs'
		Plug 'leafOfTree/vim-vue-plugin'
    Plug 'pangloss/vim-javascript'
    Plug 'airblade/vim-gitgutter'
		"Plug 'leafgarland/typescript-vim'
		"Plug 'peitalin/vim-jsx-typescript'
	call plug#end()
	

	" Config section
  " Configuring tabs space
	set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
  
  " Coniguring javascript syntax
  let g:javascript_plugin_jsdoc = 1

  "augroup javascript_folding
    "au!
  "  au FileType javascript setlocal foldmethod=syntax
  "augroup end

  " Git Gutter status line
  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction
  set statusline+=%{GitStatus()}
  " Configuring coc.nvim
  " Setting coc.vim
	let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-vetur', 'coc-eslint', 'coc-prettier']
  " If hidden is not set, TextEdit might fail
  set hidden
  " Some servers have issues with backup files
  set nobackup
  set nowritebackup
  " More space for displaying messages
  set cmdheight=2
  set updatetime=300
  " Don't pass messages to |ins-completion-menu|
  set shortmess+=c

  " Always show signcolumn, otherwise it would shift the text each time
  " diagnostics appear resolved
  if has('patch-8.1.1564')
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use tab to trigger completion with characters ahead and navigate
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "<\TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
  endfunction

  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " User <cr> to complete confirm completion. <C-g>u means break undo chain at
  " current position
  if exists('complete_info')
    inoremap <expr> <cr> complete_info()['selected'] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use ']g' and '[g' to navigate diagnostics
  " Use ':CocDiagnositcs' to get all diagnostics of current buffer in location
  " list
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  "nmap <silent> gt <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code
  xmap <leader>f <Plug>(coc-format-selected)
  nmap <leader>f <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Apply autofix to problem on the current line
  nmap <leader>qf <Plug>(coc-fix-current)

  " Remap keys for applying codeAction to the current buffer
  nmap <leader>ac <Plug>(coc-codeaction)

  " Applying codeAction to the selected region
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a <Plug>(coc-codeaction-selected)
  nmap <leader>a <Plug>(coc-codeaction-selected)

  " Add `:Format` command to format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " Add `:Fold` command to fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)
  " Add `:OR` command to organize imports of the current buffer
  command! -nargs=0 OR :call  CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  "autocmd FileType vuejs set filetype=vue
  :filetype on
  filetype plugin on
  "
  "
  if (has("termguicolors"))
		set termguicolors
	endif
	syntax enable
  "colorscheme dracula
  colorscheme onedark

  "Set nerdtree
	let g:NERDTreeShowHidden = 1
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeIgnore = []
	let g:NERDTreeStatusline = ''
	
	" Automaticaly close nvim if NERDTree is only thing left open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	" Toggle
	nnoremap <A-1> :NERDTreeToggle<CR>
	nnoremap <silent> <C-b> :NERDTreeToggle<CR>



	" Configure prettier
	command! -nargs=0 Prettier :CocCommand prettier.formatFile
  command! -nargs=0 Format :CocCommand eslint.executeAutoFix
	vmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)
  
  " Fzf config
	nnoremap <C-p> :FZF<CR>
	let g:fzf_action = {
	  \ 'ctrl-t': 'tab split',
	  \ 'ctrl-s': 'split',
	  \ 'ctrl-v': 'vsplit'
	  \}
	" Configuring silversearccher-ag
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'

	" open new split panes to right and below
	set splitright
	set splitbelow
	" turn terminal to normal mode with escape
	tnoremap <Esc> <C-\><C-n>
	" start terminal in insert mode
	au BufEnter * if &buftype == 'terminal' | :startinsert | endif
	" open terminal on ctrl+n
	function! OpenTerminal()
	  split term://bash
	  resize 10
	endfunction
	nnoremap <c-n> :call OpenTerminal()<CR>

	" Use alt+hjkl to move between panels
	
	tnoremap <A-h> <C-\><C-n><C-w>h
	tnoremap <A-j> <C-\><C-n><C-w>j
	tnoremap <A-k> <C-\><C-n><C-w>k
	tnoremap <A-l> <C-\><C-n><C-w>l
	nnoremap <A-h> <C-w>h
	nnoremap <A-j> <C-w>j
	nnoremap <A-k> <C-w>k
	nnoremap <A-l> <C-w>l
else
endif


"set multiple-cursors

nmap ,o o<Esc>k
nmap ,o O<Esc>j

map <space> /

set so=3

"set surround

set nu
set relativenumber

inoremap jk <Esc>
inoremap kj <Esc>

