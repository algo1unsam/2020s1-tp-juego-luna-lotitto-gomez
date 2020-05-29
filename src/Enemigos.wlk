import disparo.*
import wollok.game.*
import Nivel.*
import juego.*
import comandos.*

class Enemigo
{
	var property vitalidad = 0
	var property disparo = 0
	var property image = "obrerosyroundup.png"
	var property position 
	var property direccion = izquierda
	
	method caminar(){
		direccion.mover(self)
	}
	method moverse(orientacion){
		if(self.puedeMoverse(orientacion)){
			self.position(orientacion)
		}else{self.cambiarOrientacion()}
	}
	method puedeMoverse(orientacion){
		
		return juego.margenes().all{margen => orientacion.x() != margen}	
	}
	method cambiarOrientacion(){
		if(direccion == izquierda) direccion = derecha else direccion = izquierda
	
	}
	method disparar()
	{
		if (disparo == 0){
			disparo = new DisparoEnemigo(sonidoDisparo = game.sound("disparoCornelio.mp3"),position = self.position())
			disparo.aparecer()

			disparo.moverDisparo()
		}
	}

	
	method tieneDisparo(){
		return disparo != 0
	}
	
	method moverDisparo()
	{
		if(disparo != 0)
		{
			disparo.moverDisparo()
		}
	}
	//trucho
	method subirVitalidad(param){}
	
}
