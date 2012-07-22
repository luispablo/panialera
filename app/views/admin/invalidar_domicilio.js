
	$('#domicilios').html("<%=j render partial: 'admin/domicilios_sin_conf', locals: {domicilios: @domicilios} %>");
	$.unblockUI();
	alert('Domicilio <%= @domicilio.descripcion %> invalidado con éxito.');

