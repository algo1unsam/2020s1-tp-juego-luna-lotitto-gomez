import disparo.*
import wollok.game.*
import juego.*

object cornelio {

	var property position = new Position(x = 0, y = 3)
	var property vitalidad = 100000
	var property disparo = 0 
	var property image = "cornelioL.png"
	

	method disparar() {
		if (disparo == 0) {
			disparo = juego.nivel().devolverDisparo()
			disparo.aparecer()
		}
	}

	// recibir disparo
	method colisionaCon(objeto) {
		var shot = (juego.nivel()).todosLosEnemigos().map{ enemigo => enemigo.disparo() }
		if (shot.any{ bala => bala == objeto }) {
			self.perderVitalidad()
			objeto.impactar()
		}
	}

	method perderVitalidad() {
		vitalidad = 0.max(vitalidad - 10)
	}

	method subirVitalidad(objeto) {
		vitalidad += 100
		objeto.desaparecer()
	}

	method moverDisparo() {
		if (disparo != 0) {
			disparo.moverDisparo()
		}
	}

	method puedeMoverse(unaOrientacion) {
		return juego.margenes().all{ margen => unaOrientacion.x() != margen } and juego.limites().all{ limite => unaOrientacion.y() != limite }
	}

	method moverse(orientacion) {
		if (self.puedeMoverse(orientacion)) {
			self.position(orientacion)
		}
	}

	method colisionarCon(objeto) {
		objeto.colisionarCon(self)
	}

	method recibirDanio() {
	
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

