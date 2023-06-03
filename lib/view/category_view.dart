import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsi/view/list_meals_view.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});
  final String apiUrl =
      "https://www.themealdb.com/api/json/v1/1/categories.php";

  Future<List<dynamic>> _fetchCategory() async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data['categories'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category of Meals'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            child: FutureBuilder<List<dynamic>>(
              future: _fetchCategory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Jumlah kolom dalam grid
                      childAspectRatio:
                          1, // Rasio lebar-tinggi untuk setiap item grid
                      mainAxisSpacing: 1, // Jarak antara item pada sumbu utama
                      crossAxisSpacing:
                          1, // Jarak antara item pada sumbu silang
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ListMealsView(
                                    category: snapshot.data[index]
                                        ['strCategory'],
                                  )),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.green[50],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    snapshot.data[index]['strCategoryThumb']),
                                Text(
                                  snapshot.data[index]['strCategory'],
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: ((context) => ListMealsView(
//                                         category: snapshot.data[index]
//                                             ['strCategory'],
//                                       ))));
//                         },
//                         child: Card(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 18, vertical: 5),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               child: ListTile(
//                                 leading: Image.network(
//                                     snapshot.data[index]['strCategoryThumb']),
//                                 title:
//                                     Text(snapshot.data[index]['strCategory']),
//                               ),
//                             )),
//                       );
//                     });