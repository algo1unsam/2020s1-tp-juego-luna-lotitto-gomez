import wollok.game.*
import Nivel.*
import juego.*
import Enemigos.*
import disparo.*
import comandos.*
import items.*

class Frutilla inherits Enemigo{
	
	override method devolverDisparo() = new DisparoEnemigo(velocidad = 300,direccion = abajo,sonidoDisparo = game.sound("disparoCornelio.mp3"),image = "disparofrutilla.png", position = self.position())
	
	override method colisionarCon(objeto) {
		
	}
    override method recibirDanio(disparo) {
		
	}
	override method disparar() {
		if (!hayDisparo and game.hasVisual(self)) {
			(self.devolverDisparo()).aparecer()
		}
	}

	method recibirDisparoEspecial(disparo){
		disparo.desaparecer()
		//self.desaparecer()
		self.image("frutillacurada.png")
		game.removeTickEvent("caminar")
		game.removeTickEvent("disparar")
		game.say(self, "GRACIAS POR SALVARME! <3")
		game.onTick(2000,"desaparecer", {self.desaparecer()})
	}
	method mutar(){
		if(self.estoySola()){
			juego.nivel().theme().stop()
			game.addVisual(antidoto)
			game.removeTickEvent("frutilla sola")
		}
	}	
	method estoySola() = juego.nivel().todosLosEnemigos().size() == 1
}

class Boss inherits Enemigo{

	var property _vitalidad = 200
	
		
	method estaMuerto() = _vitalidad == 0 
	
	method bajarVitalidad(){
		_vitalidad = 0.max(_vitalidad - 10)
	
	}
	
	override method recibirDanio(disparo) {
		self.bajarVitalidad()
		disparo.desaparecer()
		game.say(self, _vitalidad.toString())
	}
	
		
}
