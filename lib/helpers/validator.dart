import 'package:projeto_tres/helpers/date_helper.dart';

class Validator {
  static String vTelefone(String value) {
    Pattern pattern = r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value))
      return 'Número de telefone inválido';
    else
      return null;
  }

  static String vDate(String value){ 
    DateTime date = DateHelper.parse(value);
    if(date.isAfter(DateTime.now())) return 'Impossivel emprestar objeto no futuro';
    return null;
  }

  static String vText(String value){
    if(value.isEmpty) return "Campo obrigátorio";
    if(value.length == 1) return "Erro";
    return null;
  }
}
