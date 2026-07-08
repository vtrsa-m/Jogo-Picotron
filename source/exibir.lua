--[[pod_format="raw",created="2026-07-07 21:52:13",modified="2026-07-08 01:58:50",revision=68]]
function exibir(cmd)

	cls(cor_fundo)

	local amarelo=cor_texto

	local x=30
	local y=30


	-- titulo
	local titulo=""

	if identidade then
		titulo="voce e "..nome_completo(identidade)
	else
		titulo="voce nao e ninguem"
	end

	if local_atual then
		titulo=titulo..", em "..nome_completo(local_atual)
	end

	print(titulo..".",x,y,cor_titulo)

	y+=30


	-- descricao do local
	if local_atual.descricao and local_atual.descricao!="" then

		for linha in all(split_texto(local_atual.descricao,80)) do
			print(linha,x,y,amarelo)
			y+=10
		end

		y+=10
	end


	-- coisas no local
	local vistos={}

	for v in all(local_atual.filhos) do
		if v!=identidade then
			add(vistos,nome_completo(v))
		end
	end

	if #vistos>0 then

		print("voce ve "..listar_nomes(vistos)..".",x,y,amarelo)

		y+=20
	end


	-- inventario
	if identidade and #identidade.filhos>0 then

		local itens={}

		for v in all(identidade.filhos) do
			add(itens,nome_completo(v))
		end

		print("voce carrega "..listar_nomes(itens)..".",x,y,amarelo)

		y+=20
	end


	-- mensagem do jogo
	if saida and saida!="" then
		print(saida,x,y,cor_destaque)
	end
	
	y=235
	local temp=split_texto(cmd,80)
	print(">",x-10,y+5,amarelo)
	for linha in all(temp) do
		print(linha..(t()%1<0.5 and linha==temp[#temp]and "_" or ""),x,y,amarelo)
		y+=10
	end

end