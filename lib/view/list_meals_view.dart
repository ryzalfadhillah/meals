// import 'package:belajarhttp/view/detail_food_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsi/view/detail_meal_view.dart';

class ListMealsView extends StatelessWidget {
  ListMealsView({super.key, required this.category});

  final String category;

  Future<List<dynamic>> _fetchMeals() async {
    var url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data['meals'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Meals from " + category),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fetchMeals(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DetailMealView(
                                      idMeal: snapshot.data[index]['idMeal'],
                                      nameMeal: snapshot.data[index]['strMeal'],
                                    ))));
                      },
                      child: Card(
                          color: Colors.green[50],
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: Image.network(
                                  snapshot.data[index]['strMealThumb']),
                              title: Text(snapshot.data[index]['strMeal']),
                            ),
                          )),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ));
  }
}
