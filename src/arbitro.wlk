import wollok.game.*
import cornelio.*
import Enemigos.*
import Nivel.*
import juego.*
import disparo.*
object arbitro {
//
	method validarImpactos(){
					
			if(cornelio.disparo() != 0){
			
			try{	
				const d = cornelio.disparo()
				const enem = game.uniqueCollider(d)
				// TODO: arreglar
				if(juego.nivel().todosLosEnemigos().any{enemigo =>  enem == enemigo} ){
					
					if (enem.tieneDisparo()){ game.removeVisual(enem.disparo())}
					
					game.removeVisual(enem)
					game.removeVisual(d)
					
					const son =game.sound("explosion.wav")
					son.play()
					// TODO: arreglar esto ameo
					juego.nivel().enemigos1().remove(enem)
					juego.nivel().enemigos2().remove(enem)
					juego.nivel().enemigos3().remove(enem)
					cornelio.disparo(0)
				}}catch e{}
			}
	}	
	//TODO: validar tocar items
	
	//cargar condiciones por nivel
	

	
}
