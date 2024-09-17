import 'package:fl_books_app/enums/classification_book_enum.dart';
import 'package:fl_books_app/services/books_service.dart';
import 'package:fl_books_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener instancia al servicio
    final booksService = Provider.of<BooksService>(context, listen: false);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final categories = getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorías"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 16 / 15,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            final categoryKey = categories[index].keys.first;
            final categoryUrl = categories[index].values.first;
            final classification = ClassificationBookEnum.searchByKey(categoryKey);

            return GestureDetector(
              onTap: () {
                booksService.selectedCategory = categoryKey;
                Navigator.pushNamed(context, 'book_list');
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(categoryUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                          stops: const [0.6, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      classification.value,
                      style: textTheme.headlineSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}