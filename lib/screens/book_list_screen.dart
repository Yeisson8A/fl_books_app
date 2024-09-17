import 'package:fl_books_app/enums/classification_book_enum.dart';
import 'package:fl_books_app/services/books_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final booksService = Provider.of<BooksService>(context, listen: false);

    scrollController.addListener(() {
      // Validar si ya se llegó al final y se debe llamar a la siguiente página
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        booksService.getAllBooksByClassication(booksService.selectedCategory, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener instancia al servicio
    final booksService = Provider.of<BooksService>(context);
    final classificationBook = ClassificationBookEnum.searchByKey(booksService.selectedCategory);

    return Scaffold(
        appBar: AppBar(title: Text(classificationBook.value)),
        body: booksService.isLoading 
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive()
            ),
          )
        : _ListBooks(
            scrollController: scrollController, 
            books: booksService.booksByCategorySelected
          )
    );
  }
}

class _ListBooks extends StatelessWidget {
  final ScrollController scrollController;
  final List<Item> books;
  const _ListBooks({super.key, required this.scrollController, required this.books});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 260,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: books[index]),
            child: Container(
              height: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BookImage(
                        constraints: constraints, book: books[index]),
                    _BookBody(constraints: constraints, book: books[index])
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _BookBody extends StatelessWidget {
  final BoxConstraints constraints;
  final Item book;
  const _BookBody({super.key, required this.constraints, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.volumeInfo.authors != null &&
                    book.volumeInfo.authors!.isNotEmpty
                ? book.volumeInfo.authors![0]
                : "Not Found",
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: constraints.maxWidth * 0.09,
                ),
          ),
          Text(
            book.volumeInfo.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: constraints.maxWidth * 0.09,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class _BookImage extends StatelessWidget {
  final BoxConstraints constraints;
  final Item book;
  const _BookImage({super.key, required this.constraints, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight / 2,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 0,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: book.volumeInfo.imageLinks != null
                        ? FadeInImage(
                            height: constraints.maxHeight / 2,
                            width: constraints.maxWidth / 2,
                            placeholder:
                                const AssetImage('assets/jar-loading.gif'),
                            image: NetworkImage(
                                book.volumeInfo.imageLinks!.thumbnail),
                            fit: BoxFit.fill)
                        : Image(
                            height: constraints.maxHeight / 2,
                            width: constraints.maxWidth / 2,
                            image: const AssetImage('assets/no-image.png'),
                            fit: BoxFit.fill)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
