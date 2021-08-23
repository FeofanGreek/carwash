import 'package:carwash/profile/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';
import 'ordermain.dart';

bool _edit = true;
List jobs =[{'name' : 'wash', 'price' : 100, 'discount' : 0.1, 'description' : 'bla bla bla bla', 'type' : 'Детейлинг', 'subType' : 'Комплекс', 'select' : false},
  {'name' : 'wash 1', 'price' : 700.0, 'discount' : 0.2, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Комплекс', 'select' : false},
  {'name' : 'wash 2', 'price' : 800.0, 'discount' : 0.5, 'description' : 'bla bla bla bla', 'type' : 'Детейлинг', 'subType' : 'Услуга', 'select' : false},
  {'name' : 'wash 3', 'price' : 600.0, 'discount' : 0.0, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Услуга', 'select' : false}];

List types = [];
List subTypes = [];
bool showChips = false;
String typeSelected = '', subTypeSelected = '';
bool searchSwitch = false;

class jobSelect extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<jobSelect> {

  buildChips(){
    types.clear();
    subTypes.clear();
    for(int i = 0; i < jobs.length; i++){
      types.add(jobs[i]['type']);
      subTypes.add(jobs[i]['subType']);
    }
    print(types);
    types.sort();
    subTypes.sort();
    for(int i= 0; i < types.length; i++){
      i > 0 && types[i] == types[i -1] ? types.removeAt(i) : null;
    }
    for(int i= 0; i < subTypes.length; i++){
      i > 0 && subTypes[i] == subTypes[i -1] ? subTypes.removeAt(i) : null;
    }
    showChips = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    buildChips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 1,
          centerTitle: !searchSwitch,
          iconTheme: IconThemeData(
              size:22, color: button
          ),
          automaticallyImplyLeading: !searchSwitch,
          /*leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => orderMain(),
                  ),
                );

              }, child: Icon(CupertinoIcons.chevron_back, size:22, color: button)),*/
          title: searchSwitch == false ?
              Text('Список работ', style: boldText)
              : Container(
              margin: const EdgeInsets.fromLTRB(0,0,0,0),
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              /*decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),*/
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 32,
              child:TextFormField(
                textAlignVertical: TextAlignVertical.top,
                //onTap: _requestFocus3,
                //focusNode: myFocusNode3,
                textAlign: TextAlign.left,
                enabled: true,
                style: nameSubTitleDark,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search,  color: Color(0xFF4F4F4F)),
                  hintText: 'Поиск',
                  hintStyle: nameSubTitleDark,
                  fillColor: superLightGrey,
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                      left: 8,
                      top: 0,
                      bottom: 10
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (_){},
                autovalidateMode: AutovalidateMode.always,
                //controller: _controllerName,
              )),
          actions: [
            searchSwitch == false ? GestureDetector(
              onTap: () {
                setState(() {
                  searchSwitch = !searchSwitch;
                });

              }, child: Container(
                height: 40,
                width: 50,
                color:Colors.white,
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0,0,15,0),
                child: Icon(CupertinoIcons.search, size:22, color: button)),) : GestureDetector(
              onTap: () {
                setState(() {
                  searchSwitch = !searchSwitch;
                });

              }, child: Container(
                height: 40,
                width: 80,
                color:Colors.white,
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0,0,15,0),
                child: Text('Отмена', style: blueText )),),
          ]
      ),
      body: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: greyBackGround,
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Тип', style: nameSubTitle ),
                              Spacer(),

                            ])
                    )),
                showChips == true ? Container(
                    width: MediaQuery.of(context).size.width,
                    color: greyBackGround,
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(onTap:(){
                            setState(() {
                              typeSelected = types[index];
                            });
                          }, child:Container(
                              width: 120,
                              height: 30,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(10,0,0,0),
                              padding: const EdgeInsets.fromLTRB(10,0,10,0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                                color: typeSelected == types[index] ? filterButtonSelected : filterButton,
                              ),
                              child: Text('${types[index]}', style: typeSelected == types[index] ? filterButtonSelectedText : filterButtonText )

                          ));})) : Container(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: greyBackGround,
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Вид', style: nameSubTitle ),
                              Spacer(),

                            ])
                    )),
                showChips == true ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color: greyBackGround,
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subTypes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(onTap:(){
                            setState(() {
                              subTypeSelected = subTypes[index];
                            });
                          }, child:Container(
                              width: 120,
                              height: 30,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(10,0,0,0),
                              padding: const EdgeInsets.fromLTRB(10,0,10,0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                                color: subTypeSelected == subTypes[index] ? filterButtonSelected : filterButton,
                              ),
                              child: Text('${subTypes[index]}', style: subTypeSelected == subTypes[index] ? filterButtonSelectedText : filterButtonText )

                          ));})) : Container(),
        Container(
            margin: const EdgeInsets.fromLTRB(0,0,0,0),
            color: greyBackGround,
            height: 37,
            alignment: Alignment.centerLeft,),

                SizedBox(height: 30,),


                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Container(
                    color: Color(0xFFFFFFFF),
                    child:Container(
                      color: Color(0xFFFFFFFF),
                      margin: const EdgeInsets.fromLTRB(20,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap:(){
                      setState(() {
                        jobs[index]['select'] = !jobs[index]['select'];
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0,0,0,0),
                        color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Container(
                            margin: const EdgeInsets.fromLTRB(20,0,20,0),
                            height: 37,
                            alignment: Alignment.centerLeft,
                            child:Row(
                                children: [
                                  Text(jobs[index]['name'], style: nameSubTitleDark),
                                  Spacer(),
                                  Text('${jobs[index]['price'].toString()}₽', style: nameSubTitle ),
                                  jobs[index]['select'] == true ? Icon(CupertinoIcons.checkmark, size:22, color: Color(0xFF32D74B)) : Container(width: 22,),
                                ])
                        )),
                  ),
                ),



              ]),
        ),
      ),
    );
  }

}
