import 'package:url_launcher/url_launcher.dart';

class LigarTelefone{

  void call(String number) => launch('tel:$number');
}