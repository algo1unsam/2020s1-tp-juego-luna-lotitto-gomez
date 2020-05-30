import juego.*
import pantallaInicial.*
import wollok.game.*
import Enemigos.*
import cornelio.*
import palanca.*
import items.*
import comandos.*
import arbitro.*
import frutilla.*

class Nivel
{	var property itemsDinamicos = []
	var property itemsEstaticos = []
	var property enemigos1 = []
	var property enemigos2 = []
	var property enemigos3 = []
	var property position = game.at(0,0)
	var property siguienteNivel = 0
	var property theme = ""
	method image() = ""
	method cargarItems(){
	
		
		if (!itemsDinamicos.isEmpty()) itemsDinamicos.forEach{item => game.addVisual(item)}
		if (!itemsEstaticos.isEmpty()) itemsEstaticos.forEach{item => game.addVisual(item)}
	}
	method todosLosEnemigos() =  enemigos1 + enemigos2 + enemigos3
	
	method cargarEnemigos()
	{
		self.todosLosEnemigos().forEach{enemigo => game.addVisual(enemigo)
			
		}
	}
	method cargarSonido(){
		
		theme.play()
		theme.volume(0.5)
		theme.shouldLoop(true)
	}		
	method cargar(){
		game.addVisual(self)
		self.cargarSonido()
		self.cargarItems()
		game.addVisual(cornelio)
		game.showAttributes(cornelio)
		game.addVisual(frutilla)
		self.cargarEnemigos()
		//TODO: agregar power ups?, palanca?, items de ayuda?
		self.cargarCondiciones()
		comandos.cargar()
	}
	method cargarCondiciones()
	{
		
	}

	method validarFinal(){ 
	
	}
	method finalizar (){
		theme.stop()
		game.clear()
		juego.cambiarNivel(siguienteNivel)
		juego.cargar()
		
		
	}
	method perder(){
		if (cornelio.vitalidad() == 0){
			game.clear()
			// poner sonido de game over
			gameOver.cargar()
			
		}
	}
	
	method restart(){
		cornelio.disparo(0)
		cornelio.vitalidad(20)
		cornelio.position(new Position(x=0,y=3))
		enemigos1.clear()
		enemigos2.clear()
		enemigos3.clear()
		palanca.alta(true)
	}
}

object nivelUno inherits Nivel(theme = game.sound("CorneliusGameNivel1Theme.mp3"),siguienteNivel = nivelDos,itemsEstaticos = [palanca], itemsDinamicos = [cafiaspirina])
{	
	

	override method image () = "nivel1-fondo.png"
	
	override method validarFinal (){
	
			if (self.todosLosEnemigos().isEmpty() and palanca.estasActivada()) self.finalizar()
	
	}
	
	override method cargarEnemigos()
	{
		3.times{i => enemigos1.add(new Enemigo(position = game.at(10 + i,0)))}
		3.times{i => enemigos2.add(new Enemigo(position = game.at(10+ i,4)))}
		3.times{i => enemigos3.add(new Enemigo(position = game.at(10+ i,7)))}
		
				
		
		super()	
	}
	override method cargarCondiciones()
	{
		self.todosLosEnemigos().forEach{ enemigo=>
			
			game.onTick(500,"caminar",{enemigo.caminar()})
			game.onTick(1000, "disparar",{enemigo.disparar()})
			game.onTick(200, "moverDisparo",{enemigo.moverDisparo()})
				
		}
		
		game.onTick(300,"mover disparo cornelio",{cornelio.moverDisparo()})
		game.onCollideDo(palanca,{objeto => palanca.bajar()})
		game.onCollideDo(cornelio,{objeto => cornelio.colisionaCon(objeto)})
		itemsDinamicos.forEach{item => game.onTick(item.tiempo(),"mover", {item.moverse()})
			game.onCollideDo(item, {objeto => objeto.subirVitalidad(item)})
		}
		game.onTick(0,"validar impactos",{arbitro.validarImpactos()})
		game.onTick(0,"finalizar juego", {self.validarFinal()})
		game.onTick(0,"morir",{ self.perder()})	
	}
	

	
}
object nivelDos inherits Nivel(theme =game.sound("CorneliusGameNivel1Theme.mp3")) {

	override method image() = "nivel2-fondo.jpeg"
	
}