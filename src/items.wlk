import wollok.game.*
class Item {
	var property position
	var property image 
	
	method desaparecer(){
		game.removeVisual(self)
	}
}

class ItemDinamico inherits Item{
	var property tiempo
	
	method moverse()
	{
		self.position(new Position (x = 0.randomUpTo(14),y = 0.randomUpTo(8)))
	}	

}

class ItemEstatico inherits Item{
	
}


const cafiaspirina = new ItemDinamico(tiempo = 3000,position = new Position(x =0,y =4 ),image = "grano.png")