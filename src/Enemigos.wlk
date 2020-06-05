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

	// Lo entiende pero no hace nada 
	method perderVitalidad(objeto) {
	}

	method recibirDanio(disparo) {
		disparo.desaparecer()
		self.desaparecer()
		
	}

	method desaparecer() {
	
	
		juego.nivel().enemigos1().remove(self)
		juego.nivel().enemigos2().remove(self)
		juego.nivel().enemigos3().remove(self)
		const die = game.sound("explosion.wav")
		die.play()
		game.removeVisual(self)
	}
		
	method colisionarCon(objeto) {
		// esto esta mal supongo
		//if (objeto == cornelio.disparo()) {
			//self.desaparecer()
			//objeto.desaparecer()
		//}
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
	
	method devolverDisparo() = new DisparoEnemigo(direccion = izquierda,sonidoDisparo = game.sound("disparoCornelio.mp3"), position = game.at(self.position().x() + 5,self.position().y()))	
	
	method disparar() {
		
		if (!hayDisparo and game.hasVisual(self)) {
			
			(self.devolverDisparo()).aparecer()
			
		}
	}

	
	
	method subirVitalidad(objeto) {
	}

}
class Enemigo2 inherits Enemigo {
	
	override method devolverDisparo() =  new DisparoEnemigo2(direccion = abajo,sonidoDisparo = game.sound("disparoCornelio.mp3"), position = self.position())
	
//	override method puedeMoverse(orientacion) {
	//	return orientacion.x().between(2,12) 
	//}

			
}
