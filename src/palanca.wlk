import wollok.game.*
import items.*
import juego.*
object palanca inherits ItemEstatico(image = "Palanca.png", position =new Position(x=14,  y=8))
{	
	var property alta = true
	
	override method image(){
		return if(alta) {"Palanca.png"} else{"PalancaBaja.png"}
	}
	method estasActivada (){
		return !alta
	}
	method bajar(){
		game.say(self, "Apretar F para activar la palanca")
		
	keyboard.f().onPressDo{
		alta = false
	}
	}
	
}
