import disparo.*
import wollok.game.*
import juego.*
import items.*
object cornelio {

	var property position = new Position(x = 0, y = 3)
	var property vitalidad = 3000000
	var property hayDisparo = false 
	var property image = "cornelioNormal1.png"
	
	method estaMuerto()  = vitalidad == 0
	method disparar() {
		if (!hayDisparo) {
				
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
	
//	method actualizarImagen(){
//		if(vitalidad > 70){
//			self.image("")
//		}else(vitalidad.between(10, 70)){
//			self.image("")
//		}else{self.image("")}
//	}

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

