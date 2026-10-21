let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd /mnt/Arquivos/ElixirWorks/CtfTelemetry
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +28 mix.exs
badd +15 lib/ctf_telemetry/application.ex
badd +5 lib/ctf_telemetry/repo.ex
badd +8 config/config.exs
badd +4 priv/repo/migrations/20261019212448_create_database.exs
badd +17 ../MaxGallery/lib/max_gallery/core/user.ex
badd +48 ~/.config/nvim/keys/mappings.vim
badd +9 lib/core/players.ex
badd +43 ~/.config/nvim/lua/lsp/elixir-lsp.lua
badd +13 lib/ctf_telemetry/core/api/players.ex
badd +24 ../MaxGallery/lib/max_gallery/core/api/user_api.ex
badd +3 lib/ctf_telemetry/core/players.ex
badd +108 /mnt/Arquivos/ElixirWorks/MaxGallery/lib/max_gallery/context.ex
badd +1 ../MaxGallery/lib/max_gallery.ex
badd +1 ../MaxGallery/lib/max_gallery/release.ex
badd +5 lib/ctf_telemetry/context.ex
badd +20 ../MaxGallery/lib/max_gallery/core/api/cypher_api.ex
badd +19 ../MaxGallery/lib/max_gallery/core/api/group_api.ex
badd +1 lib/ctf_telemetry/core/api/players_api.ex
badd +1 ../Hack/mix.exs
badd +3 lib/ctf_telemetry/cli.ex
badd +27 lib/ctf_telemetry.ex
badd +16 lib/ctf_telemetry/server/reader_server.exs
badd +3 ../MaxGallery/lib/max_gallery/server/live_server.ex
badd +2 ../MaxGallery/lib/max_gallery/application.ex
badd +13 lib/ctf_telemetry/server/reader_server.ex
badd +5 .gitignore
argglobal
%argdel
$argadd mix.exs
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit mix.exs
argglobal
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 28 - ((26 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 28
normal! 034|
tabnext
edit lib/ctf_telemetry/application.ex
argglobal
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 13 - ((12 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 13
normal! 024|
tabnext
edit lib/ctf_telemetry.ex
argglobal
balt lib/ctf_telemetry/cli.ex
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 27 - ((15 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 27
normal! 0
tabnext
edit lib/ctf_telemetry/server/reader_server.ex
argglobal
balt lib/ctf_telemetry/server/reader_server.exs
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 13 - ((12 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 13
normal! 013|
tabnext
edit config/config.exs
argglobal
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 8 - ((7 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 023|
tabnext
edit lib/ctf_telemetry/context.ex
argglobal
balt lib/ctf_telemetry/core/api/players.ex
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 8 - ((7 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 019|
tabnext 4
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
