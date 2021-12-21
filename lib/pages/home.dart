import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';



class Home extends StatefulWidget{
  Home({Key? key,required this.cityNAme}) : super(key: key);

  String cityNAme;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  TextEditingController controller = TextEditingController();

Future<Temperature?> showresoult() async {
  WeatherFactory wf = WeatherFactory("b26d45088003e815a9cb567ba5e0cf34",language:Language.HUNGARIAN);

  Weather w = await wf.currentWeatherByCityName(widget.cityNAme);

  return w.temperature;
}

  @override
  Widget build(BuildContext context) {


    return Scaffold(



      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(cityNAme: ''
      ),
      )
      );
      },
      child: Icon( Icons.refresh),
      ),
      appBar: AppBar(
        title: Text('Home screen'),
      ),


      body:

      SafeArea(child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kep.jpg')
          )
        ),



       child: Center(
        child:
        FutureBuilder(
          future: showresoult(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Ennyi fok van : ${snapshot.data}, ${widget.cityNAme} - n",)),
                ],
              );

            }
            else if (snapshot.hasError) {
              return Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text('Enter a city name: '),TextField(
                controller: controller,
              ),
                TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(cityNAme: controller.text,))), child: Text('submit'))
              ]);

            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],

            );
          }
        ),
      ),
      ),
    ),
    );
  }
}


