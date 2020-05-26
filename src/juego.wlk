import wollok.game.*
import Nivel.*
import pantallaInicial.*

object juego
{
	var property nivel = pantallaInicial 
	
	method cargar(){
		nivel.cargar()
	}
	method cambiarNivel(_nuevoNivel){
		nivel = _nuevoNivel
	}	 
}