
import 'package:ventas_facil/models/serie_numeracion/serie_numeracion.dart';

abstract class SerieNumeracionState {
  const SerieNumeracionState();
}

class SerieNumeracionInitial extends SerieNumeracionState{}

class SerieNumeracionLoading extends SerieNumeracionState{}

class SerieNumeracionPorDocumentoLoaded extends SerieNumeracionState {
  final List<SerieNumeracion> series;
  const SerieNumeracionPorDocumentoLoaded(this.series);
}

class SerieNumeracionError extends SerieNumeracionState {
  final String message;

  const SerieNumeracionError(this.message);
}

class SerieNumeracionUnauthorized extends SerieNumeracionState{}
class SerieNumeracionEmpty extends SerieNumeracionState{}