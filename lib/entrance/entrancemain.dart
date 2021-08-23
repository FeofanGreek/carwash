import 'package:carwash/profile/profilemain.dart';
import 'package:carwash/table/tablemain.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

class entranceMain extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<entranceMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ?
                  SizedBox(height: 80,) : Container(),
              /*Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0,50,0,50),
                  child: Text('LOGO', style: bigLogo,textAlign: TextAlign.center,)
              ),*/
              Container(
                height: 150, width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/logo.png"),
                      fit:BoxFit.fitHeight, alignment: Alignment(0.0, 0.0)
                  ),
                ),),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0,20,0,20),
                  child: Text('Вход', style: boldText,textAlign: TextAlign.center,)
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20,0,20,0),
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                alignment: Alignment.center,
                child:Divider(height: 1,thickness: 2,color: grey,),
              ),
              Row(
                  children:[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20,0,0,0),
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      alignment: Alignment.centerLeft,
                      height: 54,
                      child:Text('E-mail'),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0,0,0,0),
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 54,
                        child:TextFormField(
                          //onTap: _requestFocus3,
                          //focusNode: myFocusNode3,
                          textAlign: TextAlign.left,
                          enabled: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 15,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (_){setState(() { });},
                          autovalidateMode: AutovalidateMode.disabled,
                          //controller: _controllerFIO,
                        )),
                  ]),
              Container(
                margin: const EdgeInsets.fromLTRB(20,0,20,0),
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                alignment: Alignment.center,
                child:Divider(height: 1,thickness: 2,color: grey,),
              ),
              Row(
                  children:[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20,0,0,0),
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      alignment: Alignment.centerLeft,
                      height: 54,
                      child:Text('Пароль'),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0,0,0,0),
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 54,
                        child:TextFormField(
                          obscureText: true,
                          //onTap: _requestFocus3,
                          //focusNode: myFocusNode3,
                          textAlign: TextAlign.left,
                          enabled: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 15,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (_){setState(() { });},
                          autovalidateMode: AutovalidateMode.disabled,
                          //controller: _controllerFIO,
                        )),
                  ]),
              Container(
                margin: const EdgeInsets.fromLTRB(20,0,20,0),
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                alignment: Alignment.center,
                child:Divider(height: 1,thickness: 2,color: grey,),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20,50,20,0),
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                height: 48,
                width: MediaQuery.of(context).size.width - 40,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed:(){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => freeSize(),
                      ),
                    );
                  } ,
                  child: Text('Войти', style: buttonText,textAlign: TextAlign.center,),
                  style: ElevatedButton.styleFrom(
                    primary: button,
                    minimumSize: Size(MediaQuery.of(context).size.width - 40, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20,10,20,0),
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                alignment: Alignment.centerRight,
                child:Text('Я забыл пароль', style: TextStyle(decoration: TextDecoration.underline)),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20,60,20,20),
                  alignment: Alignment.center,
                  child:RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: 'Новый пользователь? ',
                      style:  TextStyle(fontSize: 13,fontFamily: 'Roboto', color: Color(0xFF000000)),
                      children: <TextSpan>[
                        TextSpan(text: 'Создать аккаунт', style: TextStyle(decoration: TextDecoration.underline)),
                      ]),
                  )
              ),
            ]),
      ),
      ),
    );
  }
}
