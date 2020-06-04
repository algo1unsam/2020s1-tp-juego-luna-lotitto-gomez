import wollok.game.*
class Item {
	var property position
	var property image 
	
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
		
}


const cafiaspirina = new ItemDinamico(tiempo = 3000,position = new Position(x =0,y =4 ),image = "bayer.png")