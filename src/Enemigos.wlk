import disparo.*
import wollok.game.*
import Nivel.*
import juego.*

class Enemigo
{
	var property vitalidad = 0
	var property disparo = 0
	var property image = "obrerosyroundup.png"
	var property position 
	method disparar()
	{
		if (disparo == 0){
			disparo = new DisparoEnemigo(position = self.position())
			disparo.aparecer()
			disparo.moverDisparo()
		}
	}
	
	method caminar()
	{	
		//TODO: arreglar las validaciones
		self.position(self.position().left(1))	
	}
	
	method moverDisparo()
	{
		if(disparo != 0)
		{
			disparo.moverDisparo()
		}
	}
	
}
