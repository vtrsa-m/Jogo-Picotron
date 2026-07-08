--[[pod_format="raw",created="2026-07-07 21:40:58",modified="2026-07-08 02:29:11",revision=38]]
include "funcoes.lua"
include "exibir.lua"
include "interpretar.lua"
include "error.lua"
cor_fundo = 0
cor_texto = 10
cor_titulo = 10
cor_destaque = 10
cor_caixa = 10
cor_entrada = 10

function _init()
	window{
		title="aventura",
		pauseable=false
	}
end
function criar_vessel(nome,artigo)
  return {
    nome = nome,
    artigo = artigo or "",
    pai = nil,
    filhos = {},
    descricao = "",
    programa = "",
    gatilhos = {},
    bloqueios = {}
  }
end

function iniciar()

	local_atual=criar_vessel("lugar nenhum")

	local_atual.descricao="voce esta no lugar nenhum. o ambiente inicial do programa dream, uma arvore de dados onde podemos brincar de criar mundos conectando e modificando elementos. use o comando ajuda para comecar."

	identidade=nil

end

iniciar()

cmd="criar uma cafeteira, programar cafeteira para (criar um cafe,exibir hmm cafe quentinho, pegar cafe)"

function safe_draw()
	cls()
	
	exibir(cmd)

	if keyp("enter") then
		interpretar(cmd)
		cmd=""
	end

	if keyp("backspace") then
		cmd=sub(cmd,1,#cmd-1)
	end

	while peektext() do
		cmd..=readtext()
	end

end