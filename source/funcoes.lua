--[[pod_format="raw",created="2026-07-07 21:49:31",modified="2026-07-08 02:31:24",revision=68]]

function split_texto(texto,tamanho)

	local linhas={}
	local linha=""

	for palavra in all(split(texto," ")) do

		if #linha+#palavra+1>tamanho then
			add(linhas,linha)
			linha=palavra
		else
			if linha!="" then
				linha=linha.." "
			end

			linha=linha..palavra
		end

	end

	if linha!="" then
		add(linhas,linha)
	end

	return linhas

end
function criar(texto)

	local artigo,nome=separar_artigo(texto)
	if not artigo or nome=="" then
		saida="use um artigo antes do nome"
		return
	end

	local v=criar_vessel(nome,artigo)

	v.pai=local_atual
	add(local_atual.filhos,v)

end

function listar_nomes(lista)

	local frase=""

	for i,nome in ipairs(lista) do

		if i==1 then
			frase=nome

		elseif i==#lista then
			frase=frase.." e "..nome

		else
			frase=frase..", "..nome
		end

	end

	return frase
end

function nome_completo(v)

	if v.artigo!="" then
		return v.artigo.." "..v.nome
	end

	return v.nome

end

function separar_artigo(texto)

	local t=split(texto," ")

	local artigo=t[1]

	if artigo!="um" 
	and artigo!="uma" 
	and artigo!="o" 
	and artigo!="a" then

		return nil,nil
	end

	return artigo,t[2]
end

function entrar(nome)
	local v=procurar_filho(local_atual,nome)

	if v then
		local_atual=v
	else
		saida=nome.." nao existe"
	end
end

function sair()
	if local_atual.pai then
		saida="voce saiu de "..local_atual.nome
		local_atual=local_atual.pai
		
	else
		saida="nao ha para onde sair"
	end
end


function procurar_filho(pai,nome)
	for v in all(pai.filhos) do
		if v.nome==nome then
			return v
		end
	end
end
function me_tornar(nome)
	local v=procurar_filho(local_atual,nome)

	if v then
		identidade=v
	else
		saida=nome.." nao existe"
	end
end

function pegar(nome)
	if not identidade then
		saida="voce nao pode pegar algo sem um corpo"
		return
	end

	local v=procurar_filho(local_atual,nome)

	if v then
		del(local_atual.filhos,v)
		add(identidade.filhos,v)
		v.pai=identidade
	else
		saida=nome.." nao existe"
	end
end

function usar(nome)

	local v=procurar_filho(local_atual,nome)

	if v then
		if v.programa!="" then
			interpretar(sub(v.programa,2,#v.programa-1))
		else
			saida=nome.." nao foi programado"
		end
	else
		saida=nome.." nao existe"
	end
end


function soltar(nome)
	if not identidade then
		saida="voce nao possui itens para soltar ja que nao possui corpo"
		return
	end

	local v=procurar_filho(identidade,nome)

	if v then
		del(identidade.filhos,v)
		add(local_atual.filhos,v)
		v.pai=local_atual
		saida="voce soltou "..nome
	else
		saida="voce nao tem nenhum"..nome
	end
end


function descrever(nome, desc)
	if nome == local_atual.nome then
		local_atual.descricao = desc
		return
	end
	local v = procurar_filho(local_atual, nome)
	if v then
		v.descricao = desc
		return
	end

	if identidade then
		v = procurar_filho(identidade, nome)
		if v then
			v.descricao = desc
			return
		end
	end
	
	saida = nome.." nao existe"
end

function programar(nome, bloco)
  local v = nil
  
  v = procurar_filho(local_atual, nome)
  
  if not v and identidade then
    v = procurar_filho(identidade, nome)
  end
  
  if v then
    v.programa = bloco
  else
    saida = nome.." nao existe"
  end
end

function escrever(texto)
  saida = texto
end

function debug(x)
	while not keyp("space") do cls() print(x) flip() end flip()
end




ajudas={
	criar="cria um novo vessel dentro do local atual. voce deve informar um artigo antes do nome.\nexemplos: criar um fantasma, criar uma espada, criar uma porta",

	entrar="move sua localizacao para dentro de um vessel que esteja no local atual.\nexemplo: entrar em biblioteca",

	sair="volta para o vessel que contem o local atual.\nfunciona apenas se o local atual possuir um pai",

	me_tornar="define qual vessel representa sua identidade.\na identidade fica separada do local e pode carregar outros objetos.\nexemplo: me tornar fantasma",

	pegar="move um vessel do local atual para dentro da sua identidade.\npegar nao cria um inventario separado, apenas muda o pai do objeto.\nexemplo: pegar espada",

	soltar="move um vessel que esta dentro da sua identidade para o local atual.\n exemplo: soltar espada",

	descrever="altera a descricao de um vessel.\na descricao sera exibida quando voce estiver naquele local.\nexemplo: descrever biblioteca um lugar cheio de livros",

	programar="adiciona um comportamento de texto a um vessel.\no programa sera executado quando o sistema chamar esse comportamento.\nexemplo: programar porta para ( abrir )",

	exibir="mostra uma mensagem na tela.\npode ser usado para criar textos ou respostas personalizadas.\nexemplo: exibir hello world",

	ajuda="mostra a lista de comandos disponiveis ou explica como usar um comando especifico."
}


function ajuda(comando)

	if comando and ajudas[comando] then

		saida=ajudas[comando]

	else

		saida="comandos disponiveis:\n"

		saida=
[[
criar   entrar      sair        me_tornar   pegar  
soltar  descrever   programar   exibir      ajuda
]]

		saida=saida.."\nescreva ajuda seguido de um comando para saber mais."

	end

end