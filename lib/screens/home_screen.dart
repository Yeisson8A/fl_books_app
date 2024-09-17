import 'package:fl_books_app/enums/classification_book_enum.dart';
import 'package:flutter/material.dart';
import '../search/book_search_delegate.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
   
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined, color: Colors.white),
            onPressed: () => showSearch(context: context, delegate: BookSearchDelegate()), 
          )
        ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Headline(category: ClassificationBookEnum.Fiction.name),
            SizedBox(
              height: height / 3.4,
              child: InformationBooks(category: ClassificationBookEnum.Fiction.name),
            ),
            Headline(category: ClassificationBookEnum.Anime.name),
            SizedBox(
              height: height / 3.4,
              child: InformationBooks(category: ClassificationBookEnum.Anime.name),
            ),
            Headline(category: ClassificationBookEnum.Adventure.name),
            SizedBox(
              height: height / 3.4,
              child: InformationBooks(category: ClassificationBookEnum.Adventure.name),
            ),
            Headline(category: ClassificationBookEnum.Novel.name),
            SizedBox(
              height: height / 3.4,
              child: InformationBooks(category: ClassificationBookEnum.Novel.name),
            ),
            Headline(category: ClassificationBookEnum.Horror.name),
            SizedBox(
              height: height / 3.4,
              child: InformationBooks(category: ClassificationBookEnum.Horror.name),
            ),
          ],
        ),
      ),
    );
  }
}