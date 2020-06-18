import wollok.game.*
class Item {
	var property position
	var property image 
	method recibirDanio(disparo){
		
	}
	method recibirDisparo(disparo){
		
	}
	
	method subirVitalidad(objeto){
		
	}
	method colisionarCon(objeto){
			
	}
	method desaparecer(){
		game.removeVisual(self)
	}
}

class ItemDinamico inherits Item{
	var property tiempo
	
	override method colisionarCon(objeto){
		objeto.subirVitalidad(self)
				
	}	
	method moverse()
	{
		self.position(new Position (x = 1.randomUpTo(14),y = 1.randomUpTo(8)))
	}	

}

class ItemEstatico inherits Item{
	
	override method colisionarCon(objeto){
		objeto.perderVitalidad()	
	}

} 

const antidoto = new Item(position = new Position(x =3,y =4 ),image = "antidoto.png")
const cafiaspirina = new ItemDinamico(tiempo = 3000,position = new Position(x =0,y =4 ),image = "bayer.png")
