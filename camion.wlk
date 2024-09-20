import cosas.*
import lugares.*

object camion {
	var property cosas = []
	const pesoMaximo = 2500
	const tara = 1000
		
	method cargar(unaCosa) {
		if (not self.excedidoDePeso()){
			cosas.add(unaCosa)
			unaCosa.reaccionarACarga()
		}
		else {
			self.error("No se puede cargar objetos porque excede el peso maximo del camion")
		}
		
	}

	method descargar(unaCosa) {
		if (cosas.contains(unaCosa)) {
            cosas.remove(unaCosa)
        } else {
            self.error("La cosa no está en el camión")
        }
    }
	
	

	method todoPesoPar(){
		return cosas.all({cosa => cosa.peso().even()})
	}

	method hayAlgunoQuePesa(peso){
		return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel) {
		if (self.validarAlgunoDeNivel(nivel)){
			cosas.find({ cosa => cosa.nivelPeligrosidad() == nivel })
		}
		else {
			self.error("No hay objeto con ese nivel")
		}
	}

	method validarAlgunoDeNivel(nivel){
		return cosas.any({cosa => cosa.nivelPeligrosidad() == nivel})
	}

	method pesoTotal() {
		return tara + self.pesoCarga()
	}

	method pesoCarga(){
		return cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso(){
		return self.pesoTotal() > pesoMaximo
	}

	method objetosQueSuperanPeligrosidad(nivel) {
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa) {
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > cosa.nivelPeligrosidad()}).set()
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad){
		return (not self.excedidoDePeso() && not self.algoSuperaPeligrosidad(nivelMaximoPeligrosidad) )
	}

	method algoSuperaPeligrosidad(nivelMaximoPeligrosidad){
		return not self.objetosQueSuperanPeligrosidad(nivelMaximoPeligrosidad).isEmpty()
	}


	method pesoEstaEntre(min, max, cosa) {
  		cosa.peso() >= min && cosa.peso() <= max
	}

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any({ cosa => self.pesoEstaEntre(min, max, cosa) })
	}

	method cosaMasPesada(){
		if (not cosas.isEmpty()){
			return cosas.max({cosa => cosa.peso()})
		}
		else {
			self.error("El camión está vacío")
		}
	}
	
	method pesos(){
		cosas.map({cosa => cosa.peso()})
	}

	method totalBultos(){
		return cosas.sum({cosa => cosa.cantidadBultos()})
	}

	// Metodo de transporte de cosas del camion hacia un destino
	method transportar(destino, camino) {
        if (self.excedidoDePeso()) {
            self.error("El camión está excedido de peso")
        }
        camino.validarViaje(self)

        if (destino.puedeRecibir(self)) {
            cosas.forEach({elemento => destino.recibir(elemento) })
            cosas.clear()
        } else {
            self.error("El destino no puede recibir la carga")
        }
    }
}
