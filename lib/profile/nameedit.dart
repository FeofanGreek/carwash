import 'package:carwash/profile/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

bool _edit = true;

class nameEdit extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<nameEdit> {
  TextEditingController _controllerName = TextEditingController(text: name);
  TextEditingController _controllerSyrname = TextEditingController(text: syrname);
  TextEditingController _controllerPatronym = TextEditingController(text: patronym);

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
          title: Text('Имя пользователя', style: boldText),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _edit = !_edit;
                });

              }, child: Container(
                height: 40,
                width: 50,
                color:Colors.white,
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0,0,15,0),
                child: Text('${!_edit ? 'Сохр.' : 'Ред.' }', style: blueText )),),
          ]
      ),
      body: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 37,),
                Container(
                  margin: const EdgeInsets.fromLTRB(0,0,0,0),
                  color: Color(0xFFFFFFFF),
                  height: 37,
                  alignment: Alignment.centerLeft,
                  child:Row(
                      children:[
                        Container(
                          margin: const EdgeInsets.fromLTRB(20,0,0,0),
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          alignment: Alignment.centerLeft,
                          height: 37,
                          width: 150,
                          child:Text('Имя', style: nameSubTitle ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 170,
                            height: 37,
                            child:TextFormField(
                              readOnly: _edit,
                              textAlignVertical: TextAlignVertical.top,
                              //onTap: _requestFocus3,
                              //focusNode: myFocusNode3,
                              textAlign: TextAlign.left,
                              enabled: true,
                              style: nameSubTitleDark,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    top: 0,
                                    bottom: 10
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (_){
                                setState(() {
                                name = _controllerName.text;
                              });
                              },
                              autovalidateMode: AutovalidateMode.always,
                              controller: _controllerName,
                            )),
                      ]),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                Container(
                  margin: const EdgeInsets.fromLTRB(0,0,0,0),
                  color: Color(0xFFFFFFFF),
                  height: 37,
                  alignment: Alignment.centerLeft,
                  child:Row(
                      children:[
                        Container(
                          margin: const EdgeInsets.fromLTRB(20,0,0,0),
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          alignment: Alignment.centerLeft,
                          height: 37,
                          width: 150,
                          child:Text('Отчество', style: nameSubTitle ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 170,
                            height: 37,
                            child:TextFormField(
                              readOnly: _edit,
                              textAlignVertical: TextAlignVertical.top,
                              //onTap: _requestFocus3,
                              //focusNode: myFocusNode3,
                              textAlign: TextAlign.left,
                              enabled: true,
                              style: nameSubTitleDark,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    top: 0,
                                    bottom: 10
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (_){
                                setState(() {
                                patronym = _controllerPatronym.text;
                              });},
                              autovalidateMode: AutovalidateMode.always,
                              controller: _controllerPatronym,
                            )),
                      ]),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                Container(
                  margin: const EdgeInsets.fromLTRB(0,0,0,0),
                  color: Color(0xFFFFFFFF),
                  height: 37,
                  alignment: Alignment.centerLeft,
                  child:Row(
                      children:[
                        Container(
                          margin: const EdgeInsets.fromLTRB(20,0,0,0),
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          alignment: Alignment.centerLeft,
                          height: 37,
                          width: 150,
                          child:Text('Фамилия', style: nameSubTitle ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 170,
                            height: 37,
                            child:TextFormField(
                              readOnly: _edit,
                              textAlignVertical: TextAlignVertical.top,
                              //onTap: _requestFocus3,
                              //focusNode: myFocusNode3,
                              textAlign: TextAlign.left,
                              enabled: true,
                              style: nameSubTitleDark,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    top: 0,
                                    bottom: 10
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (_){
                                setState(() {
                                syrname = _controllerSyrname.text;
                              });
                                },
                              autovalidateMode: AutovalidateMode.always,
                              controller: _controllerSyrname,
                            )),
                      ]),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
              ]),
        ),
      ),
    );
  }

}
