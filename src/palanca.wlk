import wollok.game.*
import items.*
import juego.*
object palanca inherits ItemEstatico(image = "popcorn.png", position =new Position(x=13,  y=8))
{	
	var activada = false
	method estasActivada (){
		return activada
	}
	method bajar(){
		game.say(self, "Apretar F para activar la palanca")
		
	keyboard.f().onPressDo{self.image("grano.png")
		activada = true
	}
	}
	
}
