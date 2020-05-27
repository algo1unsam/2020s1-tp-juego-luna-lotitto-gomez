import wollok.game.*
import Nivel.*
import pantallaInicial.*

object juego
{
	var property nivel = pantallaInicial 
	const property margenes = [-1,15]
	const property limites = [-1,9]
	method cargar(){
		nivel.cargar()
	}
	method cambiarNivel(_nuevoNivel){
		nivel = _nuevoNivel
	}	 
}