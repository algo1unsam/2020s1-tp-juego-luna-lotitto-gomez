import disparo.*
import wollok.game.*
import Nivel.*
import juego.*
import comandos.*
import cornelio.*
import frutilla.*
	
class Enemigo {

	var property vitalidad = 0
	var property hayDisparo = false
	var property image = "obrerosyroundup.png"
	var property position
	var property direccion = izquierda


	method perderVitalidad(objeto) {
	}

	method recibirDisparo(disparo) {
	}

	method recibirDanio(disparo) {
		disparo.desaparecer()
		self.desaparecer()
	}

	method desaparecer() {
		juego.nivel().todosLosEnemigos().remove(self)
		const die = game.sound("explosion.wav")
		die.play()
		game.removeVisual(self)
	}

	method colisionarCon(objeto) {
	}

	method caminar() {
		direccion.mover(self)
	}

	method moverse(orientacion) {
		if (juego.puedeMoverse(orientacion)) {
			self.position(orientacion)
		} else {
			self.cambiarOrientacion()
		}
	}

	method cambiarOrientacion() {
		direccion = direccion.opuesto()
	}

	method devolverDisparo() = new DisparoEnemigo(velocidad = 300, image = "disparoEnemigo.png", direccion = izquierda, sonidoDisparo = game.sound("disparoCornelio.mp3"), position = game.at(self.position().x(), self.position().y()))

	method disparar() {
		if (!hayDisparo and game.hasVisual(self)) {
			(juego.nivel().devolverDisparoEnemigo(self.position())).aparecer()
		}
	}

	method subirVitalidad(objeto) {
	}

}


object posiciones {
	var property enemigos = [ game.at(10,3), game.at(11,3), game.at(12,3), game.at(10,5), game.at(11,5), game.at(12,5), game.at(10,7), game.at(11,7), game.at(12,7) ]
	var property items = [game.at(0,1), game.at(0,3), game.at(0,5), game.at(2,1), game.at(2,3), game.at(2,5),game.at(4,1), game.at(4,3), game.at(4,5),
		game.at(6,1), game.at(6,3), game.at(6,5),game.at(8,1), game.at(8,3), game.at(8,5),
		game.at(10,1), game.at(10,3), game.at(10,5),game.at(12,1), game.at(12,3), game.at(12,5),
		game.at(14,1), game.at(14,3), game.at(14,5)]
	

	

}

