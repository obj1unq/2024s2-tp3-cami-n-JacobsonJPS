object almacen {
    const cosas = #{}
    var property maxBultos = 10

    method recibir(unaCosa) {
        cosas.add(unaCosa)
    }

    method puedeRecibir(camion) {
        return self.cantidadBultosAlmacen() + camion.totalBultos() <= maxBultos
    }

    method cantidadBultosAlmacen(){
        return cosas.sum({cosa => cosa.cantidadBultos()})
    }
} 
