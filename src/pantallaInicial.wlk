import juego.*
import Nivel.*
import wollok.game.*
import  cornelio.*
class Pantalla {
	var property position = new Position(x=0,y=0)
	method image() = "Untitled.png"

	method cargar() {
		
		game.addVisual(self)		
		
		keyboard.enter().onPressDo{ 
			
			
			juego.cargar()
		
		}
	}


	
}
object pantallaInicial  inherits Pantalla{
	override method image () = "Untitled.png"
	override method cargar () {
		
		game.boardGround(self.image())
		
		keyboard.enter().onPressDo{ 
			
			juego.cambiarNivel(nivelUno)	
			juego.cargar()
		
	}
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

