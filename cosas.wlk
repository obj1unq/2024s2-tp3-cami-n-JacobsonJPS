object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method cantidadBultos() { return 1} 
	method reaccionarACarga() {}
}


///////////////////////////////////////////////////////////
object bumblebee {
	
	var modo = modoAuto
	
	method transformar(vehiculo){
		modo = vehiculo
	}

	method peso() { return 800 }
	
	method nivelPeligrosidad() {
		return modo.nivelPeligrosidad()
	}

	method cantidadBultos() { return 2} 

	method reaccionarACarga() {
		self.transformar(modoRobot)
	}

}
object modoAuto {
	method nivelPeligrosidad() {return 15}
}
object modoRobot {
	method nivelPeligrosidad() {return 30}
}
///////////////////////////////////////////////////////////
object paqueteDeLadrillos {
	var property cantidadLadrillos = 0

	method agregarLadrillos(cantidad){
		cantidadLadrillos += cantidad
	}

	method reaccionarACarga() {
		self.agregarLadrillos(12)
	}

	method peso() { 
		return cantidadLadrillos * ladrillo.peso() }
	
	method nivelPeligrosidad() { return 2 }

	method cantidadBultos() { 
		return if (cantidadLadrillos <= 100) 1
        else if (cantidadLadrillos <= 300) 2
        else 3
	} 
}

object ladrillo {
	method peso() { return 2 }
	
}


///////////////////////////////////////////////////////////

object arenaGranel {
	
	var property peso = 0
	
	method nivelPeligrosidad() { return 1 }

	method cantidadBultos() { return 1} 

	method reaccionarACarga() {
		peso += 20
	}
}

///////////////////////////////////////////////////////////

object bateriaAntiaerea {
	
	var estado = sinMisiles
	
	method cargarMisiles(){
		estado = conMisiles
	}

	method descargarMisiles(){
		estado = sinMisiles
	}

	method peso() { 
		return	estado.peso()		
	}

	method nivelPeligrosidad() { 
		return estado.nivelPeligrosidad()
	}

	method cantidadBultos() { 
		return estado.cantidadBultos()
	} 

	method reaccionarACarga() {
		self.cargarMisiles()
	}
}

object conMisiles {
	method nivelPeligrosidad() = 100
	method peso() = 100
	method cantidadBultos() = 2
}

object sinMisiles {
	method nivelPeligrosidad() = 100
	method peso() = 100
	method cantidadBultos() = 1
}
///////////////////////////////////////////////////////////

object contenedorPortuario {
	const contenido = []

	method agregarContenido(cosa){
		contenido.add(cosa)
	}



	method peso() { 
		return 100 + self.pesoDeContenido()
	}

	method pesoDeContenido() {
		return contenido.sum({objeto => objeto.peso()})
	}

	method nivelPeligrosidad() { 
		return if (contenido.isEmpty()) 0 else self.objetoMasPeligroso()
	}

	method objetoMasPeligroso() {
		return contenido.max({objeto => objeto.nivelPeligrosidad()})
	}

	method cantidadBultos() { 
		return 1 + self.bultosContenedor()
	}

	method bultosContenedor(){
		return contenido.sum({cosa => cosa.cantidadBultos()})
	} 

	method reaccionarACarga() {
		contenido.forEach({elemento => elemento.reaccionarACarga()})
	}
}
///////////////////////////////////////////////////////////

object residuosRadioactivos {

    var property peso = 0

   method nivelPeligrosidad() { return 200 }

   method cantidadBultos() { return 1} 

   method reaccionarACarga() {
	peso += 15
   }
}
///////////////////////////////////////////////////////////

object embalajeSeguridad {
	
	const contenido = #{vacio}

	method cantidadBultos() { return 2} 

	method embalarObjecto(objeto){
		contenido.remove(vacio)
		contenido.add(objeto)
	}

	method desEmbalarObjecto(objeto){
		contenido.remove(objeto)
		contenido.add(vacio)
	}
	
	method peso() { 
		return contenido.peso()
	}


	method nivelPeligrosidad() { 
		return contenido.nivelPeligrosidad() / 2
	}

	method reaccionarACarga() {}
}

object vacio {
	method peso() = 0
	method nivelPeligrosidad() = 0
}
///////////////////////////////////////////////////////////
