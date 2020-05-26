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
		method aparecer()
		{
			game.addVisual(self)
				
		}
		method moverDisparo()
		{
			
		}
		//TODO: revisar si es necesario especificar el objeto
		method impactar()
		{	
			
		}
		
}

class DisparoCornelio inherits Disparo
{
	
}

class DisparoEnemigo inherits Disparo
{
	override method moverDisparo()
	{	
		// TODO: agregar validaciones
		if(!self.fueraDeEscena())
		{
			self.position(self.position().left(1))	
		}else{self.impactar()}	
			
	}
		method impactar()
		{	

			var shooter =juego.nivel().todosLosEnemigos().find{enemigo => enemigo.disparo() == self}
			shooter.disparo(0)
			// tomamos '0' como pistola descargada 
			game.removeVisual(self)
			
		}
		method fueraDeEscena()
		{
			return if(self.position().x() <= margenIzquierdo){true}
			else{false}
		}
	
}
