import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SchoolCarouselImage extends StatelessWidget {
  SchoolCarouselImage(this.reference, {super.key});

  final Reference reference;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromARGB(255, 253, 249, 235)),
          child: FutureBuilder(
              future: reference.getDownloadURL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Center(child: CircularProgressIndicator());
                else if (snapshot.hasError)
                  return const Center(child: Text("Erro ao consultar dados."));
                else if (snapshot.hasData) {
                  final list = snapshot.data;
                  if (list != null && list.isNotEmpty)
                    return Image.network(
                        width: 50,
                        height: 150,
                        fit: BoxFit.fill,
                        snapshot.data!);
                  else
                    return const Center(
                        child: Text("Nenhum material cadastrado."));
                } else
                  return const Center(
                      child: Text("Nenhum material cadastrado."));
              }));
    });
  }
}
