import cornelio.*
import Enemigos.*
import wollok.game.*
import Nivel.*
import juego.*
import frutilla.*

class Disparo {

	var property image = ""
	var property position
	
	// TODO: Los márgenes y límites están en el objeto juego, debería usarse ese objeto.
	var property margenIzquierdo = 1
	var property margenDerecho = 14
	var property limiteInferior = 0
	var property limiteSuperior = 9
	var property sonidoDisparo = 0

	// TODO: trucho
	method subirVitalidad(objeto) {
	}

	method recibirDanio() {
	}

	method aparecer() {
		game.sound(sonidoDisparo)
		sonidoDisparo.volume(0.1)
		sonidoDisparo.play()
		game.addVisual(self)
		// TODO: Para pensar: que el disparo sepa moverse, impactar y desaparecer
		// game.onTick(300, "mover disparo" + self.identity().toString(), { self.moverDisparo() })
		// También se podría configurar la colisión acá.
	}

	method moverDisparo()

	// TODO: revisar si es necesario especificar el objeto
	method impactar()

	method fueraDeEscena()

	method desaparecer()
// TODO:
//	{ 
//		game.removeTickEvent("mover disparo" + self.identity().toString())
//		game.removeVisual(self)	
//	}

}

class DisparoCornelio inherits Disparo {

	method colisionarCon(objeto) {
		// aca hay problemas cuando la bala choca con cornelio
		//TODO: chequear
		
		if (objeto == cornelio) {
		} else {
			objeto.recibirDanio()
			self.desaparecer()
		}
	}

	override method sonidoDisparo() {
		sonidoDisparo = "disparoCornelio.mp3"
	}

	override method moverDisparo() {
		if (!self.fueraDeEscena()) {
			self.position(self.position().right(1))
		} else {
			self.desaparecer()
		}
	}

	override method desaparecer() {
		cornelio.disparo(0)
		game.removeVisual(self)
	}

	override method fueraDeEscena() = self.position().x() >= margenDerecho

	method impactar(objeto) {
		//TODO: DELEGAR juego.nivel().eliminar(enemigo) 
		juego.nivel().enemigos1().remove(objeto)
		juego.nivel().enemigos2().remove(objeto)
		juego.nivel().enemigos3().remove(objeto)
		game.removeVisual(objeto)
	}

	override method impactar() {
	}

}
class DisparoCornelio2 inherits DisparoCornelio{
	
	// TODO: Pensar en abstraer la lógica de la dirección del disparo aprovechando los objetos direcciones.
	override method moverDisparo() {
		if (!self.fueraDeEscena()) {
			self.position(self.position().up(1))
		} else {
			self.desaparecer()
		}
	}

	override method fueraDeEscena() = self.position().y() >= limiteSuperior
	
}

class DisparoEnemigo inherits Disparo {

	override method image() = "disparoEnemigo.png"

	method colisionarCon(objeto) {
		objeto.perderVitalidad()
		self.desaparecer()
	}

	override method sonidoDisparo() {
		sonidoDisparo = "cornelioDisparo.mp3"
	}

	override method moverDisparo() {
		if (game.hasVisual(self)) {
			if (!self.fueraDeEscena()) {
				self.position(self.position().left(1))
			} else {
				self.desaparecer()
			}
		}
	}

	method buscandoShooter() = juego.nivel().todosLosEnemigos().find{ enemigo => enemigo.disparo() == self }

	method estoyCargado() = juego.nivel().todosLosEnemigos().any{ enemigo => enemigo.disparo() == self }

	override method desaparecer() {
		if (self.estoyCargado()) {
			var shooter = self.buscandoShooter()
			sonidoDisparo.stop()
			shooter.disparo(0)
				// tomamos '0' como pistola descargada 
			game.removeVisual(self)
		}
	}

	override method fueraDeEscena() = self.position().x() <= margenIzquierdo

	override method impactar() {
		self.desaparecer()
	}

}

class DisparoEnemigo2 inherits DisparoEnemigo{

	override method moverDisparo() {
		if (game.hasVisual(self)) {
			if (!self.fueraDeEscena()) {
				self.position(self.position().down(1))
			} else {
				self.desaparecer()
			}
		}
	}



	override method fueraDeEscena() = self.position().y() <= limiteInferior
	
	
	
}
