import wollok.game.*
import items.*
import juego.*
object palanca inherits ItemEstatico(image = "Palanca.png", position =new Position(x=14,  y=8))
{	
	var activada = false
	method estasActivada (){
		return activada
	}
	method bajar(){
		game.say(self, "Apretar F para activar la palanca")
		
	keyboard.f().onPressDo{self.image("PalancaBaja.png")
		activada = true
	}
	}
	
}
