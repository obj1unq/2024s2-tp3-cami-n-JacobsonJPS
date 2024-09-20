object ruta9 {
    method validarViaje(camion) {
        if (not camion.puedeCircularEnRuta(11)) {
            self.error("El camión no puede circular por la ruta 9")
        }
    }
}

object caminoVecinal {
    var property pesoMaximoSoportado = 6000 // Inicializo esta propiedad con un valor de ejemplo

    method validarViaje(camion) {
        if (camion.pesoTotal() > pesoMaximoSoportado) {
            self.error("El camión excede el peso máximo del camino vecinal")
        }
    }
}