import juego.*
import Nivel.*
import wollok.game.*

object pantallaInicial {

	method image() = "Untitled.png"

	method cargar() {
		
		game.boardGround(self.image())
		
		keyboard.enter().onPressDo{ 
			juego.cambiarNivel(nivelUno)
			juego.cargar()
		}
	}

}

