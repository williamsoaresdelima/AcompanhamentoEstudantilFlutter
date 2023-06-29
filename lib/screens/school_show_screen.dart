import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../AppGlobalKeys.dart';
import '../components/school/school_carousel_image.dart';
import '../components/supplies_list.dart';
import '../models/School.dart';
import '../routes/route.dart';

class SchoolShowScreen extends StatelessWidget {
  SchoolShowScreen({super.key});
  @override
  Widget build(BuildContext context) {
    School school = ModalRoute.of(context)?.settings.arguments as School;
    final provider = Provider.of<SchoolProvider>(context);
    provider.singleSchool = school;
    provider.editing = false;

    List<Widget> builderImageCarousel() => provider.singleSchool.imageUrl
        .map((e) => SchoolCarouselImage(FirebaseStorage.instance.ref('school/${e}.jpg')))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${provider.singleSchool.name}"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  key: AppSchoolShowKeys.buttonEditSchool,
                  icon: Icon(Icons.edit),
                  onPressed: () => {
                        Navigator.of(context).pushNamed(Routes.schoolEditScreen,
                            arguments: school)
                      }),
            ),
          ],
        ),
        body: ChangeNotifierProvider(
            create: (context) => SchoolProvider(),
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    key: AppSchoolShowKeys.carouselImage,
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
                      items: builderImageCarousel()),
                ),
                const Text(
                  "Materiais Escolares",
                  style: TextStyle(fontSize: 25),
                ),
                SuppliesList(context, provider.singleSchool)
              ],
            )),
        floatingActionButton: FloatingActionButton(
            key: AppSchoolShowKeys.buttonAddSupplies,
            child: Icon(Icons.add),
            onPressed: () => {
                  Navigator.of(context).pushNamed(Routes.suppliesInsertScreen, arguments: school)
                }));
  }
}
