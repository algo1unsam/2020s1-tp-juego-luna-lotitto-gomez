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
	
	 
	
	method  cargarColisionesNivelUno(){
		
		//ENEMIGOS
		nivelUno.todosLosEnemigos().forEach{enemigo=>game.onCollideDo(enemigo,{objeto => enemigo.colisionarCon(objeto)})}
		
		//CORNELIO
		game.onCollideDo(cornelio,{objeto => cornelio.colisionarCon(objeto)})
	
		// items Dinamicos
		nivelUno.itemsDinamicos().forEach{item => game.onTick(item.tiempo(),"mover", {item.moverse()})
			game.onCollideDo(item, {objeto => objeto.subirVitalidad(item)})
		}
		// item estatico, palanca
		game.onCollideDo(palanca,{objeto => palanca.bajar()})
		
		
	}
	
		 
	
	method  cargarColisionesNivelDos(){
		
		//ENEMIGOS
		nivelDos.todosLosEnemigos().forEach{enemigo=>game.onCollideDo(enemigo,{objeto => enemigo.colisionarCon(objeto)})}
		
		//CORNELIO
		game.onCollideDo(cornelio,{objeto => cornelio.colisionarCon(objeto)})
	
		// items Dinamicos
		nivelDos.itemsDinamicos().forEach{item => game.onTick(item.tiempo(),"mover", {item.moverse()})
			game.onCollideDo(item, {objeto => objeto.subirVitalidad(item)})
		}
		
		
		
	}

}

