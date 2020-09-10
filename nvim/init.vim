call plug#begin()
" Server configurations for builtin nvim LSP client
Plug 'neovim/nvim-lspconfig'

" movements for commenting code (using gc<movement>)
Plug 'tpope/vim-commentary'
" Git extensions
Plug 'tpope/vim-fugitive'
" netrw enhancements
Plug 'tpope/vim-vinegar'

" handles installing fzf for the terminal
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" fzf extensions
Plug 'junegunn/fzf.vim'
" Nice status bar
Plug 'itchyny/lightline.vim'
" Enhanced syntax higlighting for various languages (not complete due to
" limitations the syntax recognition in vim/nvim
Plug 'sheerun/vim-polyglot'
" Diagnostic jump-to and alternate display by using the popup-menu (pum)
" instead of virtual text, which is truncated by the edge of the window
Plug 'nvim-lua/diagnostic-nvim'

" Adds builtin support for generating doxygen comments based on code under the
" cursor
Plug 'vim-scripts/DoxygenToolkit.vim' 

" colorscheme
Plug 'sainnhe/sonokai'
call plug#end()
colorscheme sonokai

" Allows folding (z<movement>) to recognize syntax folding rules, i.e. folding
" on braces for C/C++
set foldmethod=syntax
" Set text to be unfolded by default
set nofoldenable
" enable syntax highlighting
syntax enable
" display line numbers
set number 

" if hidden is not set, TextEdit might fail.
set hidden

" set all tabs and shifts (<</>>) to be 4 columns wide
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Better display for messages
set cmdheight=2
set timeoutlen=50

" don't give |ins-completion-menu| messages.
set shortmess+=c 

" display signs in the line number column
set signcolumn=number 

" Use our horizontal real estate to show the 3-way diff
set diffopt+=vertical

" Enable the CCLS language server. This overwrites the default diagnostic
" behavior to use the diagnostic-nvim plugin
lua <<EOF
require'nvim_lsp'.ccls.setup{on_attach=require'diagnostic'.on_attach}
EOF

" Use LSP omni-completion in C++ files.
autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
" nvim.lsp remaps
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <F12> <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <c-p> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nmap <silent> [c <cmd>NextDiagnosticCycle
nmap <silent> ]c <cmd>PrevDiagnosticCycle

let g:lightline = {
			\ 'active': {
			\	'left': [ [ 'mode', 'paste'],
			\			[ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\	'gitbranch': 'FugitiveHead'
			\ },
			\ }

" Remapping of <Esc> to allow fingrers to never leave home keys, and allow
" terminal mode to support vi keybindings in the shell
inoremap <silent>jk <Esc>
tnoremap <silent>jk <C-\><C-n>

" Easy switching between windows
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remove highlights caused by searching
nnoremap <C-x> :nohl<cr>

" mapping for fzf
nnoremap <C-g> :Rg<Cr>
nnoremap <C-f> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>

" Shortcuts for code reformatting
nnoremap <silent> <F4> :py3f /home/trollham/.local/share/clang/clang-format.py<cr>
vnoremap <silent> <F4> :py3f /home/trollham/.local/share/clang/clang-format.py<cr>
inoremap <silent> <F4>:py3f /home/trollham/.local/share/clang/clang-format.py<cr>
