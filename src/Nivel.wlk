import juego.*
import pantallaInicial.*
import wollok.game.*
import Enemigos.*
import cornelio.*
import palanca.*
import items.*

class Nivel
{	var property itemsDinamicos = []
	var property itemsEstaticos = []
	var enemigos1 = []
	var enemigos2 = []
	var enemigos3 = []
	var property position = game.at(0,0)
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
	method cargar(){
		game.addVisual(self)
		self.cargarItems()
		game.addVisualCharacter(cornelio)
		game.showAttributes(cornelio)
		self.cargarEnemigos()
		//TODO: agregar power ups?, palanca?, items de ayuda?
		self.cargarCondiciones()
	}
	method cargarCondiciones()
	{
		
	}
}

object nivelUno inherits Nivel(itemsEstaticos = [palanca], itemsDinamicos = [cafiaspirina])
{	
	
	
	override method image () = "nivel1-fondo.png"

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
		
			game.onTick(2000,"caminar",{enemigo.caminar()})
			game.onTick(1000, "disparar",{enemigo.disparar()})
			game.onTick(300, "moverDisparo",{enemigo.moverDisparo()})
				
		}
		
		game.onCollideDo(palanca,{objeto => palanca.bajar()})
		game.onCollideDo(cornelio,{objeto => cornelio.colisionaCon(objeto)})
		itemsDinamicos.forEach{item => game.onTick(item.tiempo(),"mover", {item.moverse()})
			game.onCollideDo(item, {objeto => objeto.subirVitalidad(item)})
		}
		
	}

	
}