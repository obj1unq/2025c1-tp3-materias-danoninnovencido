
class Carrera {
  const nombreDeLaCarrera 
  const materiasDeLaCarrera = []

  method nombre() {return nombreDeLaCarrera}

  method materias() {return materiasDeLaCarrera}

  method tieneLaMateria(materia) {
    return materiasDeLaCarrera.contains(materia)
  }
}



class Materia {
  const nombreDeLaMateria = ""
  const materiaPrerequisito = []
  const cupo = 0
  const listaDeEspera = []
  const property inscriptos = [] //Estudiantes 

  method cuposDeLaMateria() {return cupo}

  method listaDeEspera(){return listaDeEspera}        

  method materiaPrerequisito(){return materiaPrerequisito}   

  method inscribirEstudiante(estudiante) {
    if (self.puedeInscribirse(estudiante)){
      inscriptos.add(estudiante)
    }else{
      listaDeEspera.add(estudiante)
    }
  }

  method puedeInscribirse(estudiante) {
    return estudiante.cursaLaMateria(self) and not estudiante.esMateriaAprobada(self) and not self.estaInscripto(estudiante) and self.tieneRequisitos(estudiante)
  }

  method estaInscripto(estudiante) {
    return inscriptos.contains(estudiante)
  }

  method tieneRequisitos(estudiante) {
    return materiaPrerequisito.all({materia => estudiante.esMateriaAprobada(materia)})
  }
  
  method darDeBaja(estudiante){
    self.bajaDeEstudiante(estudiante)
    inscriptos.add(self.estudiantePrioritarioEnEspera())
    self.quitarEstudianteEnEspera()
  }

  method bajaDeEstudiante(estudiante){return inscriptos.remove(estudiante)}

  method estudiantePrioritarioEnEspera(){return listaDeEspera.first()}

  method quitarEstudianteEnEspera(){return listaDeEspera.remove(self.estudiantePrioritarioEnEspera())}
}


class Aprobacion{
  const property materia 
  const property nota = 0
  
}

class Estudiante {  
 
  const carrerasInscripto = []
  const materiasAprobadas = []    //Es una lista de instancias de Aprobación, no son materias aprobadas como tal.

  method materiasAprobadas(){return materiasAprobadas.map({aprobada=> aprobada.materia()})}

  method carrerasInscripto() {return carrerasInscripto}

  method registrarMateriaAprobada(materia,nota){
    self.validarMateriaAprobada(materia)
    materiasAprobadas.add(new  Aprobacion (materia = materia, nota = nota))
  }

  method promedioDeLasMateriasAprobadas(){return materiasAprobadas.average()}

  method validarMateriaAprobada(materia) {
    if (self.esMateriaAprobada(materia)) { 
      self.error('La materia se encuentra ya registrada y aprobada')
    }
  }

  method esMateriaAprobada(materia){ return materiasAprobadas.any({aprobada => aprobada.materia() ==  materia})} //Trabaja con instancias de Aprobacion 


  method cursaLaMateria(materia) {return carrerasInscripto.any({carrera => carrera.tieneLaMateria(materia)})}
  
  method materiasEnCurso(){return }






}




  

//---------------------------------------------------------
