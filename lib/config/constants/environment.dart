
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // ignore: non_constant_identifier_names
  static String UrlApi = dotenv.env['URL_API'] ?? 'No hay url';
}