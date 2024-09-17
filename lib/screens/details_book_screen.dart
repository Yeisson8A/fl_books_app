import 'package:fl_books_app/theme/app_theme.dart';
import 'package:fl_books_app/utils/utils.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:readmore/readmore.dart';

class DetailsBookScreen extends StatelessWidget {
  const DetailsBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Item book = ModalRoute.of(context)!.settings.arguments as Item;
    double height = MediaQuery.of(context).size.height / 815;
    double width = MediaQuery.of(context).size.width / 375;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(book),
            SliverList(
              delegate: SliverChildListDelegate([
                _DetailBookImage(height: height, book: book),
                _DetailBookBody(height: height, width: width, book: book)
              ])
            )
          ],
        )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Item book;
  const _CustomAppBar(this.book);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      expandedHeight: 150,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(book.volumeInfo.title ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: Colors.white))
        ),
      ),
    );
  }
}

class _DetailBookBody extends StatelessWidget {
  final double height;
  final double width;
  final Item book;
  const _DetailBookBody(
      {super.key,
      required this.height,
      required this.width,
      required this.book});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            book.volumeInfo.title ?? '',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            book.volumeInfo.authors != null &&
                    book.volumeInfo.authors!.isNotEmpty
                ? book.volumeInfo.authors![0]
                : "Censored",
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          _DetailBookHeader(height: height, width: width, book: book),
          const SizedBox(height: 20),
          Text("Detalle", style: textTheme.headlineSmall),
          const SizedBox(
            height: 10,
          ),
          _DetailBookInformation(book: book),
          const SizedBox(
            height: 20,
          ),
          Text(book.volumeInfo.description != null ? 'Descripción' : '', style: textTheme.headlineSmall),
          const SizedBox(height: 10),
          ReadMoreText(
            book.volumeInfo.description ?? '',
            trimLines: 6,
            colorClickableText: AppTheme.textColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...Mostrar más',
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 14),
            trimExpandedText: '...Mostrar menos',
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _DetailBookHeader extends StatelessWidget {
  final double height;
  final double width;
  final Item book;
  const _DetailBookHeader(
      {super.key,
      required this.height,
      required this.width,
      required this.book});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(book.volumeInfo.printType, style: textTheme.titleMedium),
          const Spacer(flex: 2),
          Container(
            height: height * 35,
            width: width * 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppTheme.secondary, borderRadius: BorderRadius.circular(12)),
            child: OutlinedButton(
              onPressed: () => openUrl(context, book.volumeInfo.previewLink),
              style: OutlinedButton.styleFrom(side: const BorderSide(width: 1)),
              child: const Text("Ver", style: TextStyle(color: Colors.white)),
            ),
          ),
          const Spacer(),
          Text('${book.volumeInfo.pageCount ?? 0} Págs.', style: textTheme.titleMedium)
        ],
      ),
    );
  }
}

class _DetailBookInformation extends StatelessWidget {
  final Item book;
  const _DetailBookInformation({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      child: Row(children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Autor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text("Editorial", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text("Publicación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.volumeInfo.authors != null && book.volumeInfo.authors!.isNotEmpty
                    ? book.volumeInfo.authors![0] : "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(fontSize: 14, color: AppTheme.textColor)
              ),
              Text(
                book.volumeInfo.publisher ?? '', 
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(fontSize: 14, color: AppTheme.textColor)
              ),
              Text(
                book.volumeInfo.publishedDate ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(fontSize: 14, color: AppTheme.textColor)
              ),
              Text(
                book.volumeInfo.categories != null && book.volumeInfo.categories!.isNotEmpty
                    ? book.volumeInfo.categories![0] : '',
                    maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(fontSize: 14, color: AppTheme.textColor)
              )
            ]
          )
        )
      ]),
    );
  }
}

class _DetailBookImage extends StatelessWidget {
  final double height;
  final Item book;
  const _DetailBookImage({super.key, required this.height, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 300,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: height * 250,
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: book.volumeInfo.imageLinks != null
                      ? FadeInImage(
                          placeholder:
                              const AssetImage('assets/jar-loading.gif'),
                          image: NetworkImage(
                              book.volumeInfo.imageLinks!.thumbnail),
                          fit: BoxFit.cover)
                      : const Image(
                          image: AssetImage('assets/no-image.png'),
                          fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}
