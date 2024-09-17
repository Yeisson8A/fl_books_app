import 'package:fl_books_app/enums/classification_book_enum.dart';
import 'package:fl_books_app/services/books_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Headline extends StatelessWidget {
  final String category;
  const Headline({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Obtener instancia al servicio
    final booksService = Provider.of<BooksService>(context, listen: false);
    final classificationBook = ClassificationBookEnum.searchByKey(category);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            classificationBook.value,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          InkWell(
            onTap:() {
              booksService.selectedCategory = category;
              Navigator.pushNamed(context, 'book_list');
            },
            child: Text("Ver todo", style: Theme.of(context).textTheme.titleSmall),
          )
        ],
      ),
    );
  }
}