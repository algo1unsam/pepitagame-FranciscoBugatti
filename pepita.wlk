import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido())
		{ 
			"pepita-grande.png" 
		}
		else if(self.esAtrapada() or self.estaCansada()){
			"pepita-gris.png"
			}
			else "pepita.png"
	}

    method esAtrapada() = self.position() == silvestre.position()
	
	method come() {
		energia = energia + self.atraparComida().energiaQueOtorga()
		game.removeVisual(self.atraparComida())
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if (!self.esAtrapada() and !self.estaCansada()){
		self.vola(position.distance(nuevaPosicion))
		position = nuevaPosicion
		}
	}

	method caer() {
        position = self.position().down(1)
		self.corregirPosicion()
    }
    method corregirPosicion() {
        position = game.at(position.x().max(0).min(game.width()), position.y().max(0).min(game.height()))
    }
	
	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}
	
	
	method estaEnElSuelo() {
		return position.y() == 0 
	}
	

	method atraparComida() = game.uniqueCollider(self)

	//method atraparComida() {
    //    const comidas = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
    //    if (!comidas.isEmpty()) {
    //      const comida = comidas.first()
    //      self.comer(comida)
    //      game.removeVisual(comida)
    //}
    //}
}

