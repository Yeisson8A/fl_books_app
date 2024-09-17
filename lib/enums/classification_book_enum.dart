enum ClassificationBookEnum {
  Fiction('Ficción', 'fiction'),
  Anime('Anime', 'anime'),
  Adventure('Acción y Aventura', 'action+adventure'),
  Novel('Novela', 'novel'),
  Horror('Horror', 'horror'),
  Classic('Clásico', 'classic'),
  Romance('Romance', 'romance'),
  Mystery('Misterio', 'mystery'),
  Fantasy('Fantasía', 'fantasy'),
  History('Historia', 'history'),
  Comic('Cómic', 'comic'),
  Crime('Crimen', 'crime');

  final String value;
  final String searchValue;

  const ClassificationBookEnum(this.value, this.searchValue);

  static ClassificationBookEnum searchByKey(String classification) {
    return values.firstWhere((e) => e.toString() == 'ClassificationBookEnum.$classification');
  }
}