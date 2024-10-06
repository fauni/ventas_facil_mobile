abstract class SerieNumeracionEvent {
  const SerieNumeracionEvent();
}

class GetSerieNumeracionByIdDocument extends SerieNumeracionEvent{
  final int tipoDocumento;

  GetSerieNumeracionByIdDocument(this.tipoDocumento);
}