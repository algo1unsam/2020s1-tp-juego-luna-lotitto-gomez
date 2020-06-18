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

	method recibirDanio(disparo){
		
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
		theme.volume(0.5)
		theme.shouldLoop(true)
	}

	method recibirDisparo(disparo) {
	}

	method cargar() {
		game.addVisual(self)
		self.cargarSonido()
		game.addVisual(cornelio)
		game.showAttributes(cornelio)
		self.cargarEnemigos()
		self.cargarItems()
		self.cargarCondiciones()
		comandos.cargar()
	}

	method cargarCondiciones() {
		self.todosLosEnemigos().forEach{ enemigo =>
			game.onTick(500, "caminar", { enemigo.caminar()})
			game.onTick(1000, "disparar", { enemigo.disparar()})
		}
		game.onTick(0, "finalizar juego", { self.validarFinal()})
		game.onTick(0, "morir", { self.perder()})
		game.onTick(0, "actualizar cornelio", { cornelio.actualizarImagen()})
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
	
	method devolverDisparoEnemigo(_position) = 0
}

object nivelUno inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"), siguienteNivel = nivelDos, itemsEstaticos = [ palanca ], itemsDinamicos = [ cafiaspirina ]) {

	override method devolverDisparo() = new DisparoCornelio(velocidad = 200, direccion = derecha, image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))
	
	override method devolverDisparoEnemigo(_position) = new DisparoEnemigo(velocidad = 300, image = "disparoEnemigo.png", direccion = izquierda, sonidoDisparo = game.sound("disparoCornelio.mp3"), position = game.at(_position.x(), _position.y()))
	
	override method image() = "nivel1-fondo.png"

	override method validarFinal() {
		if (self.todosLosEnemigos().isEmpty() and palanca.estasActivada()) self.finalizar()
	}

	override method cargarEnemigos() {
		8.times{ i => todosLosEnemigos.add(new Enemigo(position = posiciones.enemigos().get(i)))}
		super()
	}

	override method cargar() {
		super()
		arbitro.cargarColisionesNivelUno()
	}

	override method restart() {
		super()
		palanca.alta(true)
	}

}

object nivelDos inherits Nivel(theme = game.sound("CorneliusGameNivel2Theme.mp3"), itemsEstaticos = [  ], siguienteNivel = nivelTres, itemsDinamicos = [ cafiaspirina ]) {

	var property boss = new Frutilla(image = "straw.png", position = game.at(3, 7))
	
	override method devolverDisparoEnemigo(_position) = new DisparoEnemigo(velocidad = 300, image = "disparoEnemigo2.png", direccion = abajo, sonidoDisparo = game.sound("disparoCornelio.mp3"), position =_position)
	
	override method devolverDisparo() {
		return if (!game.hasVisual(antidoto) and boss.estoySola()) {
			new DisparoEspecial(velocidad = 200, image = "disparoespecial.png", direccion = arriba, position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))
		} else {
			new DisparoCornelio(velocidad = 200, direccion = arriba, image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))
		}
	}

	override method image() = "nivel2-fondo.jpeg"

	override method cargarEnemigos() {
		8.times({ i => todosLosEnemigos.add(new Enemigo(image = "Enem1L.png", position = posiciones.enemigos().get(i)))})
		todosLosEnemigos.add(boss)
		super()
	}

	override method cargar() {
		super()
		arbitro.cargarColisionesNivelDos()
	}

	override method cargarCondiciones() {
		super()
		game.onTick(0, "frutilla sola", { boss.mutar()})
	}

	override method validarFinal() {
		if (self.todosLosEnemigos().isEmpty()) self.finalizar()
	}

}

object nivelTres inherits Nivel(theme = game.sound("CorneliusGameNivel3Theme.mp3"), siguienteNivel = nivelCuatro) {

	var property boss = new Boss(image = "subjefederecha.png", position = game.at(1, 6))
	
	override method image() = "nivel3-fondo.png"
	override method devolverDisparoEnemigo(_position) =new DisparoEnemigo(velocidad = 20,direccion = abajo,sonidoDisparo = game.sound("disparoCornelio.mp3"),image = 'disparosubjefelisto.png', position = _position)

	override method devolverDisparo() = new DisparoCornelio(velocidad = 200, direccion = arriba, image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))
	
	override method cargarEnemigos() {
		todosLosEnemigos.add(boss)
		super()
	}


	override method validarFinal() {
		if (boss.estaMuerto()) self.finalizar()
	}

}

object nivelCuatro inherits Nivel(theme = game.sound("CorneliusGameNivel4Theme.mp3"), siguienteNivel = nivelUno) {

	var property boss = new Boss(image = "jefe.png", position = game.at(1, 6))

	override method devolverDisparo() = new DisparoCornelio(velocidad = 150, direccion = arriba, image = "grano.png", position = cornelio.position(), sonidoDisparo = game.sound("disparoCornelio.mp3"))
	override method devolverDisparoEnemigo(_position) =new DisparoEnemigo(velocidad = 300, image = "disparosubjefelisto.png", direccion = abajo, sonidoDisparo = game.sound("disparoCornelio.mp3"), position = _position)
	override method image() = "nivel4-fondo.png"
	
	override method cargarEnemigos() {
		todosLosEnemigos.add(boss)
		
		super()
	}
	override method cargarItems(){
		posiciones.items().forEach{ i => itemsEstaticos.add(new ItemEstatico(image = "criptonita.png", position = i))}
		super()
	}

	override method cargar() {
		super()
		arbitro.cargarColisionesNivelCuatro()
	}
	override method validarFinal(){
		if(boss.estaMuerto()) self.finalizar()
	}
	override method finalizar(){
		theme.stop()
		game.clear()
		pantallaFinal.cargar()
	}

}

