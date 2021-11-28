set number 
syntax on
set splitbelow
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set splitbelow
set splitright
set ignorecase
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set backspace=indent,eol,start
set clipboard=unnamed

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <F6> :terminal<CR>source $HOME/.bash_profile<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <leader>d "_d
xnoremap <leader>p "_dP

call plug#begin('~/.vim/plugged')

"" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'preservim/nerdtree'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()   }   }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'https://github.com/jiangmiao/auto-pairs'

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'mhinz/vim-signify', { 'branch': 'legacy'   }
Plug 'chrisbra/changesPlugin'

Plug 'zivyangll/git-blame.vim'

"" Initialize plugin system
call plug#end()

colorscheme onedark

"" ==========> NERDTree Config <========== 
let NERDTreeShowHidden=1
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
let NERDTreeRespectWildIgnore=1
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" ==========> COC Config <========== 
let g:coc_global_extensions = [
      \ 'coc-ultisnips',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-yaml',
      \ 'coc-highlight',
      \ 'coc-tslint',
      \ 'coc-git',
      \ 'coc-prettier',
      \ 'coc-flutter',
      \ 'coc-pyright',
      \ 'coc-angular'
      \ ]
"" GoTo code navigation.
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"" ==========> FZF Config <========== 
nnoremap <silent> <C-S-p> :Files<CR>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find . -path './.git' -prune -o -path './.next' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
"" FZF Search content in file
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <Leader>f :Rg<CR>

"" ==========> Prettier <========== 
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
let g:prettier#autoformat = 1


"" ==========> vim-airline <========== 
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#hunks#coc_git = 1
let g:airline_powerline_fonts=1

"" airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
  
"" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = 'ln'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.colnr='col'"


"" Git
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

"" Python
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set sts=4
autocmd BufWritePre *.py execute ':Black'
