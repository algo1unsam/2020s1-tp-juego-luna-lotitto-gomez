import cornelio.*
import Enemigos.*
import wollok.game.*
import Nivel.*
import juego.*
 
class Disparo
{
	var property image = "popcorn.png"
	var property position
	var property margenIzquierdo = 1
	var property margenDerecho = 14
		//TODO: trucho
		method subirVitalidad(){
			
		}
		method aparecer()
		{
			game.addVisual(self)
				
		}
		method moverDisparo()

		//TODO: revisar si es necesario especificar el objeto
		method impactar()
		method fueraDeEscena()
		method desaparecer()
}

class DisparoCornelio inherits Disparo
{
	override method moverDisparo(){
		if(!self.fueraDeEscena() )
		{
			self.position(self.position().right(1))	
		}else{self.desaparecer()}	
		
	}
	override method desaparecer(){
		cornelio.disparo(0)
		game.removeVisual(self)
	}
	
	override method fueraDeEscena() =  self.position().x() >= margenDerecho
		
	 method impactar(objeto) {
		
		juego.nivel().enemigos1().remove(objeto)
		juego.nivel().enemigos2().remove(objeto)
		juego.nivel().enemigos3().remove(objeto)
		game.removeVisual(objeto)
	}
	override method impactar(){}
		
}

class DisparoEnemigo inherits Disparo
{
	override method moverDisparo()
	{	
		// TODO: agregar validaciones
		if(!self.fueraDeEscena())
		{
			self.position(self.position().left(1))	
		}else{self.desaparecer()}	
			
	}
		override method desaparecer()
		{	

			var shooter =juego.nivel().todosLosEnemigos().find{enemigo => enemigo.disparo() == self}
			shooter.disparo(0)
			// tomamos '0' como pistola descargada 
			game.removeVisual(self)
			
		}
		override	method fueraDeEscena() =  self.position().x() <= margenIzquierdo
		override method impactar(){}	
}
