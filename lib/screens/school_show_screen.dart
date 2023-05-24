import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/supplies_list.dart';
import '../models/School.dart';
import '../providers/supplies_provider.dart';
import '../routes/route.dart';

class SchoolShowScreen extends StatelessWidget {
  const SchoolShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    School school = ModalRoute.of(context)?.settings.arguments as School;
    
    return Scaffold(
        appBar: AppBar(title: Text("${school.name}")),
        body: ChangeNotifierProvider(
            create: (context) => SchoolProvider(),
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 10,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 10,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: school.imageUrl.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 249, 235)),
                              child: Image.network(i));
                        },
                      );
                    }).toList(),
                  ),
                ),
                Text("Materiais Escolares",
                style: TextStyle(fontSize: 25),),
                SuppliesList(context, school)
              ],
            )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {
                  Navigator.of(context)
                      .pushNamed(Routes.suppliesInsertScreen, arguments: school)
                }));
  }
}
