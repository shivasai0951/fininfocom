import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/profileModel.dart';
import '../utilities/screensize.dart';
import '../utilities/urls.dart';

class profileActivity extends StatefulWidget {
  const profileActivity({Key? key}) : super(key: key);

  @override
  State<profileActivity> createState() => _profileActivityState();
}

class _profileActivityState extends State<profileActivity> {


  late Future<profileModel> getprofileObj;

  Urls urls= Urls();


  Future<profileModel> getprofileApiFunction() async {
    final response = await http
        .get(Uri.parse('${urls.profileBaseurl}${urls.profileEndpoint}'));

    if (response.statusCode == 200) {
      return profileModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }


  @override
  void initState() {
    getprofileObj = getprofileApiFunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final daysPassed = DateTime.now().difference(registrationDate).inDays;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: FutureBuilder<profileModel>(
          future: getprofileObj,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return   Column(
                children: [
                  const SizedBox(height: 20,),
                  SizedBox(
                    
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: snapshot.data!.results![0].picture!.large!.isNotEmpty ? NetworkImage(snapshot.data!.results![0].picture!.large.toString()) : null,
                      backgroundColor: Colors.blue,

                    ),
                  ),
                  const SizedBox(height: 10,),

                  ///Name
                  Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),child:   SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      children: [
                        SizedBox(width: SizeConfig.screenWidth/3,child: const Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                        SizedBox(width: SizeConfig.screenWidth/1.8,child: Text("${snapshot.data!.results![0].name!.first} ${snapshot.data!.results![0].name!.last}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),

                      ],
                    ),
                  ),),
                  const SizedBox(height: 10,),

                  ///location
                  Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),child:   SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      children: [
                        SizedBox(width: SizeConfig.screenWidth/3,child: const Text("Location",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                        SizedBox(width: SizeConfig.screenWidth/1.8,child: Text("${snapshot.data!.results![0].location!.city} ${snapshot.data!.results![0].location!.state} ${snapshot.data!.results![0].location!.country} ${snapshot.data!.results![0].location!.postcode}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),

                      ],
                    ),
                  ),),
                  const SizedBox(height: 10,),

                  ///email
                  Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),child:   SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      children: [
                        SizedBox(width: SizeConfig.screenWidth/3,child: const Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                        SizedBox(width: SizeConfig.screenWidth/1.8,child: Text("${snapshot.data!.results![0].email}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),

                      ],
                    ),
                  ),),
                  const SizedBox(height: 10,),

                  ///dob
                  Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),child:   SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      children: [
                        SizedBox(width: SizeConfig.screenWidth/3,child: const Text("Dob",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                        SizedBox(width: SizeConfig.screenWidth/1.8,child: Text("${extractDate(snapshot.data!.results![0].dob!.date.toString())} / ${snapshot.data!.results![0].dob!.age.toString() } years old",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),

                      ],
                    ),
                  ),),
                  const SizedBox(height: 10,),

                  ///number of days present since register
                  Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),child:   SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Row(
                      children: [
                        SizedBox(width: SizeConfig.screenWidth/3,child: const Text("Number of days passed since registered",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                        SizedBox(width: SizeConfig.screenWidth/1.8,child: Text("${calculateDaysDifference(snapshot.data!.results![0].registered!.date.toString())} days",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
                      ],
                    ),
                  ),),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(

              child: SizedBox(
                height: 25,width: 25,
                child:  CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  ///extracting date

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String date = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return date;
  }


  ///giving date as a string and return the count in days

  String calculateDaysDifference(String dateString) {
    DateTime givenDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now();

    // Calculate the difference in days
    Duration difference = currentDate.difference(givenDate);
    int differenceInDays = difference.inDays;

    // Convert the difference to a string
    String result = differenceInDays.toString();

    return result;
  }
}
