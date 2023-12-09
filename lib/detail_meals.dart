import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api_data_source.dart';
import 'model/detail.dart';


class DetailMeals extends StatefulWidget {
  final String idMeals;
  const DetailMeals({super.key, required this.idMeals});

  @override
  State<DetailMeals> createState() => _DetailMealsState();
}

class _DetailMealsState extends State<DetailMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: ApiDataSource.instance.getDetailMeals(widget.idMeals),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR'),
              );
            }
            if (snapshot.hasData) {
              Detail detail = Detail.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: detail.meals?.length,
                itemBuilder: (BuildContext context, int index) {
                  var details = detail.meals?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(

                        '${details?.strMealThumb}',
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${details?.strMeal}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 22
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Category: ${details?.strCategory}'),
                          Text('Area: ${details?.strArea}')
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ingridients', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('${details?.strIngredient1}'),
                          Text('${details?.strIngredient2}'),
                          Text('${details?.strIngredient3}'),
                          Text('${details?.strIngredient4}'),
                          Text('${details?.strIngredient5}'),
                          Text('${details?.strIngredient6}'),
                          Text('${details?.strIngredient7}'),
                          Text('${details?.strIngredient8}'),
                          Text('${details?.strIngredient9}')

                        ],
                      ),

                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('${details?.strInstructions}')
                        ],
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.deepOrange[900]),
            );
          },
        ),
      ),
    );
  }

  Future<void> launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
    }
  }
}
