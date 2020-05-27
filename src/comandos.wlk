import wollok.game.*
import cornelio.*

object comandos {
	method cargar(){
		//Cornelio DISPARA
		keyboard.s().onPressDo{cornelio.disparar()}
		//cornelio se MUEVE
		keyboard.up().onPressDo{arriba.mover(cornelio)}
		keyboard.down().onPressDo{abajo.mover(cornelio)}
		keyboard.left().onPressDo{
			cornelio.image(izquierda.imagen())
			izquierda.mover(cornelio)
		}
		keyboard.right().onPressDo{
			cornelio.image(derecha.imagen())
			derecha.mover(cornelio)
		}	
	}
			
	
}

object izquierda {

	var property imagen = "cornelioL.png"
	method mover(objeto){
		objeto.moverse(objeto.position().left(1))
	}		
}

object derecha {

	var property imagen = "cornelioR.png"
	method mover(objeto){
		objeto.moverse(objeto.position().right(1))
	}		
}

object arriba {

	var property imagen = "cornelioR.png"
	method mover(objeto){
		objeto.moverse(objeto.position().up(1))
	}		
}
object abajo {

	var property imagen = "cornelioR.png"
	method mover(objeto){
		objeto.moverse(objeto.position().down(1))
	}		
}