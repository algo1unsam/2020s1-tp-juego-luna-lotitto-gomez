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
		game.onTick(300, "mover disparo" + self.identity().toString(), { self.moverDisparo()})
		
			
		//game.onCollideDo(self, {objeto => self.colisionarCon(objeto)})
	
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
	
	//override method aparecer(){
		//super()
		//game.onCollideDo(self, {objeto => self.colisionarCon(objeto)})
	//}

	override method sonidoDisparo()  {sonidoDisparo = "disparoCornelio.mp3"}
	
		

	override method desaparecer() {
		cornelio.hayDisparo(false)
		super()
	}

	method impactar(objeto) {
		juego.nivel().enemigos1().remove(objeto)
		juego.nivel().enemigos2().remove(objeto)
		juego.nivel().enemigos3().remove(objeto)
		game.removeVisual(objeto)
	}


}  

class DisparoCornelio2 inherits DisparoCornelio{
	  override method direccion () = arriba
		override method colisionarCon(objeto){}
}

class DisparoEnemigo inherits Disparo{

	override method image() = "disparoEnemigo.png"
	
	
	override method colisionarCon(objeto) {
		cornelio.recibirDanio(disparo)
		
	}

	override method sonidoDisparo() {
		sonidoDisparo = "cornelioDisparo.mp3"
	}

	override method impactar() {
		self.desaparecer()
	}
	override method aparecer(){
			super()
			game.onCollideDo(self, {objeto => self.colisionarCon(objeto)})
		
	}

}

class DisparoEnemigo2 inherits DisparoEnemigo{
	override method colisionarCon(objeto){}
}
