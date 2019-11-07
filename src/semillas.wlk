import parcelas.*

class Planta {
	var property anioDeObtencion
	var property altura
	var property horasDeSolTolerancia 
	
	method esFuerte() {
		return horasDeSolTolerancia > 10
	}
	method daNuevasSemillas() {
		return self.esFuerte()
	}
	method espacio()
}

class Menta inherits Planta {
	override method horasDeSolTolerancia() { return 6 }
	override method daNuevasSemillas() {
		return altura > 0.4
	}
	override method espacio() {
		return altura * 3
	}
	method esIdeal(parcela) {
		return parcela.superficie() > 6
	}
}

class Soja inherits Planta {
	override method horasDeSolTolerancia() {
		if (altura < 0.5){
			return 6
		} else if (altura.between(0.5, 1)) {
			return 7
		} else {
			return 9
		}
	}
	override method daNuevasSemillas() {
		return super() or (anioDeObtencion > 2007 and altura > 1)
	}
	override method espacio() {
		return altura / 2
	}
	method esIdeal(parcela) {
		return parcela.horasDeSolRecibe() == horasDeSolTolerancia
	}
}

class Quinoa inherits Planta {	
	override method espacio() { return 0.5 }
	override method daNuevasSemillas() {
		return super() or (anioDeObtencion < 2005)
	}
	method esIdeal(parcela) {
		//var plantas = parcela.plantas()
		//return plantas.all({ p=>p.altura <= 1.5 })
		return parcela.plantas().all({ p => p.altura() <= 1.5 }) //PROBAR SI ANDA 
	}
}

class SojaTransgenica inherits Soja {
	override method daNuevasSemillas() { return false }
	override method esIdeal(parcela) {
		return parcela.cantidadMaxima() == 1
	}
}

class Hierbabuena inherits Menta {
	override method espacio() {
		return super() *2
	}
}