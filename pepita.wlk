import extras.*
import niveles.*
import wollok.game.*

object pepita {
     var property enemigo = silvestre
     var property objetivo = nido

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
	
	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
		game.removeVisual(comida)
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if (!self.terminoElJuego()){
		self.vola(position.distance(nuevaPosicion))
		position = nuevaPosicion
		self.corregirPosicion()
		}
	}

	method caer() {
        position = position.down(1)
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
	method chequearEstadoJuego() {
    if (self.estaCansada()) {
      game.sound("perdiste.wav").play()
      game.schedule(3000, { game.stop() })
	  game.removeTickEvent("pepitaCae")
    }
    if (self.llegoAlNido()) {
      game.sound("ganaste.mp3").play()
      game.schedule(17000, { game.stop() })
	  game.removeTickEvent("pepitaCae")
    }
	if (self.terminoElJuego()) {
      game.removeTickEvent("pepitaCae")
    }
  }
  method teAtraparon() = enemigo.position() == self.position()
  method llegoAlNido() = objetivo.position() == self.position()
  method terminoElJuego() = self.estaCansada() || self.teAtraparon() || self.llegoAlNido()

	//method atraparComida() = game.uniqueCollider(self)

	//method atraparComida() {
    //    const comidas = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
    //    if (!comidas.isEmpty()) {
    //      const comida = comidas.first()
    //      self.comer(comida)
    //      game.removeVisual(comida)
    //}
    //}
}

