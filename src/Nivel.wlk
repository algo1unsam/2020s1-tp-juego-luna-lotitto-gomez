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
	var property position = game.at(0, 0)
	var property siguienteNivel = 0
	var property theme = ""
	var property todosLosEnemigos = []
	

	

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

	method cargarEnemigos() {
		self.todosLosEnemigos().forEach{ enemigo => game.addVisual(enemigo)}
	}

	method cargarSonido() {
		if (theme.paused()) {
			theme.resume()
		} else {
			theme.play()
		}
		theme.volume(0.01)
		theme.shouldLoop(true)
	}
		method recibirDisparo(disparo){
		
	}
	

	method cargar() {
		game.addVisual(self)
		self.cargarSonido()
		self.cargarItems()
		game.addVisual(cornelio)
		game.showAttributes(cornelio)
		self.cargarEnemigos()
		self.cargarCondiciones()
		comandos.cargar()
	}

	method cargarCondiciones() {

		self.todosLosEnemigos().forEach{ enemigo =>
			game.onTick(500, "caminar", { enemigo.caminar()})
			game.onTick(1000, "disparar", { enemigo.disparar()})
			
		}
		//TODO: actualizar imagen, fede dibujalo
		//game.onTick(0,"actualizar imagen",cornelio.actualizarImagen())
		game.onTick(0, "finalizar juego", { self.validarFinal()})
		game.onTick(0, "morir", { self.perder()})
		//game.onTick(0,"actualizar cornelio",{cornelio.actualizarImagen()})		
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
		if (cornelio.estaMuerto()) {
			theme.pause()
			game.clear()
			gameOver.cargar()
		}
	}

	method restart() {
		cornelio.restart()
		todosLosEnemigos.clear()
		
	}
	method devolverDisparo() = 0
	
}

object nivelUno inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), siguienteNivel = nivelDos, itemsEstaticos = [ palanca ], itemsDinamicos = [ cafiaspirina ]) {
	
	override method devolverDisparo() = new DisparoCornelio(direccion = derecha,image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))

	override method image() = "nivel1-fondo.png"

	override method validarFinal() {
		if (self.todosLosEnemigos().isEmpty() and palanca.estasActivada()) self.finalizar()
	}

	override method cargarEnemigos() {
		8.times{ i => todosLosEnemigos.add(new Enemigo(position = posicionesEnemigos.pos().get(i)))}
		super()
	}


	override method cargar() {
		super()
		arbitro.cargarColisionesNivelUno()
	}
	override method restart(){
		super()
		palanca.alta(true)
	}

}

object nivelDos inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), itemsEstaticos = [  ],siguienteNivel = nivelTres, itemsDinamicos = [ cafiaspirina ]) {
			
	var property boss = new Frutilla(image ="straw.png", position = game.at(3,8))
	
	override method devolverDisparo() {
	return	if (!game.hasVisual(antidoto) and boss.estoySola()){
			new DisparoEspecial(direccion = arriba, position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))
		}else{new DisparoCornelio2(direccion = arriba,image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))}
	} 
	
	override method image() = "nivel2-fondo.jpeg"

	override method cargarEnemigos() {
		8.times({ i => todosLosEnemigos.add(new Enemigo2(image = "Enem1L.png", position = posicionesEnemigos.pos().get(i)))})
		todosLosEnemigos.add(boss)
		super()
	}
	

	override method cargar() {
		
		super()
		arbitro.cargarColisionesNivelDos()
	}
	override method cargarCondiciones(){
		super()
		game.onTick(0,"frutilla sola",{boss.mutar()})
	}
	override method validarFinal(){
		if (self.todosLosEnemigos().isEmpty()) self.finalizar()
	}

}

object nivelTres inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), siguienteNivel = nivelUno){
	
	var property boss  = new Boss(image ="straw.png", position = game.at(1,6))
	
	override method devolverDisparo() = new DisparoCornelio2(direccion = arriba,image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))

	override method cargarEnemigos(){
		todosLosEnemigos.add(boss)
		super()
	}
	

	override method image() = "nivel1-fondo.png" 
	override method validarFinal(){
		if (boss.estaMuerto()) self.finalizar()
	}
}

object nivelCuatro inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), siguienteNivel = nivelCuatro){
//	var property boss
//	override method cargarEnemigos(){
//		todosLosEnemigos.add(boss)
//		super()
//	}
}