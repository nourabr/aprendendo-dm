// Váriáveis Constantes

#define GM_KEY "XUPACABRA" // #define define uma variável de texto, numero ou file pra poder reutilizar no código
#define GM_COMMANDS "Comandos de GM"


// Pré-Definições do Mundo
world
	//fps = 25

area/dark
	icon = 'area/dark.dmi'
	luminosity = 0

	verb/palma(){
		set name = "Bater Palma"
		luminosity = 1
	}

turf
	parede
		icon = 'turfs/wall (2).dmi'
		density = 1 // Faz com que o turf seja sólido
		opacity = 1 // Não permite ver dentro

	solo
		icon = 'mato.dmi'



obj/verb
	/*
	get(){ // Verbo para pegar algum objeto
		set name = "Pegar"
		set src in usr.loc // Fonte está dentro da localização do usuário?
		loc = usr

	}

	drop(){ // Verbo para jogar no chão algum objeto
		set name = "Dropar"
		set src in usr // Dentro do usuário está ele mesmo + o seu inventário
		loc = usr.loc
	}
	*/

	get(){
		set src in oview(1) // oview pq não conta o usr nem seus contents
		loc = usr // loc é o lugar pra onde vai o src
	}


	drop(){
		set src in usr
		loc = usr.loc
	}



obj/bola_luz
	name = "Bola de Luz"
	icon = 'objs/bola_luz.dmi'
	luminosity = 7

	verb
		extinguir(){
			set src in view(2) // view() vasculha tudo que está na tela
			set name = "Extinguir"
			set desc = "Apaga as luzes ao seu redor"
			luminosity = 0

		}

		acender(){
			set src in view(2) // view() vasculha tudo que está na tela
			set name = "Acender"
			set desc = "Liga as luzes ao seu redor"
			luminosity = 7
		}

		orar(){
			set name = "Orar"
			set desc = "Você está orando para Jesus te abençoar..."
			set src = view(2) // Trocar o in por = permite que a gente faça algo sem estar dentro do obj - Ou seja, um verbo privado apenas acessível pelo mob quando o obj estiver perto

			world << "Você está orando para Jesus te abençoar..."
		}


obj/pergaminho
	icon = 'turfs/Japanesewall(1).dmi'

	verb
		// Escreve um texto no ícone
		escrever(texto as text)
			set src in oview(1)
			desc = texto

		// Lê o texto escrito no ícone
		ler()
			set src in oview(1)
			usr << desc // O operador << gera uma saída
			// view() << desc // todos da visão irão ver isso


// Personagem
mob

	// Informações gerais do mob
	icon = 'mobs/personagem.dmi' // ícone do mob

	Login()
		//loc = locate (/turf/solo/start) // Manda o mob para este lugar
		loc = locate (25,30,1)
		..() // Caso não consiga fazer o que está acima, faz o padrão
		world << "[usr] acabou de logar!" // Avisa quando o jogador abre o jogo


	verb // Métodos do mob

		// Função que permite o usuário atravessar as paredes
		atravessarParedes(densidade=0 as num){
			set name = "Atravessar Paredes" // Muda o nome do método para o jogador
			set desc = "Te permite atravessar as paredes" // Insere uma descrição para o método
			//set category = GM_COMMANDS // Agrupa na aba com o mesmo nome (se não existir, será criada)
			//set hidden = 1 // Oculta o comando da lista
			density = densidade
			src = /mob/gm // liga o comando a algum lugar, no caso ao mob/gm

		}

		// Função que altera o icone do usuário
		mudarAparencia(icone = 'mobs/personagem.dmi' as icon){
			set src = usr
			set name = "Alterar Aparência"
			set desc = "Transforma sua forma por outra qualquer"
			icon = icone

		}

		// Função que camufla o personagem no mapa
		camuflar(icone as icon | anything in view()){
			icon = icone
		}


		// Função que altera o nome do usuário
		mudarNome(nome as text){
			set name = "Alterar Nome"
			set desc = "(Escreva o seu nome:) Mude o seu nome."
			name = nome
		}

		// Chat Global
		chatGlobal(texto as text){
			set name = "Falar Global"
			world << "(Global) [usr] diz: [texto]"
		}

		// Chat Local
		chatLocal(msg as text)
			set src in view()
			set name = "Falar Local"
			src << "(Local) [usr] diz: [msg]"

		// Chat Sussurro (Whisper)
		chatSussurro(alvo as mob in world, msg as text) // nesse caso o alvo é um parametro tipo mob in/dentro da lista view(1)
			alvo << "[usr] sussurra: [msg]"


		// Função que executa um áudio



mob/gm // Privilégios de GM
	key = GM_KEY // Variável definida para keys superuser
	icon = 'mobs/shinigamis.dmi'
	icon_state = "captain"