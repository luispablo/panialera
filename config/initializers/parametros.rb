
  Parametro::CODIGOS.keys.each do |k|
    parametro = Parametro.find_by_codigo(Parametro::CODIGOS[k])
    
    unless parametro
      parametro = Parametro.create(codigo: Parametro::CODIGOS[k], valor: Parametro::VALORES_POR_DEFECTO[k])      
    end
  end
