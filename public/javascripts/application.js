// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function mascara(o,f){
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}

function execmascara(){
    v_obj.value=v_fun(v_obj.value)
}

function mdata(v){
    v=v.replace(/\D/g,"")                          //Remove tudo o que não é dígito
  
    v=v.replace(/(\d{2})(\d)/,"$1/$2")       //Coloca um ponto entre o terceiro e o quarto dígitos
    v=v.replace(/(\d{2})(\d)/,"$1/$2")       //Coloca um ponto entre o terceiro e o quarto dígitos
                                             //de novo (para o segundo bloco de números)
    return v
}

function soNumeros(v){
	v=v.replace(/\D/g,"")
	return v
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".campos").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

//-------------------------------------------------------
//Calendário

function diaEMes(data){
	var dia = data.substring(0,2);
	var mes = data.substring(3,5);
	
	return dia + '/' + mes;
}

function proximaData(data){
	var dia = parseInt(data.substring(0,2),10);
	var mes = parseInt(data.substring(3,5),10);
	var ano = parseInt(data.substring(6,10),10);
	
	var bisexto = ehBisexto(ano);
	var max_dia = 31;

	if(mes == 4 || mes == 6 || mes == 9 || mes == 11){
		max_dia = 30;
	}else if(mes == 2){
		if(bisexto){
			max_dia = 29;
		}else{
			max_dia = 28;
		}
	}
	
	if(dia + 1 > max_dia){
		if(mes + 1 > 12){
			dia = 1;
			mes = 1;
			ano = ano + 1;
		}else{
			dia = 1;
			mes = mes + 1;
		}
	}else{
		dia = dia + 1;
	}
	
	
	return formatarData(dia) + '/' + formatarData(mes) + '/' + formatarAno(ano);
	
}

function dataAnterior(data){
	var dia = parseInt(data.substring(0,2),10);
	var mes = parseInt(data.substring(3,5),10);
	var ano = parseInt(data.substring(6,10),10);
	
	if(dia - 1 < 1){
		if(mes > 1){
			mes = mes - 1;
		}else{
	 		mes = 12;
			ano = ano - 1;
		}
		
		var bisexto = ehBisexto(ano);
		var max_dia = 31;

		if(mes == 4 || mes == 6 || mes == 9 || mes == 11){
			max_dia = 30;
		}else if(mes == 2){
			if(bisexto){
				max_dia = 29;
			}else{
				max_dia = 28;
			}
		}
		
		dia = max_dia;
			
	}else{
		dia = dia - 1;
	}
	
	return formatarData(dia) + '/' + formatarData(mes) + '/' + formatarAno(ano);

}

function ehBisexto(ano){
	if ((ano % 4) == 0 && ((ano % 400 == 0) || (ano % 100 != 0))){
  		return true;
	}
  	return false;
}

function formatarData(numero){
	if(numero < 10){
		return ('0' + numero);
	}
	return numero;
}

function formatarAno(ano){
	for(j = ano.length; j < 4; j = j + 1){
		return ('0' + ano); 
	}
	return ano;
}

function incrementDataByN(data,n){
	for(i = 0; i < n; i = i + 1){
		data = proximaData(data);
	}
	return data;
}

function decrementDataByN(data,n){
	for(i = 0; i < n; i = i + 1){
		data = dataAnterior(data);
	}
	return data;
}

function dataFormatoInternacional(data){
	var dia = data.substring(0,2);
	var mes = data.substring(3,5);
	var ano = data.substring(6,10);
	
	return ano + '-' + mes + '-' + dia;
}
