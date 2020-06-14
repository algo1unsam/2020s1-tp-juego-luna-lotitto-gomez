import wollok.game.*
import Nivel.*
import juego.*
import Enemigos.*
import disparo.*
import comandos.*
import items.*

class Frutilla inherits Enemigo2{
	
	override method devolverDisparo() = new DisparoEnemigo2(direccion = abajo,sonidoDisparo = game.sound("disparoCornelio.mp3"),image = 'disparoEnemigo.png', position = self.position())
	
	override method colisionarCon(objeto) {
		
	}
    override method recibirDanio(disparo) {
		
	}

	method recibirDisparoEspecial(disparo){
		disparo.desaparecer()
		self.desaparecer()
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

class Boss inherits Enemigo2{
	//TODO: cambiar disparo
	var property vitalidad = 10
	
	override method devolverDisparo() = new DisparoEnemigo3(direccion = abajo,sonidoDisparo = game.sound("disparoCornelio.mp3"),image = 'disparoEnemigo.png', position = self.position())
	
	method estaMuerto() = vitalidad == 0 
	
	method bajarVitalidad(){
		vitalidad = 0.max(vitalidad - 10)
	
	}
	override method recibirDanio(disparo) {
		self.bajarVitalidad()
		disparo.desaparecer()
		game.say(self, vitalidad.toString())
	}
		
}
