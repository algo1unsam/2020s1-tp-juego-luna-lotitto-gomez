import wollok.game.*
import Nivel.*
import juego.*
import Enemigos.*
import disparo.*

class Frutilla inherits Enemigo2{
	
	override method devolverDisparo() = new DisparoEnemigo2(sonidoDisparo = game.sound("disparoCornelio.mp3"), position = self.position())
	
	override method colisionarCon(objeto) {
		
	}
	
	
}
