require '../Proyecto final/model'

class Factory
  def self.datos_alumnos(tipo, *arg) # el segundo argumento debe ser un array, se recibira por partes del menu
    case tipo
    when 1
      return Colegio_nacional.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5], arg[6], arg[7], arg[8])
    when  2
      return Colegio_particular.new(arg[0], arg[1], arg[2], arg[3],arg[4],arg[5], arg[6], arg[7], arg[8])
    end
  end
  def self.datos_tutores(*arg)# el segundo argumento debe ser un array, se recibira por partes del menu
    return Tutor.new(arg[0], arg[1], arg[2], arg[3], arg[4])
  end
end

a = Tutor.new(12,12,12,12,12)