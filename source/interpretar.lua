--[[pod_format="raw",created="2026-07-07 21:52:51",modified="2026-07-08 02:22:58",revision=80]]

function aparar(s)
    return s:match("^%s*(.-)%s*$")
end

function dividir_comandos(cmd)
    local resultado = {}
    local atual = ""
    local dentro_parenteses = false

    for i = 1, #cmd do
        local char = sub(cmd, i, i)

        if char == "(" then
            dentro_parenteses = true
            atual = atual .. char

        elseif char == ")" then
            dentro_parenteses = false
            atual = atual .. char

        elseif char == "," and not dentro_parenteses then
            add(resultado, aparar(atual))
            atual = ""

        else
            atual = atual .. char
        end
    end

    if #atual > 0 then
        add(resultado, aparar(atual))
    end

    return resultado
end

function interpretar(cmd)
	local t = dividir_comandos(cmd)
	for i=1,#t do
		executar(t[i])
	end
end

function executar(cmd)

	local t = split(cmd," ")

	if t[1]=="criar" then

		local nome=""
		for i=2,#t do
			nome=nome..t[i].." "
		end
		nome=aparar(nome)

		if nome~="" then
			criar(nome)
		else
			saida="use: criar <nome>"
		end


	elseif t[1]=="entrar" and t[2]=="em" then

		if t[3] then
			entrar(t[3])
		else
			saida="use: entrar em <local>"
		end


	elseif t[1]=="sair" then

		sair()


	elseif t[1]=="me" and t[2]=="tornar" then

		local nome=""
		for i=3,#t do
			nome=nome..t[i].." "
		end
		nome=aparar(nome)

		if nome~="" then
			me_tornar(nome)
		else
			saida="use: me tornar <nome>"
		end


	elseif t[1]=="pegar" then

		if t[2] then
			pegar(t[2])
		else
			saida="use: pegar <objeto>"
		end


	elseif t[1]=="soltar" then

		if t[2] then
			soltar(t[2])
		else
			saida="use: soltar <objeto>"
		end


	elseif t[1]=="usar" then

		if t[2] then
			usar(t[2])
		else
			saida="use: usar <objeto>"
		end


	elseif t[1]=="descrever" and t[3]=="como" then

		if not t[2] then
			saida="use: descrever <objeto> como <descrição>"
			return
		end

		local desc=""
		for i=4,#t do
			desc=desc..t[i].." "
		end

		desc=aparar(desc)

		if desc~="" then
			descrever(t[2],desc)
		else
			saida="descrição vazia"
		end


	elseif t[1]=="programar" then

		if not t[2] then
			saida="use: programar <objeto> para <comando>"
			return
		end

		if t[3]=="para" then

			local bloco=""

			for i=4,#t do
				bloco=bloco..t[i].." "
			end

			bloco=aparar(bloco)

			if bloco~="" then
				programar(t[2],bloco)
			else
				saida="programa vazio"
			end

		else
			saida="formato errado. use: programar x para ( y )"
		end


	elseif t[1]=="exibir" then

		local texto=""

		for i=2,#t do
			texto=texto..t[i].." "
		end

		texto=aparar(texto)

		if texto~="" then
			escrever(texto)
		else
			saida="use: exibir <texto>"
		end


	elseif t[1]=="ajuda" then

		ajuda(t[2])


	else

		saida='comando "'..cmd..'" nao existe'

	end
end