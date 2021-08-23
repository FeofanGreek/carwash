import 'dart:async';
import 'dart:convert';

import 'package:carwash/info/infomain.dart';
import 'package:carwash/order/automotivenum.dart';
import 'package:carwash/order/jobselect.dart';
import 'package:carwash/order/ordermain.dart';
import 'package:carwash/order/personcontact.dart';
import 'package:carwash/profile/profilemain.dart';
import 'package:carwash/speedorder/speedordermain.dart';
import 'package:carwash/table/tablemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../styles.dart';


//var _date = DateTime.now();
var _date = DateTime.parse('2021-08-11 06:00:00.000');
var _timeStart = DateTime.parse('2021-08-11 06:00:00.000');
var _timeEnd =  DateTime.parse('2021-08-11 23:59:00.000');
//var _timeStart = DateTime.now();
//var _timeEnd = DateTime.now();
int _postNum = 0;
int _maxPostCol = ordersBorn[0]['postCol'];
int _status = 0;
//List<String> carsTypes = ['Легковой', 'Внедорожник', 'Микроавтобус', 'Грузовик', 'Пикап', 'Коммерческий', 'Мотоцикл', 'Ковер'];
String carTypeSelected = 'Легковой';
//List<String> carsBrands = ['Мерседес', 'Газель', 'Тойота', 'Тесла', 'Ниссан', 'Хонда', 'Крайслер', 'Нива'];
String carBrandSelected = 'Газель';
//List<String> carsModels = ['W140', 'W210', 'W202', 'Vesta', 'X-Ray', 'Leaf', 'Spyker', '4x4'];
String carModelSelected = 'W140';
List<Color> _colors = [Color(0xFF4D4D4D),Color(0xFFFFFFFF),Color(0xFFC4C4C4),Color(0xFF0047FF),Color(0xFFD0D317),Color(0xFF860089),Color(0xFF069156),Color(0xFF5A0303),Color(0xFFE06622)];
Color selectedColor = Color(0xFF4D4D4D);
int selectedColorIndex = 0;
String carNumber ='', carRegion ='', personName ='', personSyrname ='', personPatronym ='', personPhone ='';
//List<String> staff = ['Петрова А.И.', 'Загоруйко А.А.', 'Сидоров Т.П.', 'Дегало В.В.', 'Чекотило Ф.Ф.'];
String staffSelected = 'Петрова А.И.';
List _showDec =[];
List _jobs = [];

class curentOrderInfo extends StatefulWidget {

  final int index;

  curentOrderInfo({
    required this.index
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<curentOrderInfo> {
  @override
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }



  @override
  void initState() {
    super.initState();

    _date = DateTime.parse(orders[0]['orderItems'][widget.index]['Start']);
    _timeStart = DateTime.parse(orders[0]['orderItems'][widget.index]['Start']);
    _timeEnd =  DateTime.parse(orders[0]['orderItems'][widget.index]['End']);
    _postNum = orders[0]['orderItems'][widget.index]['postNum'];
    _status = orders[0]['orderItems'][widget.index]['status'];
    selectedFlag = flags[_status];
    carTypeSelected = orders[0]['orderItems'][widget.index]['carTypeSelected'];
    carBrandSelected = orders[0]['orderItems'][widget.index]['carBrandSelected'];
    carModelSelected = orders[0]['orderItems'][widget.index]['carModelSelected'];
    selectedColor = _colors[orders[0]['orderItems'][widget.index]['selectedColor']];
    carNumber =orders[0]['orderItems'][widget.index]['carNumber'];
    carRegion =orders[0]['orderItems'][widget.index]['carRegion'];
    personName =orders[0]['orderItems'][widget.index]['personName'];
    personSyrname =orders[0]['orderItems'][widget.index]['personSyrname'];
    personPatronym =orders[0]['orderItems'][widget.index]['personPatronym'];
    personPhone =orders[0]['orderItems'][widget.index]['personPhone'];
    staffSelected = orders[0]['orderItems'][widget.index]['staffSelected'];

    for(int i = 0; i < orders[0]['orderItems'][widget.index]['jobds'].length; i++) {
      _jobs.add(orders[0]['orderItems'][widget.index]['jobds'][i]);
    }

      for (int i = 0; i < _jobs.length; i++) {
        _jobs[i]['select'] = true;
      }

    for(int i =0; i < _jobs.length; i++){
      _showDec.add(false);
    }

  }

  countBill(){
    List summ = [0.0,0.0];
    for(int i = 0; i < _jobs.length; i++){
      _jobs[i]['select'] == true ? summ[0] = summ[0] + _jobs[i]['price'] : null;
      _jobs[i]['select'] == true ? summ[1] = summ[1] + _jobs[i]['price'] * _jobs[i]['discount'] : null;
    }
    return summ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 1,
          centerTitle: true,
          iconTheme: IconThemeData(
              size:22, color: button
          ),
          automaticallyImplyLeading: true,
          title: Text('Просмотр записи', style: boldText),
          actions: [
            Container(

              margin: const EdgeInsets.fromLTRB(0,0,20,0),
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                  child:DropdownButton<Widget>(
                    iconSize: 0.0,
                    isExpanded: false,
                    value: selectedFlag,
                    onChanged: (newValue) {
                      _status = flags.indexOf(newValue!);
                      setState(() {
                        selectedFlag = newValue;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return flags.map<Widget>((item) {
                        return Container(
                            alignment: Alignment.centerRight,
                            width: 20,
                            height: 20,
                            child: SizedBox(width: 20, height: 20, child: item));
                      }).toList();
                    },
                    items: flags.map<DropdownMenuItem<Widget>>((value) {
                      return DropdownMenuItem<Widget>(
                        value: value,
                        child: value,
                      );
                    }).toList(),
                  )),
            ),
          ]
      ),
      body: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          color:backgroundColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/dateselect.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Дата и время', style: taskTitle ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        margin: const EdgeInsets.fromLTRB(0,0,20,0),
                        alignment: Alignment.bottomRight,
                        child: Text('Править', style: taskLink ),
                      ),
                    ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Дата', style: nameSubTitle ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: _date,
                                        maxTime: _date.add(Duration(days: 365)),
                                        theme: DatePickerTheme(
                                            cancelStyle: TextStyle(color: Colors.blue, fontSize: 16),
                                            headerColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            itemStyle: TextStyle(
                                                color: Colors.black,
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                            doneStyle:
                                            TextStyle(color: Colors.blue, fontSize: 16)),
                                        onChanged: (date) {
                                          //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                        }, onConfirm: (date) {
                                          setState(() {
                                            //_date = date;
                                            //_timeStart = _date.add(Duration(hours: _timeStart.hour, minutes: _timeStart.minute));
                                            //_timeEnd = _date.add(Duration(hours: _timeEnd.hour, minutes: _timeEnd.minute));
                                          });
                                        },
                                        currentTime: _date,
                                        locale: LocaleType.ru);
                                  },
                                  child: Text(
                                    DateFormat.yMd('ru').format(_date),
                                    style: nameSubTitleDark,
                                  )),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,15,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Время', style: nameSubTitle ),
                              Spacer(),
                              Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              showSecondsColumn: false,
                                              showTitleActions: true,
                                              currentTime: _timeStart,
                                              theme: DatePickerTheme(
                                                  cancelStyle: TextStyle(color: Colors.blue, fontSize: 16),
                                                  headerColor: Colors.white,
                                                  backgroundColor: Colors.white,
                                                  itemStyle: TextStyle(
                                                      color: Colors.black,
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                  doneStyle:
                                                  TextStyle(color: Colors.blue, fontSize: 16)),
                                              onChanged: (date) {
                                                //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                              }, onConfirm: (date) {
                                                setState(() {
                                                  _timeStart = date;
                                                });
                                              },
                                              locale: LocaleType.ru);
                                        },
                                        child: Text(
                                          DateFormat.Hm('ru').format(_timeStart),
                                          style: nameSubTitleDark,
                                        )),
                                    Text('-', style: nameSubTitleDark ),
                                    TextButton(
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              showSecondsColumn: false,
                                              showTitleActions: true,
                                              currentTime: _timeStart,
                                              theme: DatePickerTheme(
                                                  cancelStyle: TextStyle(color: Colors.blue, fontSize: 16),
                                                  headerColor: Colors.white,
                                                  backgroundColor: Colors.white,
                                                  itemStyle: TextStyle(
                                                      color: Colors.black,
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                  doneStyle:
                                                  TextStyle(color: Colors.blue, fontSize: 16)),
                                              onChanged: (date) {
                                                //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                              }, onConfirm: (date) {
                                                setState(() {
                                                  _timeEnd = date;
                                                });
                                              },
                                              locale: LocaleType.ru);
                                        },
                                        child: Text(
                                          DateFormat.Hm('ru').format(_timeEnd),
                                          style: nameSubTitleDark,
                                        )),
                                  ]),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('№ поста', style: nameSubTitle ),
                              Spacer(),
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<int>(
                                    value: _postNum,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _postNum = newValue!;
                                      });
                                    },
                                    items: Iterable<int>.generate(_maxPostCol).toList().map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString(), style: nameSubTitleDark ),
                                      );
                                    }).toList(),
                                  )),
                              //Text('1', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/carselect.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Автомобиль', style: taskTitle ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        margin: const EdgeInsets.fromLTRB(0,0,20,0),
                        alignment: Alignment.bottomRight,
                        child: Text('Править', style: taskLink ),
                      ),
                    ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Тип ТС', style: nameSubTitle ),
                              Spacer(),
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<String>(
                                    isExpanded: false,
                                    value: carTypeSelected,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        carTypeSelected = newValue!;
                                      });
                                    },

                                    selectedItemBuilder: (BuildContext context) {
                                      return carsTypes.map<Widget>((String item) {
                                        return Container(
                                            alignment: Alignment.centerRight,
                                            width: 150,
                                            child: Text(item, style: nameSubTitleDark, textAlign: TextAlign.end)
                                        );
                                      }).toList();
                                    },
                                    items: carsTypes.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: nameSubTitleDark, textAlign: TextAlign.right,),
                                      );
                                    }).toList(),
                                  )),
                              //Text('17.11.2020', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => carNumEdit(),
                      ),
                    ).then(onGoBack);

                  }, child: Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Номер ТС', style: nameSubTitle ),
                              Spacer(),
                              Row(
                                  children:[
                                    Container(
                                      width: 80,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.only(
                                            topLeft:  const  Radius.circular(5),
                                            bottomLeft: const  Radius.circular(5)
                                        ),
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                      child:Text(carNumber, style: nameSubTitleDark ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.only(
                                            topRight:  const  Radius.circular(5),
                                            bottomRight: const  Radius.circular(5)
                                        ),
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                      child:Text(carRegion, style: nameSubTitleDark ),
                                    ),
                                  ]
                              )
                              //Text('11:00 - 12:00', style: nameSubTitleDark ),
                            ])
                    )),),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Марка ТС', style: nameSubTitle ),
                              Spacer(),
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<String>(
                                    isExpanded: false,
                                    value: carBrandSelected,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        carBrandSelected = newValue!;
                                      });
                                    },

                                    selectedItemBuilder: (BuildContext context) {
                                      return carsBrands.map<Widget>((String item) {
                                        return Container(
                                            alignment: Alignment.centerRight,
                                            width: 150,
                                            child: Text(item, style: nameSubTitleDark, textAlign: TextAlign.end)
                                        );
                                      }).toList();
                                    },
                                    items: carsBrands.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: nameSubTitleDark, textAlign: TextAlign.right,),
                                      );
                                    }).toList(),
                                  )),
                              //Text('1', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Модель ТС', style: nameSubTitle ),
                              Spacer(),
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<String>(
                                    isExpanded: false,
                                    value: carModelSelected,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        carModelSelected = newValue!;
                                      });
                                    },

                                    selectedItemBuilder: (BuildContext context) {
                                      return carsModels.map<Widget>((String item) {
                                        return Container(
                                            alignment: Alignment.centerRight,
                                            width: 150,
                                            child: Text(item, style: nameSubTitleDark, textAlign: TextAlign.end)
                                        );
                                      }).toList();
                                    },
                                    items: carsModels.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: nameSubTitleDark, textAlign: TextAlign.right,),
                                      );
                                    }).toList(),
                                  )),
                              //Text('11:00 - 12:00', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Цвет', style: nameSubTitle ),
                              Spacer(),
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<Color>(
                                    isExpanded: false,
                                    value: selectedColor,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedColor = newValue!;
                                        selectedColorIndex = _colors.indexOf(newValue);
                                      });
                                    },

                                    selectedItemBuilder: (BuildContext context) {
                                      return _colors.map<Widget>((item) {
                                        return Container(
                                          alignment: Alignment.centerRight,
                                          width: 20,
                                          height: 20,
                                          child: SizedBox(width: 20, height: 20, child: Container(decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black12,
                                                width: 0.5,
                                              ),
                                              color: item),),),
                                        );
                                      }).toList();
                                    },
                                    items: _colors.map<DropdownMenuItem<Color>>((value) {
                                      return DropdownMenuItem<Color>(
                                        value: value,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5,

                                            ),
                                            color: value,),
                                          alignment: Alignment.centerRight,
                                          width: 20,
                                          height: 20,
                                          child: SizedBox(width: 20, height: 20,),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                              //Text('1', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/clientselect.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Клиент', style: taskTitle ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => personContact(),
                            ),
                          );

                        }, child: Container(
                        height: 30,
                        margin: const EdgeInsets.fromLTRB(0,0,20,0),
                        alignment: Alignment.bottomRight,
                        child: Text('Править', style: taskLink ),
                      ),),
                    ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Телефон', style: nameSubTitle ),
                              Spacer(),
                              Text(personPhone, style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Фамилия', style: nameSubTitle ),
                              Spacer(),
                              Text(personSyrname, style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Имя', style: nameSubTitle ),
                              Spacer(),
                              Text(personName, style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Отчество', style: nameSubTitle ),
                              Spacer(),
                              Text(personPatronym, style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/joblist.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Список работ', style: taskTitle ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        margin: const EdgeInsets.fromLTRB(0,0,20,0),
                        alignment: Alignment.bottomRight,
                        child: Text('Править', style: taskLink ),
                      ),
                    ]),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => jobSelect(),
                      ),
                    ).then(onGoBack);

                  }, child: Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Добавить', style: nameSubTitle ),
                              Spacer(),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                //дальше разбираем массив набраных работ
                ListView.separated(
                  padding:EdgeInsets.fromLTRB(0,0,0,0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => _jobs[index]['select'] == true ? Container(
                    color: Color(0xFFFFFFFF),
                    child:Container(
                      color: Color(0xFFFFFFFF),
                      margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),) : Container(),
                  itemCount: _jobs.length,
                  itemBuilder: (context, index) => _jobs[index]['select'] == true ? Container(
                      margin: const EdgeInsets.fromLTRB(0,0,0,0),
                      color: Color(0xFFFFFFFF),
                      height: _showDec[index] == true ? 74 : 37,
                      alignment: Alignment.centerLeft,
                      child:Column(
                          children:[
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  _showDec[index] = !_showDec[index];
                                });
                              },
                              child:Container(
                                  margin: const EdgeInsets.fromLTRB(70,0,20,0),
                                  height: 37,
                                  alignment: Alignment.centerLeft,
                                  child:Row(
                                      children: [
                                        Text(_jobs[index]['name'], style: nameSubTitle),
                                        Spacer(),
                                        Text('${_jobs[index]['price'].toString()} ₽', style: nameSubTitleDark ),
                                        SizedBox(width:5),
                                        GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                _jobs[index]['select'] = !_jobs[index]['select'];
                                              });
                                            },
                                            child:Icon(CupertinoIcons.minus_circle_fill,  color: Colors.red)
                                        )
                                      ])
                              ),),
                            _showDec[index] == true ? Container(
                              height: 37,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(10,0,10,0),
                              color:superLightGrey,
                              child: Text(_jobs[index]['description'], style: nameSubTitle),
                            ): Container()
                          ])
                  ) : Container(),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/priceselect.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Стоимость', style: taskTitle ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        margin: const EdgeInsets.fromLTRB(0,0,20,0),
                        alignment: Alignment.bottomRight,
                        child: Text('Править', style: taskLink ),
                      ),
                    ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Всего', style: nameSubTitle ),
                              Spacer(),
                              Text('${countBill()[0]} ₽', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Скидка', style: nameSubTitle ),
                              Spacer(),
                              Text('${countBill()[1]} ₽', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,20,0),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Итого', style: taskTitle2 ),
                              Spacer(),
                              Text('${countBill()[0] - countBill()[1]} ₽', style: nameSubTitleDark ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Color(0xFFFFFFFF),
                    height: 37,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(70,0,10,0),
                        //color: Color(0xFFFFFFFF),
                        height: 37,
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children: [
                              Text('Исполнитель', style: nameSubTitle ),
                              Spacer(),
                              DropdownButtonHideUnderline(
                                  child:DropdownButton<String>(
                                    iconSize: 0.0,
                                    isExpanded: false,
                                    value: staffSelected,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        staffSelected = newValue!;
                                      });
                                    },

                                    selectedItemBuilder: (BuildContext context) {
                                      return staff.map<Widget>((String item) {
                                        return Container(
                                            alignment: Alignment.centerRight,
                                            width: 150,
                                            child: Text(item, style: nameSubTitleDark, textAlign: TextAlign.end)
                                        );
                                      }).toList();
                                    },
                                    items: staff.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: nameSubTitleDark, textAlign: TextAlign.right,),
                                      );
                                    }).toList(),
                                  )),
                              Icon(CupertinoIcons.chevron_right, size:22, color: button),
                            ])
                    )
                ),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/comment.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Комментарии', style: taskTitle ),
                      ),
                      Spacer(),

                    ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: superLightGrey,
                    height: 58,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        height: 58,
                        alignment: Alignment.centerLeft,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Все отлично', style: nameSubTitleDark ),
                              SizedBox(height: 10,),
                              Text('Коментарий клиента', style: nameSubTitleSmall ),
                            ])
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Colors.white,
                    height: 58,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        height: 58,
                        alignment: Alignment.centerLeft,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Жддем вас снова', style: nameSubTitleDark ),
                              SizedBox(height: 10,),
                              Text('Коментарий персонала', style: nameSubTitleSmall ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/feedback.png'),
                              fit:BoxFit.none, alignment: Alignment.center
                          ),
                        ),),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20,10,0,10),
                        alignment: Alignment.centerLeft,
                        child: Text('Отзывы', style: taskTitle ),
                      ),
                      Spacer(),

                    ]),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: superLightGrey,
                    height: 58,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        height: 58,
                        alignment: Alignment.centerLeft,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Все отлично', style: nameSubTitleDark ),
                              SizedBox(height: 10,),
                              Text('Отзыв клиента', style: nameSubTitleSmall ),
                            ])
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(0,0,0,0),
                    color: Colors.white,
                    height: 58,
                    alignment: Alignment.centerLeft,
                    child:Container(
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        height: 58,
                        alignment: Alignment.centerLeft,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Жддем вас снова', style: nameSubTitleDark ),
                              SizedBox(height: 10,),
                              Text('Отзыв персонала', style: nameSubTitleSmall ),
                            ])
                    )),
                Container(
                  color: Color(0xFFFFFFFF),
                  child:Container(
                    color: Color(0xFFFFFFFF),
                    margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),),
                SizedBox(height: 100,)
              ]),

        ),
      ),
      bottomNavigationBar: Container(
    margin: const EdgeInsets.fromLTRB(20,0,20,30),
    padding: const EdgeInsets.fromLTRB(0,0,0,0),
    height: 120,
    width: MediaQuery.of(context).size.width - 40,
    alignment: Alignment.bottomCenter,
    child: Column(
    children:[
      Container(
        margin: const EdgeInsets.fromLTRB(20,0,20,10),
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        height: 48,
        width: MediaQuery.of(context).size.width - 40,
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed:(){
            //orders[0]['orderItems'].removeAt(widget.index);
            ordersBorn[0]['orderItems'].removeAt(widget.index);
            //keyRed.removeAt(widget.index);
            Navigator.pushReplacement (context,
                MaterialPageRoute(builder: (context) => freeSize()));
          } ,
          child: Text('Удалить', style: buttonText,textAlign: TextAlign.center,),
          style: ElevatedButton.styleFrom(
            primary: buttonRed,
            minimumSize: Size(MediaQuery.of(context).size.width - 40, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      ),
    Container(
        margin: const EdgeInsets.fromLTRB(20,0,20,0),
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        height: 48,
        width: MediaQuery.of(context).size.width - 40,
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed:(){} ,
          child: Text('Обновить', style: buttonText,textAlign: TextAlign.center,),
          style: ElevatedButton.styleFrom(
            primary: button,
            minimumSize: Size(MediaQuery.of(context).size.width - 40, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      ),
      ])
      )
    );
  }

}

//массив с флажками
List<Widget> flags =[Container(
  height: 30,
  width: 30,
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/flaggreen.png'),
        fit:BoxFit.contain, alignment: Alignment.center
    ),
  ),),Container(
  height: 30,
  width: 30,
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/flaggrey.png'),
        fit:BoxFit.contain, alignment: Alignment.center
    ),
  ),),Container(
  height: 30,
  width: 30,
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/flagblue.png'),
        fit:BoxFit.contain, alignment: Alignment.center
    ),
  ),),Container(
  height: 30,
  width: 30,
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/flagyellow.png'),
        fit:BoxFit.contain, alignment: Alignment.center
    ),
  ),),];
var selectedFlag = flags[0];