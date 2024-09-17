import 'dart:async';
import 'package:fl_books_app/enums/classification_book_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/debouncer.dart';
import '../models/models.dart';

class BooksService extends ChangeNotifier {
  final String _baseUrl = 'www.googleapis.com';
  final String _apiKey = 'AIzaSyDbw2j1JPYCQvZ92ntlNRNEgLrzs_rkWaQ';
  final int _maxResults = 40;
  int _actualIndex = 0;
  int _totalBooks = 0;
  final Map<String, List<Item>> _booksByCategory = {};
  String _selectedCategory = '';
  bool _isLoading = true;
  // Definir debouncer
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  // Stream controller para sugerencias de peliculas en el buscador
  final StreamController<List<Item>> _suggestionStreamController = StreamController.broadcast();
  // Stream para sugerencias de peliculas en el buscador
  Stream<List<Item>> get suggestionStream => _suggestionStreamController.stream;

  BooksService() {
    for (var item in ClassificationBookEnum.values) {
      _booksByCategory[item.name] = [];
    }
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getAllBooksByClassication(valor);
    notifyListeners();
  }

  List<Item> get booksByCategorySelected => _booksByCategory[_selectedCategory]!;

  Future<String> _getJsonDataByCategory(String searchValue) async {
    final url = Uri.https(_baseUrl, 'books/v1/volumes', {
        'key': _apiKey,
        'q': 'subject:"$searchValue"',
        'maxResults': '$_maxResults'
    });
    final response = await http.get(url);
    return response.body;
  }

  Future<String> _getJsonDataByCategoryAll(String searchValue, int index) async {
    final url = Uri.https(_baseUrl, 'books/v1/volumes', {
        'key': _apiKey,
        'q': 'subject:"$searchValue"',
        'startIndex': '$index',
        'maxResults': '$_maxResults'
    });
    final response = await http.get(url);
    return response.body;
  }

  Future<String> _getJsonData(String searchValue) async {
    final url = Uri.https(_baseUrl, 'books/v1/volumes', {
        'key': _apiKey,
        'q': searchValue,
        'maxResults': '$_maxResults'
    });
    final response = await http.get(url);
    return response.body;
  }

  Future<List<Item>> getBooksByClassication(String classification) async {
    final classificationBook = ClassificationBookEnum.values.singleWhere((e) => e.name == classification);
    final jsonData = await _getJsonDataByCategory(classificationBook.searchValue);
    final booksResponse = BooksResponse.fromRawJson(jsonData);
    return booksResponse.items;
  }

  getAllBooksByClassication(String classification, [bool nextPage = false]) async {
    final classificationBook = ClassificationBookEnum.values.singleWhere((e) => e.name == classification);
    _actualIndex = getNewIndex(nextPage);

    if (_actualIndex <= _totalBooks) {
      final jsonData = await _getJsonDataByCategoryAll(classificationBook.searchValue, _actualIndex);
      final booksResponse = BooksResponse.fromRawJson(jsonData);
      if (!nextPage) _totalBooks = booksResponse.totalItems;
      _booksByCategory[classification]!.addAll(booksResponse.items);
      _isLoading = false;
      // Indica que las propiedades en el provider cambiaron, para redibujar
      if (booksResponse.items.isNotEmpty) notifyListeners();
    }
  }

  getNewIndex(bool nextPage) {
    if (!nextPage) return 0;
    return _actualIndex + _maxResults;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    // Pasados 500 milisegundos y que el valor del buscador se asigno se hace la petición
    debouncer.onValue = (value) async {
      // Llamar método para obtener listado de libros con base en una búsqueda
      final results = await searchBooks(value);
      // Agregar resultado de libros al stream
      _suggestionStreamController.add(results);
    };
    // Esperar 300 milisegundos para asignar el valor del buscador
    final timer = Timer.periodic(const Duration(milliseconds: 300), ( _ ) {
      debouncer.value = searchTerm;
    });
    // Pasados 1 milisegundo más se cancela la espera del timer
    Future.delayed(const Duration(milliseconds: 301)).then(( _ ) => timer.cancel());
  }

  Future<List<Item>> searchBooks(String query) async {
    final jsonData = await _getJsonData(query);
    final booksResponse = BooksResponse.fromRawJson(jsonData);
    return booksResponse.items;
  }
}