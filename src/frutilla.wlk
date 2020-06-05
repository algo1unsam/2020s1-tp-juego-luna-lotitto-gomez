import wollok.game.*
import Nivel.*
import juego.*
import Enemigos.*
import disparo.*
import comandos.*

class Frutilla inherits Enemigo2{
	
	override method devolverDisparo() = new DisparoEnemigo2(direccion = abajo,sonidoDisparo = game.sound("disparoCornelio.mp3"), position = self.position())
	
	override method colisionarCon(objeto) {
		
	}
	
	
}
