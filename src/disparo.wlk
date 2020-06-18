import cornelio.*
import Enemigos.*
import wollok.game.*
import Nivel.*
import juego.*
import frutilla.*
import comandos.*

class Disparo {

	var property image 
	var property position
	var property sonidoDisparo
	var property direccion
	var property velocidad
	
	method perderVitalidad(){}
	method recibirDisparo(disparo){
		
	}
	method recibirDanio(disparo){
		
	}
	method subirVitalidad(objeto) {
	}

	method recibirDanio() {
	}

	method aparecer() {
		game.sound(sonidoDisparo)
		sonidoDisparo.volume(0.1)
		sonidoDisparo.play()
		game.addVisual(self)
		game.onTick(velocidad, "mover disparo" + self.identity().toString(), { self.moverDisparo()})
		
			
		game.onCollideDo(self, {objeto => self.colisionarCon(objeto)})
	
	}
	
	method moverse(orientacion) {
		if (juego.puedeMoverse(orientacion) and game.hasVisual(self)) self.position(orientacion) else self.desaparecer()}

	
	method moverDisparo() = direccion.mover(self)	

	method impactar(){}

	method desaparecer(){
		sonidoDisparo.stop()
		game.removeVisual(self)
		game.removeTickEvent("mover disparo" + self.identity().toString())
		
	
	}
	method colisionarCon(objeto)
	
}

class DisparoCornelio inherits Disparo{
	
	override method colisionarCon(objeto) {
			
			objeto.recibirDanio(self)
			
		
	}
	
	override method sonidoDisparo()  {sonidoDisparo = "disparoCornelio.mp3"}
	
		

	override method desaparecer() {
		cornelio.hayDisparo(false)
		super()
	}

	method impactar(objeto) {
		juego.nivel().todosLosEnemigos().remove(objeto)
		game.removeVisual(objeto)
	}


}  

class DisparoEspecial inherits DisparoCornelio{
	
	override method colisionarCon(objeto) {
			
			objeto.recibirDisparoEspecial(self)
			
		
	}	
}

class DisparoEnemigo inherits Disparo{
	
	override method colisionarCon(objeto) {
		objeto.recibirDisparo(self)
		
	}

	override method sonidoDisparo() {
		sonidoDisparo = "cornelioDisparo.mp3"
	}

	override method impactar() {
		self.desaparecer()
	}


}

