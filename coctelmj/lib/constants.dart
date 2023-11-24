class Constants {
  // Rutas para las imágenes de categorías
  static const String cocteles = 'assets/cocteles/';
  static const String shots = 'assets/shots/';
  static const String naturales = 'assets/naturales/';

  // Obtener la ruta completa de una imagen de coctel por índice
  static String coctelesImage(int index) {
    return '$cocteles${(index + 1).toString().padLeft(2, '0')}.png';
  }

  // Obtener la ruta completa de una imagen de shot por índice
  static String shotsImage(int index) {
    return '$shots${(index + 1).toString().padLeft(2, '0')}.png';
  }

  // Obtener la ruta completa de una imagen de natural por índice
  static String naturalesImage(int index) {
    return '$naturales${(index + 1).toString().padLeft(2, '0')}.png';
  }
}
