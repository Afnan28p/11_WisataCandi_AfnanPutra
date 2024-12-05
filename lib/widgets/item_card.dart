import 'package:flutter/material.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/screens/details_screen.dart';

class ItemCard extends StatelessWidget {
  // TODO: 1. Deklarasi Variabel Yang dibutuhkan dan pasangkan ke constructor
  const ItemCard({super.key, required this.candi});
  final Candi candi;
  @override

  Widget build(BuildContext context) {
    //TODO: 6. Implementasi Routing ke DetailScreen
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(candi: candi),
          ),
        );
      },
      child: Card(
        // TODO:2. Tetapkan Parameter shape,margin.dan evevation dari Cari
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(5.0),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // TODO: 3. Buat Image Sebagai Anak Dari Column
            Expanded(
              // TODO: 7. Implementasi Hero animation
              child: ClipRRect(
                child: Image.asset(
                  candi.imageAsset,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // TODO: 4. Buat Text Sebagai Anak Dari Column
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                candi.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            // TODO: 5. Buat Text Sebagai Anak Dari Column
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                candi.type,
                style : const TextStyle(
                  fontSize: 12,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
