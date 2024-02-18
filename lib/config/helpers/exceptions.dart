class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = 'No autorizado']);
}

class ProductsEmptyException implements Exception {
  final String message;
  ProductsEmptyException([this.message = 'La lista de productos está vacía']);
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
}

// Excepciones Genericas
class GenericEmptyException implements Exception {
  final String message;
  GenericEmptyException([this.message = 'La lista esta vacia']);
}