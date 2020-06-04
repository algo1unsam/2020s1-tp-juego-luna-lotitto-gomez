import juego.*
import pantallaInicial.*
import wollok.game.*
import Enemigos.*
import cornelio.*
import palanca.*
import items.*
import comandos.*
import arbitro.*
import frutilla.*
import disparo.*

class Nivel {

	var property itemsDinamicos = []
	var property itemsEstaticos = []
	var property enemigos1 = []
	var property enemigos2 = []
	var property enemigos3 = []
	var property position = game.at(0, 0)
	var property siguienteNivel = 0
	var property theme = ""
	var property disparo

	method image() = ""

	method get_objects() = game.allVisuals()

	method cargarItems() {
		if (!itemsDinamicos.isEmpty()) itemsDinamicos.forEach{ item => game.addVisual(item) }
		if (!itemsEstaticos.isEmpty()) itemsEstaticos.forEach{ item => game.addVisual(item) }
	}

	// ESTO PASA PORQUE EL NIVEL ES UN OBJETO
	method colisionarCon(objeto) {
	}

	// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	method todosLosEnemigos() = enemigos1 + enemigos2 + enemigos3

	method cargarEnemigos() {
		self.todosLosEnemigos().forEach{ enemigo => game.addVisual(enemigo)}
	}

	method cargarSonido() {
		if (theme.paused()) {
			theme.resume()
		} else {
			theme.play()
		}
		theme.volume(0.2)
		theme.shouldLoop(true)
	}

	method cargar() {
		game.addVisual(self)
		self.cargarSonido()
		self.cargarItems()
		game.addVisual(cornelio)
		game.showAttributes(cornelio)
		self.cargarEnemigos()
			// TODO: agregar power ups?, palanca?, items de ayuda?
		self.cargarCondiciones()
		comandos.cargar()
	}

	method cargarCondiciones() {
		self.todosLosEnemigos().forEach{ enemigo =>
			game.onTick(500, "caminar", { enemigo.caminar()})
			game.onTick(1000, "disparar", { enemigo.disparar()})
			game.onTick(200, "moverDisparo", { enemigo.moverDisparo()})
		}
		game.onTick(300, "mover disparo cornelio", { cornelio.moverDisparo()})
		game.onTick(0, "finalizar juego", { self.validarFinal()})
		game.onTick(0, "morir", { self.perder()})
	}

	method validarFinal() {
	}

	method finalizar() {
		theme.stop()
		game.clear()
		juego.cambiarNivel(siguienteNivel)
		juego.cargar()
	}

	method perder() {
		if (cornelio.vitalidad() == 0) {
			theme.pause()
			game.clear()
				// poner sonido de game over
			gameOver.cargar()
		}
	}

	method restart() {
		cornelio.disparo(0)
		cornelio.vitalidad(100)
		cornelio.position(new Position(x = 0, y = 3))
		enemigos1.clear()
		enemigos2.clear()
		enemigos3.clear()
		palanca.alta(true)
	}

	method devolverDisparo()

}

object nivelUno inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), siguienteNivel = nivelDos, itemsEstaticos = [ palanca ], itemsDinamicos = [ cafiaspirina ]) {

	override method devolverDisparo() = new DisparoCornelio(image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))

	override method image() = "nivel1-fondo.png"

	override method validarFinal() {
		if (self.todosLosEnemigos().isEmpty() and palanca.estasActivada()) self.finalizar()
	}

	override method cargarEnemigos() {
		3.times{ i => enemigos1.add(new Enemigo(position = game.at(10 + i, 0)))}
		3.times{ i => enemigos2.add(new Enemigo(position = game.at(10 + i, 4)))}
		3.times{ i => enemigos3.add(new Enemigo(position = game.at(10 + i, 7)))}
		super()
	}

	/*override method cargarCondiciones()
	 * { 
	 * 	self.todosLosEnemigos().forEach{ enemigo=>
	 * 		
	 * 		game.onTick(500,"caminar",{enemigo.caminar()})
	 * 		game.onTick(1000, "disparar",{enemigo.disparar()})
	 * 		game.onTick(200, "moverDisparo",{enemigo.moverDisparo()})	
	 * 	}	
	 * 	game.onTick(300,"mover disparo cornelio",{cornelio.moverDisparo()})
	 * 	game.onTick(0,"finalizar juego", {self.validarFinal()})
	 * 	game.onTick(0,"morir",{ self.perder()}) 	
	 }*/
	override method cargar() {
		super()
		arbitro.cargarColisionesNivelUno()
	}

}

object nivelDos inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), itemsEstaticos = [  ], itemsDinamicos = [ cafiaspirina ]) {
			
			var frutilla = new Enemigo2(image ="straw.png",position = game.at(5,8))
	
	override method devolverDisparo() = new DisparoCornelio2(image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))

	override method image() = "nivel2-fondo.jpeg"

	override method cargarEnemigos() {
		1.times({ i => enemigos1.add(new Enemigo2(image = "Enem1L.png", position = game.at(1 + i, 4 + i)))})
		1.times({ i => enemigos2.add(new Enemigo2(image = "Enem1L.png", position = game.at(1 + i, 4 + i)))})
		1.times({ i => enemigos3.add(new Enemigo2(image = "Enem1L.png", position = game.at(1 + i, 4 + i)))})
		enemigos2.add(new Frutilla(image ="straw.png", position = game.at(3,8)))
		super()
	}
	
	override method cargar() {
		
		super()
		arbitro.cargarColisionesNivelDos()
	}
	
	override method cargarCondiciones(){
		super()	
	}

}

