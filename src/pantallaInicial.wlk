import juego.*
import Nivel.*
import wollok.game.*
import  cornelio.*
class Pantalla {
	var property position = new Position(x=0,y=0)
	var property image = "Untitled.png"

	method cargar() {
		
		game.addVisual(self)		
		
		keyboard.enter().onPressDo{ 
			
			
			juego.cargar()
		
		}
	}


	
}
object pantallaInicial  inherits Pantalla{
	override method image () = "pantallaInicial.png"
	override method cargar () {
		
		game.addVisual(self)		
		game.addVisual(pressStart)
		game.onTick(200,"cambiarImagen",{pressStart.cambiarImagen()})
		keyboard.enter().onPressDo{ 
			// consultar si hace falta borrar imagenes
			juego.cambiarNivel(nivelUno)	
			game.removeVisual(pressStart)
			game.removeVisual(self)
			game.clear()
			juego.cargar()
		
	}
}
}
object pressStart inherits Pantalla(image = "pressStart.png",position = game.at(9,6)){
	method cambiarImagen(){
		return if(image == "pressStart.png"){image ="pressStart2.png"}else{image ="pressStart.png"}
	}	
}

object gameOver inherits Pantalla{
	override method image ()= "nivel2-fondo.jpeg"
	override method cargar() {
				game.addVisual(self)		
		
		keyboard.enter().onPressDo{ 
			
			game.removeVisual(self)
					juego.restart()
					}
		
	}
}

