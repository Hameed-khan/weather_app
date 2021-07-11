import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
void main()=>runApp(MaterialApp(

  home: WeatherApp(),
  theme: ThemeData(
  ),

)
);
class WeatherApp extends StatefulWidget {

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  TextEditingController placeName = TextEditingController();
  //get final temperature
  //i.e getTemp = (temp - 272.2);
  double getTemp,
      getTempday1,
      getTempday2,
      getTempday3,
      getTempday4,
      getTempday5;
  // get actually temp
  var temp,
      temp1days,
      temp2days,
      temp3days,
      temp4days,
      temp5days,
      result,
      icon,
      humidity;
  // take image icon (weatherIconImage)
  String cityName,
      description= "0",
      value  = "0",
      weatherIconImage="clear",
      weatherIconImageDay1="cloud",
      weatherIconImageDay2="cold",
      weatherIconImageDay3="ice",
      weatherIconImageDay4="mostly suuny",
      weatherIconImageDay5="showers",
  //final result store in here
      resultday1="0",
      resultday2="0",
      resultday3="0",
      resultday4="0",
      resultday5="0",
  // description store in these variables
      descriptionDay1= "0",
      descriptionDay2= "0",
      descriptionDay3= "0",
      descriptionDay4= "0",
      descriptionDay5= "0";
  // this function i used for get temperature data
  Future getWeather(String cN) async
  {
    // par return city name
    cityName = cN;
    // this link return day by day temp
    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=b4e7fd649feaf293c2245042ba503de1"
    ));
    // this link is used for 5days weather
    http.Response response5days = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/forecast?q=${cityName}&appid=77f97e0464598ea4124dd435b24561f9"));
    result = jsonDecode(response.body);
    var result5days = jsonDecode(response5days.body);
    setState(() {
      // Main weather of every day
      this.temp = result['main']['temp'];
      this.description= result['weather'][0]['description'];
      icon = result ['weather'][0]['icon'];
      humidity = result['main']['humidity'];
      getTemp = ((temp - 272.5));
      value = (getTemp.toStringAsFixed(0)).toString();
      // Weather day by day is ended
      // Weather of Day1
      this.temp1days = result5days['list'][0]['main']['temp'];
      getTempday1 = (temp1days - 272.5);
      resultday1 = (getTempday1.toStringAsFixed(0)).toString();
      descriptionDay1 = result5days['list'][0]['weather'][0]['description'];
      weatherIconImageDay1 = result5days['list'][0]['weather'][0]['icon'];
      // Weather of Day1 ended
      // Weather of Day2
      this.temp2days = result5days['list'][1]['main']['temp'];
      getTempday2 = (temp2days - 272.5);
      resultday2 = (getTempday2.toStringAsFixed(0)).toString();
      descriptionDay2 = result5days['list'][1]['weather'][0]['description'];
      weatherIconImageDay2 = result5days['list'][1]['weather'][0]['icon'];
      // Weather of 2nd Day ended
      // Weather of 3th Day
      this.temp3days = result5days['list'][2]['main']['temp'];
      getTempday3 = (temp3days - 272.5);
      resultday3 = (getTempday3.toStringAsFixed(0)).toString();
      descriptionDay3 = result5days['list'][2]['weather'][0]['description'];
      weatherIconImageDay3 = result5days['list'][2]['weather'][0]['icon'];
      // Weather of 3rd Day Ended
      // Weather of 3th Day
      this.temp4days = result5days['list'][3]['main']['temp'];
      getTempday4 = (temp4days - 272.5);
      resultday4 = (getTempday4.toStringAsFixed(0)).toString();
      descriptionDay4 = result5days['list'][3]['weather'][0]['description'];
      weatherIconImageDay4 = result5days['list'][3]['weather'][0]['icon'];
      // Weather of 4th Day
      this.temp5days = result5days['list'][3]['main']['temp'];
      getTempday5 = (temp5days - 272.5);
      resultday5 = (getTempday5.toStringAsFixed(0)).toString();
      descriptionDay5 = result5days['list'][4]['weather'][0]['description'];
      weatherIconImageDay5 = result5days['list'][4]['weather'][0]['icon'];
    });
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
          extendBodyBehindAppBar: true,

          body:SingleChildScrollView(
            child: Stack(
              children: [

                Container(
                  width: 400,
                  height: 220,
                  color: Colors.blue,
                ),
                // this is background which i used behind the days temp
                Image.asset("images/Chitral.png",
                  fit: BoxFit.cover,
                  height: 220,),
                // this image wave type
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,142,0,0),
                  child: SvgPicture.asset("images/wavesNegative.svg",color: Colors.grey[50],),
                ),
                // day of weather
                Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey[200],
                  margin: EdgeInsets.fromLTRB(30,185,0,0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,35,0,0),
                        child: Column(
                          children: [
                            Text("$value\u00B0C",style: TextStyle(fontSize: 50.0,color: Colors.grey[500]),),
                            Text("$description",style:TextStyle(fontSize: 20),),
                            Text("Humidity $humidity%",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w100)),
                          ],
                        ),
                      ),
                      Expanded(child: Container(height:110,margin:EdgeInsets.fromLTRB(10,0,0,0),child:(weatherIconImage == "clear")?Image(image:AssetImage("weatherIconImage/showers.png")):
                      Image.network('http://openweathermap.org/img/w/${icon}.png',fit: BoxFit.fitHeight),)),
                    ],
                  ),
                ),
                // 5days weather start from here
                Padding(
                  padding: const EdgeInsets.fromLTRB(90,350,0,0),
                  child: Container(
                    child:Text("Next 5Days Weather",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300
                    ),),
                  ),
                ),

                Container(
                  margin:EdgeInsets.fromLTRB(5,380,0,0),
                  height: 180.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      // Day 1
                      Container(
                        width: 140.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey[100],width: 5)
                        ),
                        child: new Stack(
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                  Expanded(
                                      child:(weatherIconImageDay1 == "cloud")?Image(image:AssetImage("weatherIconImage/cloud.png")):Image.network('http://openweathermap.org/img/w/${weatherIconImageDay1}.png',fit: BoxFit.cover,height: 100,),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text("$resultday1\u00b0C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w100),),
                                  ),

                                  Text(descriptionDay1,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w100),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //Day 2
                      Container(
                        width: 140.0,
                        margin: EdgeInsets.fromLTRB(4,0,0,0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey[100],width: 4)
                        ),
                        child: new Stack(
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: [

                                   Expanded(
                                      child:(weatherIconImageDay2 == "cold")?Image(image:AssetImage("weatherIconImage/cold.png")):Image.network('http://openweathermap.org/img/w/${weatherIconImageDay2}.png',fit: BoxFit.cover,height: 100,),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text("$resultday2\u00b0C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w100),),
                                  ),

                                  Text(descriptionDay2,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w100),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // Day3
                      Container(
                        width: 140.0,
                        margin: EdgeInsets.fromLTRB(4,0,0,0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey[100],width: 4)
                        ),
                        child: new Stack(
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                 Expanded(
                                      child:(weatherIconImageDay3 == "ice")?Image(image:AssetImage("weatherIconImage/ice.png")):Image.network('http://openweathermap.org/img/w/${weatherIconImageDay3}.png',fit: BoxFit.cover,height: 100,),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text("$resultday3\u00b0C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w100),),
                                  ),
                                  Text(descriptionDay3,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w100),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // Day 4
                      Container(
                        width: 140.0,
                        margin: EdgeInsets.fromLTRB(4,0,0,0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey[100],width: 4)
                        ),
                        child: new Stack(
                          children: <Widget>[

                            Center(
                              child: Column(
                                children: [
                                   Expanded(
                                      child:(weatherIconImageDay4 == "mostly suuny")?Image(image:AssetImage("weatherIconImage/mostly suuny.png")):
                                      Image.network('http://openweathermap.org/img/w/${weatherIconImageDay4}.png',fit: BoxFit.cover,height: 100,),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text("$resultday4\u00b0C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w100),),
                                  ),
                                  Text(descriptionDay4,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w100),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //Day5
                      Container(
                        width: 140.0,
                        margin: EdgeInsets.fromLTRB(4,0,0,0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey[100],width: 4)
                        ),
                        child: new Stack(
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                   Expanded(
                                      child:(weatherIconImageDay5 == "showers")?Image(image:AssetImage("weatherIconImage/showers.png")):Image.network('http://openweathermap.org/img/w/${weatherIconImageDay5}.png',fit: BoxFit.cover,height: 100,),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text("$resultday5\u00b0C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w100),),
                                  ),

                                  Text(descriptionDay5,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w100),),],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(19,580,0,0),
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        height: 80,

                        child: TextField(
                          controller: placeName,
                          decoration: InputDecoration(
                              hintText: "Enter name City name",
                              labelText: "City Name",
                              border: OutlineInputBorder(
                              ),
                              fillColor: Colors.red
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,30),
                        child: RawMaterialButton(onPressed: (){

                          getWeather(placeName.text);
                          FocusScope.of(context).requestFocus(FocusNode());

                        },elevation: 2.0,fillColor: Colors.grey[200],child: Icon(
                          Icons.arrow_right,
                          size: 60.0,
                        ),

                          shape: CircleBorder(),),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      );
  }
}
