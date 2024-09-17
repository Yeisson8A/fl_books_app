import 'package:fl_books_app/services/books_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class BookSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar libro';

  // Opciones que aparecerán en el buscador (Extremo derecho)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () => query = ''
      )
    ];
  }

  // Opciones que aparecerán en el buscador (Extremo izquierdo)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => close(context, null) 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  // Listado de datos a mostrar como sugerencias del buscador
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final booksService = Provider.of<BooksService>(context, listen: false);
    booksService.getSuggestionsByQuery(query);

    // Llamar a un stream que va a estar escuchando
    return StreamBuilder(
      stream: booksService.suggestionStream,
      builder: ( _, AsyncSnapshot<List<Item>> snapshot) {
        // En caso de que no tenga datos
        if (!snapshot.hasData) return _emptyContainer();

        // Obtener datos del future
        final List<Item> books = snapshot.data!;

        if (books.isEmpty) {
          return _emptyContainer();
        }
        // Cuando ya se tiene datos
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) => _BookItem(books[index])
        );
      },
    );
  }
  
  // Widget que se utilizará cuando no haya datos
  Widget _emptyContainer() {
    return Container(
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, color: Colors.black38, size: 130),
            Text('Sin registros para mostrar', style: TextStyle(fontSize: 23, color: Colors.black38))
          ],
        ),
      )
    );
  }
}

class _BookItem extends StatelessWidget {
  final Item book;
  const _BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.volumeInfo.authors != null &&  book.volumeInfo.authors!.isNotEmpty ? book.volumeInfo.authors![0] : "Not Found"),
      subtitle: Text(book.volumeInfo.title ?? ''),
      leading: book.volumeInfo.imageLinks != null
      ? FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(book.volumeInfo.imageLinks!.thumbnail),
          width: 50,
          fit: BoxFit.cover,
        )
      : const Image(
          image: AssetImage('assets/no-image.png'),
          width: 50,
          fit: BoxFit.cover
        ),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: book)
    );
  }
}