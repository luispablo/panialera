
  if Parametro.table_exists?
    # Crea los parámetros si no existen en la base
    Parametro::CODIGOS.keys.each do |k|
      parametro = Parametro.find_or_create_by_codigo(codigo: Parametro::CODIGOS[k], valor: Parametro::VALORES_POR_DEFECTO[k])
    end
  end
