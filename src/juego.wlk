import wollok.game.*
import Nivel.*
import pantallaInicial.*

// Main principal
object juego {

	var property nivel = pantallaInicial
	// cheuqear margenes y limites, necesario?
	const property margenes = [ -1, 15 ]
	const property limites = [ -1, 9 ]

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

}

