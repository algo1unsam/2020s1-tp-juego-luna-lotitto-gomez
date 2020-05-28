import wollok.game.*
import cornelio.*
import disparo.*
import Enemigos.*
import Nivel.*
import juego.*
object arbitro {
//
	method validarImpactos(){
					
			if(cornelio.disparo() != 0){
			
			try{	
				const d = cornelio.disparo()
				const enem = game.uniqueCollider(d)
				
				if(juego.nivel().todosLosEnemigos().any{enemigo =>  enem == enemigo} ){
					
					game.removeVisual(enem)
					game.removeVisual(d)
					// TODO: arreglar esto ameo
					juego.nivel().enemigos1().remove(enem)
					juego.nivel().enemigos2().remove(enem)
					juego.nivel().enemigos3().remove(enem)
					cornelio.disparo(0)
				}}catch e{}
			}
	}	
	
}
