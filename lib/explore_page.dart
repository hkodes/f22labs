import 'dart:convert';
import 'package:flutter/material.dart';
import 'model/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int index = 0;
  List<ImageModel> images = [];
  late Future<List<ImageModel>> futureData;

  void initState() {
    super.initState();
    fetchData();
    futureData = fetchData();
  }

  Future<List<ImageModel>> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ImageModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<ImageModel>>(
            initialData: [],
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ImageModel>? data = snapshot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    itemCount: data!.length,
                    itemBuilder: (context, index) => ImageCard(
                      imageData: data[index],
                    ),
                    staggeredTileBuilder: (index) => StaggeredTile.count(
                        (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                throw Exception('');
              }
            }));
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({required this.imageData});

  final ImageModel imageData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(imageData.url, fit: BoxFit.cover),
    );
  }
}
