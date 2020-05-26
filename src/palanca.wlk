import wollok.game.*
import items.*
import juego.*
object palanca inherits ItemEstatico(image = "popcorn.png", position =new Position(x=14, y=9))
{
	method bajar(){
		game.say(self, "Apretar F para activar la palanca")
		
	keyboard.f().onPressDo{self.image("grano.png")}
	}
	
}
