import semillas.*

class Parcela {
	var property ancho
	var property largo
	var property horasDeSolRecibe
	var property plantas = #{}
	
	method superficie() { return ancho * largo }
	method cantidadMaxima() {
		return if (ancho > largo) {
			self.superficie() / 5
		} else {
			self.superficie() / 3 + largo
		}
	}
	method tieneComplicaciones() {
		return plantas.any({ p => p.horasDeSolTolerancia() < horasDeSolRecibe })
	}	
	method plantarPlanta(unaPlanta) {
		if ((plantas.size() + 1) > self.cantidadMaxima() or 
			(horasDeSolRecibe > unaPlanta.horasDeSolTolerancia() + 2)
		) { self.error("No se puede plantar") }
		else { plantas.add(unaPlanta) }
	}
}

class Ecologica inherits Parcela {
	method seAsociaBien(planta) {
		return not self.tieneComplicaciones() and planta.esIdeal(self)
	}
}

class Industrial inherits Parcela {
	method seAsociaBien(planta) {
		return plantas.size() < 3 and planta.esFuerte()
	}
}

object inta {
	var parcelas = #{}
	
	method agregarParcela(parce) {
		parcelas.add(parce)
	}
	method plantasSize() {
		return parcelas.sum({ parce => parce.plantas().size() })
	}
	method promedioDePlantas() {
		return self.plantasSize() / parcelas.size()
	}
}