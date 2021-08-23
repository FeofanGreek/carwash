import 'package:carwash/profile/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../styles.dart';

bool _edit = true;
bool addNumber = false;
bool enterCode = false;

class phoneEdit extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<phoneEdit> {
  TextEditingController _controllerPhone = TextEditingController(text: phone);
  var maskFormatterPhone = MaskTextInputFormatter(mask: '+7 ### ### ## ##', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterCode = MaskTextInputFormatter(mask: '# # # # #', filter: { "#": RegExp(r'[0-9]') });

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
          title: Text('Номер телефона', style: boldText),
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
                SizedBox(height: 22,),
                Container(
                  margin: const EdgeInsets.fromLTRB(30,0,0,10),
                  alignment: Alignment.centerLeft,
                  child: Text('Телефон', style: taskTitle ),
                ),
                !addNumber ? GestureDetector(
                  onTap: () {
                    setState(() {
                      addNumber = !addNumber;
                    });
                  }, child:Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,10,0),
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
                ),) :
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
                          child:Text('Номер телефона', style: nameSubTitle ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 170,
                            height: 37,
                            child:TextFormField(
                              inputFormatters: [maskFormatterPhone],
                              keyboardType: TextInputType.phone,
                              readOnly: _edit,
                              textAlignVertical: TextAlignVertical.top,
                              //onTap: _requestFocus3,
                              //focusNode: myFocusNode3,
                              textAlign: TextAlign.left,
                              enabled: true,
                              style: nameSubTitleDark,
                              decoration: InputDecoration(
                                hintText: '+7 ___ ___ __ __',
                                hintStyle: nameSubTitle,
                                contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    top: 0,
                                    bottom: 10
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (_){
                                setState(() {
                                  phone = _controllerPhone.text;
                                });
                              },
                              autovalidateMode: AutovalidateMode.always,
                              controller: _controllerPhone,
                            )),
                      ]),
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                SizedBox(height: 22,),
                addNumber && enterCode ? Container(
                  margin: const EdgeInsets.fromLTRB(30,0,0,10),
                  alignment: Alignment.centerLeft,
                  child: Text('Введите полученый код', style: taskTitle ),
                ) : Container(),
                addNumber && enterCode ? Container(
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
                          child:Text('Код', style: nameSubTitle ),
                        ),
                        Spacer(),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0,0,0,0),
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            alignment: Alignment.centerRight,
                            width: 70,
                            height: 37,
                            child:TextFormField(
                              inputFormatters: [maskFormatterCode],
                              keyboardType: TextInputType.number,
                              //readOnly: _edit,
                              textAlignVertical: TextAlignVertical.top,
                              //onTap: _requestFocus3,
                              //focusNode: myFocusNode3,
                              textAlign: TextAlign.left,
                              enabled: true,
                              style: nameSubTitleDark,
                              decoration: InputDecoration(
                                hintText: '_ _ _ _',
                                hintStyle: nameSubTitle,
                                contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    top: 0,
                                    bottom: 10
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (_){},
                              autovalidateMode: AutovalidateMode.always,
                              //controller: _controllerPhone,
                            )),
                      ]),
                ) : Container(),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
              ]),
        ),
      ),
      bottomNavigationBar: !enterCode ? Container(
        margin: const EdgeInsets.fromLTRB(20,0,20,30),
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        height: 48,
        width: MediaQuery.of(context).size.width - 40,
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed:(){
            setState(() {
              enterCode = !enterCode;
            });
          } ,
          child: Text('Получить код', style: buttonText,textAlign: TextAlign.center,),
          style: ElevatedButton.styleFrom(
            primary: button,
            minimumSize: Size(MediaQuery.of(context).size.width - 40, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      ) : Container(
        margin: const EdgeInsets.fromLTRB(20,0,20,30),
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        height: 48,
        width: MediaQuery.of(context).size.width - 40,
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed:(){
            setState(() {
              enterCode = !enterCode;
              addNumber = !addNumber;
            });
          } ,
          child: Text('Подтвердить', style: buttonText,textAlign: TextAlign.center,),
          style: ElevatedButton.styleFrom(
            primary: button,
            minimumSize: Size(MediaQuery.of(context).size.width - 40, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      ),
    );
  }

}
