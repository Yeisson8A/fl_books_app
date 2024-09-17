import 'package:fl_books_app/services/books_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class InformationBooks extends StatelessWidget {
  final String category;
  const InformationBooks({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Obtener instancia al servicio
    final booksService = Provider.of<BooksService>(context);

    return FutureBuilder(
      future: booksService.getBooksByClassication(category),
      builder: (context, snapshot) {
        // En caso de que no tenga datos
        if (!snapshot.hasData) {
          return const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60, width: 60, child: Center(child: CircularProgressIndicator()))
              ]
            )
          );
        }
        // Obtener datos del future
        final List<Item> books = snapshot.data!;

        return LayoutBuilder(builder: (context, constraints) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 40,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: books[index]),
                child: Container(
                  width: constraints.maxWidth * 0.30,
                  padding: const EdgeInsets.only(left: 16, bottom: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BookImage(constraints: constraints, book: books[index]),
                      _BookBody(constraints: constraints, book: books[index])
                    ],
                  ),
                ),
              );
            },
          );
        });
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
    return Text(
      book.volumeInfo.title ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: constraints.maxWidth * 0.035, fontWeight: FontWeight.w500),
    );
  }
}

class _BookImage extends StatelessWidget {
  final BoxConstraints constraints;
  final Item book;
  const _BookImage({super.key, required this.constraints, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: constraints.maxHeight * 0.6,
        width: constraints.maxWidth * 0.25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: book.volumeInfo.imageLinks != null
          ? FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'),
              image:
                  NetworkImage(book.volumeInfo.imageLinks!.thumbnail),
              fit: BoxFit.cover
            )
          : const Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}
