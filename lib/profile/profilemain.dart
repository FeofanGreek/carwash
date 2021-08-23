import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';
import 'editphone.dart';
import 'nameedit.dart';
import 'notifedit.dart';

String name = ' ', patronym = ' ', syrname = '', phone = '+7 123 456-78-90';
List<String> languages = ['Русский', 'English', 'O\'zbek'];
String selectedLanguage = 'Русский';


class profileMain extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<profileMain> {

  @override
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 1,
          centerTitle: true,
          iconTheme: IconThemeData(
              size:22, color: button
          ),
          automaticallyImplyLeading: true,
          /*leading: GestureDetector(
              onTap: () {}, child: Icon(CupertinoIcons.chevron_back, size:22, color: button)),*/
          title: Text('Профиль', style: boldText),
          actions: []
      ),
      body: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ?
                SizedBox(height: 80,) : Container(),
                GestureDetector(
                  onTap:()=> makePhotoDialog(),
                  child:Container(
                      height: 72,
                      width: 72,
                      alignment: Alignment.center,
                      child: Stack(
                          children:[
                            Container(
                              height: 72,
                              width: 72,
                              alignment: Alignment.center,
                              child: SizedBox(
                                  width: 72,
                                  height: 72,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      //color: semiLightBlue,
                                      image: DecorationImage(
                                          image:  NetworkImage('https://yobte.ru/uploads/posts/2019-11/milashki-82-foto-15.jpg'),
                                          fit:BoxFit.fitHeight, alignment: Alignment(0.0, 0.0)
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Container(
                                height: 72,
                                width: 72,
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                    width: 27,
                                    height: 27,
                                    child: Container(
                                        height: 27,
                                        width: 27,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: button,
                                        ),
                                        //alignment: Alignment.topRight,
                                        child: Icon(Icons.add_a_photo_outlined , size:18, color: Color(0xFFFFFFFF)))
                                )
                            ),
                          ])
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10,12,0,0),
                  //height: 130,
                  alignment: Alignment.center,
                  child: Text('$syrname $name $patronym', style: nameTitle ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10,2,0,30),
                  //height: 130,
                  alignment: Alignment.center,
                  child: Text('pochta@yandex.ru', style: nameSubTitle ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30,0,0,10),
                  //height: 130,
                  alignment: Alignment.centerLeft,
                  child: Text('Контактная информация', style: taskTitle ),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nameEdit(),
                  ),
                ).then(onGoBack);

              }, child:Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(30,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Имя пользователя', style: nameSubTitle ),
                              Spacer(),
                              Text('$syrname ${name.substring(0,1)}.${patronym.substring(0,1)}.', style: nameSubTitleDark ),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => phoneEdit(),
                  ),
                ).then(onGoBack);

              }, child:Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(30,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Номер телефона', style: nameSubTitle ),
                              Spacer(),
                              Text(phone, style: nameSubTitleDark ),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(30,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Whatsapp', style: nameSubTitle ),
                              Spacer(),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(30,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Telegram', style: nameSubTitle ),
                              Spacer(),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),
          Container(
                  margin: const EdgeInsets.fromLTRB(30,20,0,10),
                  //height: 130,
                  alignment: Alignment.centerLeft,
                  child: Text('Уведомления', style: taskTitle ),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => notifEdit(),
                  ),
                ).then(onGoBack);

              }, child:Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(30,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Уведомления', style: nameSubTitle ),
                              Spacer(),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),
          ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30,20,0,10),
                  //height: 130,
                  alignment: Alignment.centerLeft,
                  child: Text('Язык', style: taskTitle ),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(30,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<String>(
                                    iconSize: 0.0,
                                    isExpanded: false,
                                    value: selectedLanguage,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedLanguage = newValue!;
                                      });
                                    },

                                    selectedItemBuilder: (BuildContext context) {
                                      return languages.map<Widget>((String item) {
                                        return Container(
                                            alignment: Alignment.centerLeft,
                                            width: 150,
                                            child: Text(item, style: nameSubTitleDark, textAlign: TextAlign.start)
                                        );
                                      }).toList();
                                    },
                                    items: languages.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: nameSubTitleDark, textAlign: TextAlign.left,),
                                      );
                                    }).toList(),
                                  )),
                              Spacer(),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),
              ]),
        ),
      ),
    );
  }

  makePhotoDialog(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0 , 0),
              insetPadding: EdgeInsets.all(0),
              elevation: 0.0,
              content:Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
          children:[
          Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 88,
                    margin: EdgeInsets.fromLTRB(20,20,20,20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(16.5),
                      color: Colors.grey[50],
                    ),
                    padding: EdgeInsets.fromLTRB(0,0,0,0),
                    child:  Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap:(){
                              Navigator.of(context).pop();
                            }, child:Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.center,
                            height: 43,
                            child: Text('Сделать фото', style: blueText ),
                          ),
                          ),
                          Divider(height: 1,thickness: 0.5,color: lightGrey,),
                          GestureDetector(
                            onTap:(){
                              Navigator.of(context).pop();
                            }, child:Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.center,
                            height: 43,
                            child: Text('Выбрать фото', style: blueText ),
                          ),
                          )
                        ])
                ),
            Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 45,
                margin: EdgeInsets.fromLTRB(20,0,20,20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(16.5),
                  color: Colors.grey[50],
                ),
                padding: EdgeInsets.fromLTRB(0,0,0,0),
                child:  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap:(){
                          Navigator.of(context).pop();
                        }, child:Container(
                        margin: const EdgeInsets.fromLTRB(0,0,0,0),
                        alignment: Alignment.center,
                        height: 43,
                        child: Text('Отмена', style: blueText ),
                      ),
                      )
                    ])
            ),
            ])
              )
          );
        });

  }


}
