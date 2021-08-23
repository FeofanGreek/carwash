import 'package:carwash/profile/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';
import 'ordermain.dart';

bool _edit = true;

class carNumEdit extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<carNumEdit> {
  TextEditingController _controllerNumber = TextEditingController(text: carNumber);
  TextEditingController _controllerRegion = TextEditingController(text: carRegion);

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
          /*automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => orderMain(),
                  ),
                );

              }, child: Icon(CupertinoIcons.chevron_back, size:22, color: button)),*/
          title: Text('Номер ТС', style: boldText),
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
                          child:Text('Номер', style: nameSubTitle ),
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
                                  carNumber = _controllerNumber.text.toUpperCase();
                                });
                              },

                              autovalidateMode: AutovalidateMode.always,
                              controller: _controllerNumber,
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
                          child:Text('Регион', style: nameSubTitle ),
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
                                  carRegion = _controllerRegion.text;
                                });},
                              autovalidateMode: AutovalidateMode.always,
                              controller: _controllerRegion,
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
