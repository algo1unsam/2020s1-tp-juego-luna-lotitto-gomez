import disparo.*
import wollok.game.*
import juego.*

object cornelio {

	var property position = new Position(x = 0, y = 3)
	var property vitalidad = 100000
	var property hayDisparo = false 
	var property image = "cornelioL.png"
	

	method disparar() {
		if (!hayDisparo) {
				
				(juego.nivel().devolverDisparo()).aparecer()
		}
	}

	// recibir disparo
	method colisionaCon(objeto) {
		
	}
	method recibirDanio(disparo){
		self.perderVitalidad()
		disparo.desaparecer()
	}

	method perderVitalidad() {
		vitalidad = 0.max(vitalidad - 10)
	}

	method subirVitalidad(objeto) {
		vitalidad += 100
		objeto.desaparecer()
	}



	method moverse(orientacion) {
		if (juego.puedeMoverse(orientacion)) self.position(orientacion)
	}

}

// composicion de estados de cornelio 

object normal {

	method image() = ""

}

object poderoso {

	method image() = ""

}

object enfermo {

	method image() = ""

}

