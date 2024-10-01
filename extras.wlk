import pepita.*
import wollok.game.*

object nido {

	var property position = game.at(3, 3)

	method image() = "nido.png"

	method teEncontro(ave) {
		game.say(ave, "GANASTE! WIII")
		game.schedule(2000, { game.stop() })
	}
}


object silvestre {

	method image() = "silvestre.png"

	method teEncontro(ave) {
	    game.say(ave, "PERDI!")
		game.schedule(2000, { game.stop() })
	}

	//method position() = game.at(pepita.position().x().max(3), 0 )  //x, y
	method position() = game.at(pepita.position().x().max(3), 0 ) 
	method restriccion() = pepita.position().x().max(3) 
	
}
