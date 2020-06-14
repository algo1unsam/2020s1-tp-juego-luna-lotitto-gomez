import wollok.game.*
import cornelio.*
import Enemigos.*
import Nivel.*
import juego.*
import disparo.*
import  items.*
import palanca.*
import frutilla.*
 
object arbitro {
	
	//COLISIONES
	
	method validarDisparo(disparo){
		
		game.onCollideDo(disparo, {objeto => disparo.colisionarCon(objeto)})
	}
	
	method  cargarColisionesNivelUno(){
		
		//ENEMIGOS

		//CORNELIO
	
		// items Dinamicos
		nivelUno.itemsDinamicos().forEach{item => game.onTick(item.tiempo(),"mover", {item.moverse()})
			game.onCollideDo(item, {objeto => objeto.subirVitalidad(item)})
		}
		// item estatico, palanca
		game.onCollideDo(palanca,{objeto => palanca.bajar()})
		
		
	}
	
		 
	
	method  cargarColisionesNivelDos(){
		
				
		//CORNELIO
		game.onCollideDo(cornelio,{objeto => cornelio.colisionaCon(objeto)})
	
		// items Dinamicos
		nivelDos.itemsDinamicos().forEach{item => game.onTick(item.tiempo(),"mover", {item.moverse()})
			game.onCollideDo(item, {objeto => objeto.subirVitalidad(item)})
		}
		
		
		
	}

}

