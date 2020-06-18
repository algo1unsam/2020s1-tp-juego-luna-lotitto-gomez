import wollok.game.*
import Nivel.*
import pantallaInicial.*

// Main principal
object juego {

	var property nivel = pantallaInicial
	const property limites = [0,10]
	const property margenes = [0,15]
	
	method cargar() {
		nivel.cargar()
	}

	method cambiarNivel(_nuevoNivel) {
		nivel = _nuevoNivel
	}
	method restart (){
		nivel.restart()
		self.cargar()
	}
	method puedeMoverse(orientacion){
		return !margenes.contains(orientacion.x()) and !limites.contains(orientacion.y())
	}

}

