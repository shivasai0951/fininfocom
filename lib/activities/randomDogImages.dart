import 'dart:convert';

import 'package:fininfocom/Models/randomDogImageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utilities/screensize.dart';
import '../utilities/urls.dart';
import '../utilities/urls.dart';
import 'drawer.dart';

class randomDogImageActivity extends StatefulWidget {
  const randomDogImageActivity({Key? key}) : super(key: key);

  @override
  State<randomDogImageActivity> createState() => _randomDogImageActivityState();
}

class _randomDogImageActivityState extends State<randomDogImageActivity> {

  late Future<dogimageModel> getDogsImageObj;

  Urls urls= Urls();


  Future<dogimageModel> getDogsImageApiFunction() async {
    final response = await http
        .get(Uri.parse('${urls.dogBaseurl}${urls.dogsEndpoint}'));

    if (response.statusCode == 200) {
      return dogimageModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }


  @override
  void initState() {
    getDogsImageObj = getDogsImageApiFunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      drawer:  const drawerService(),
      body: SizedBox(

          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
       child: Center(
     child: Card(
         elevation: 50,
         shadowColor: Colors.black,
         color: Colors.grey[300],
         child: SizedBox(
           width: SizeConfig.screenWidth/1.2,
           height: SizeConfig.screenHeight/1.8,
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               children: [
                 SizedBox(
                   height: SizeConfig.screenHeight/3,
                   child: FutureBuilder<dogimageModel>(
                     future: getDogsImageObj,
                     builder: (context, snapshot) {
                       if (snapshot.hasData) {
                         return Image.network(snapshot.data!.message.toString());
                       } else if (snapshot.hasError) {
                         return Text('${snapshot.error}');
                       }

                       // By default, show a loading spinner.
                       return const CircularProgressIndicator();
                     },
                   ),
                 ),
                 const SizedBox(
                   height: 10,
                 ), //SizedBox
                 SizedBox(
                   width: 100,

                   child: ElevatedButton(
                     onPressed: () {
                       setState(() {
                         getDogsImageObj = getDogsImageApiFunction();
                       });
                     },
                     style: ButtonStyle(
                         backgroundColor:
                         MaterialStateProperty.all(Colors.blue)),
                     child: const Padding(
                       padding: EdgeInsets.all(4),
                       child: Text('Refresh')
                     ),
                   ),)],),),),),)

      ),
    );
  }
}
