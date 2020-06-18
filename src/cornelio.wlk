import disparo.*
import wollok.game.*
import juego.*
import items.*

object cornelio {

	var property position = new Position(x = 0, y = 3)
	var property vitalidad = 30000
	var property hayDisparo = false 
	var property estado  = normal
	var property image = "cornelionormal1.png"
	
	
	method estaMuerto()  = vitalidad == 0
	
	method disparar() {
		if (!hayDisparo) {
				hayDisparo = true
				
				(juego.nivel().devolverDisparo()).aparecer()
		}
	}

	// recibir disparo
	method colisionaCon(objeto) {
		if(self.position() == antidoto.position()) {
			game.removeVisual(antidoto)
		}
	}
	method recibirDanio(disparo){

	}
	method recibirDisparoEspecial(disparo){

	}
	method recibirDisparo(disparo){
		self.perderVitalidad()
		disparo.desaparecer()
	}

	method perderVitalidad() {
		game.say(self, {"OUCH!"})
		vitalidad = 0.max(vitalidad - 10)
	}

	method subirVitalidad(objeto) {
		vitalidad += 100
		objeto.desaparecer()
	}



	method moverse(orientacion) {
		if (juego.puedeMoverse(orientacion)) self.position(orientacion)
	}
	method restart(){
		self.hayDisparo(false)
		self.vitalidad(100)
		self.position(new Position(x = 0, y = 3))
	}
	
	method actualizarImagen(){
		if(vitalidad >= 70){
			self.image("corneliopower.png")
		}else if(vitalidad.between(30, 70)){
			self.image(normal.image())
		}else{ self.image(enfermo.image())}
	}

}

// composicion de estados de cornelio 

object normal {

	method image() = "cornelionormal1.png"

}

object poderoso {

	method image() = "corneliopower.png"

}

object enfermo {

	method image() = "cornelioenfermo.png"

}

