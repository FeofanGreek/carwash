import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'entrance/entrancemain.dart';
import 'main.dart';



class launchScreen extends StatefulWidget {
  @override
  launchScreenState createState() => launchScreenState();
}

class launchScreenState extends State<launchScreen> {

  check(){
    /*try{
      http.post(Uri.parse('https://koldashev.ru/check.php')).then((result)async{
        print(result.body);
        if(result.body == '1'){
            const twentyMillis = const Duration(seconds:5);
            new Timer(twentyMillis, () => Navigator.pushReplacement (context,
                MaterialPageRoute(builder: (context) => MyHomePage())));
        }});
    }catch(e){

    }*/
    const twentyMillis = const Duration(seconds:5);
    new Timer(twentyMillis, () => Navigator.pushReplacement (context,
        MaterialPageRoute(builder: (context) => entranceMain())));
  }

  @override
  void initState() {
    super.initState();
    check();
  }//initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body:Container(
        height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:/*Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[*/
                      Container(
                        height: 200, width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/logoBig.png"),
                              fit:BoxFit.fitWidth, alignment: Alignment(0.0, 0.0)
                          ),
                        ),),
                     /* SizedBox(height: 20),
                      Text('Федеральное государственное бюджетное образовательное учреждение высшего образования\n«Российский экономический университет\nимени Г.В. Плеханова»', style: TextStyle(fontSize: 14, color: Colors.white),textAlign: TextAlign.center,),
                      SizedBox(height: 50),
                      Text('Мои «зеленые» налоги', style: TextStyle(fontSize: 25, color: Colors.white)),
                      SizedBox(height: 10),
                      Text('Год создания: 2021', style: TextStyle(fontSize: 14, color: Colors.white),textAlign: TextAlign.center,)

                    ]),*/
              )

            ]),
      ),

    );
  }

}
