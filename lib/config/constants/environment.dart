
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String UrlApi = dotenv.env['URL_API'] ?? 'No hay url';
}