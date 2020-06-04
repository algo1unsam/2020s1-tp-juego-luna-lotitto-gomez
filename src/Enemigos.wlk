import disparo.*
import wollok.game.*
import Nivel.*
import juego.*
import comandos.*
import cornelio.*
import frutilla.*

class Enemigo {

	var property vitalidad = 0
	var property disparo = 0
	var property image = "obrerosyroundup.png"
	var property position
	var property direccion = izquierda

	// Lo entiende pero no hace nada 
	method perderVitalidad(objeto) {
	}

	method recibirDanio() {
		self.desaparecer()
	}

	method desaparecer() {
	
		if (self.disparo() != 0) {
			game.removeVisual(self.disparo())
		}
		juego.nivel().enemigos1().remove(self)
		juego.nivel().enemigos2().remove(self)
		juego.nivel().enemigos3().remove(self)
		const die = game.sound("explosion.wav")
		die.play()
		game.removeVisual(self)
	}

	method colisionarCon(objeto) {
		// esto esta mal supongo
		if (objeto == cornelio.disparo()) {
			self.desaparecer()
			objeto.desaparecer()
		}
	}

	method caminar() {
		direccion.mover(self)
	}

	method moverse(orientacion) {
		if (self.puedeMoverse(orientacion)) {
			self.position(orientacion)
		} else {
			self.cambiarOrientacion()
		}
	}

	method puedeMoverse(orientacion) {
		return juego.margenes().all{ margen => orientacion.x() != margen }
	}

	method cambiarOrientacion() {
		// TODO: Esto se lo podemos pedir a la dirección actual? direccion = direccion.opuesto() 
		if (direccion == izquierda) direccion = derecha else direccion = izquierda
	}
	
	method devolverDisparo() = new DisparoEnemigo(sonidoDisparo = game.sound("disparoCornelio.mp3"), position = self.position())	
	
	method disparar() {
		
		if (disparo == 0 and game.hasVisual(self) ) {
			disparo = self.devolverDisparo()
			disparo.aparecer()
			disparo.moverDisparo()
		}
	}

	
	method tenesDisparo() = disparo != 0
	
	method moverDisparo() {

			if (game.hasVisual(disparo) and self.tenesDisparo())  disparo.moverDisparo()
				
		
	}

	// trucho
	method subirVitalidad(objeto) {
	}

}
class Enemigo2 inherits Enemigo {
	
	override method devolverDisparo() =  new DisparoEnemigo2(sonidoDisparo = game.sound("disparoCornelio.mp3"), position = self.position())
	
	override method puedeMoverse(orientacion) {
		return orientacion.x().between(2,12) 
	}

			
}
