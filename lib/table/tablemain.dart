import 'dart:async';
import 'dart:convert';
import 'package:carwash/currentorderinfo/orderinfo.dart';
import 'package:carwash/info/infomain.dart';
import 'package:carwash/order/ordermain.dart';
import 'package:carwash/profile/profilemain.dart';
import 'package:carwash/speedorder/speedordermain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles.dart';

bool bootResdy = false;
int sliderDuration = 15;
List ordersBorn = [{'postCol' : 10, 'periodStart' : '2021-08-11 00:00:00.000','periodEnd' : '2021-08-11 23:59:00.000', 'orderItems' :
[{'Start' : '2021-08-11 01:15:00.000', 'End' : '2021-08-11 02:30:00.000', 'postNum' : 1, 'status': 1, 'edit' : 1, 'selected' : false, 'carTypeSelected' : 'Легковой', 'carBrandSelected' : 'Газель', 'carModelSelected' : 'X-Ray', 'selectedColor' : 0, 'carNumber' : 'Н345НТ', 'carRegion' : '177', 'personName' : 'Ivan', 'personSyrname' : 'Sidorov', 'personPatronym' : 'Ivanovych', 'personPhone' : '+7 987 654 33 22', 'staffSelected' : 'Петрова А.И.',  'jobds' :[{'name' : 'wash 3', 'price' : 600.0, 'discount' : 0.0, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Услуга', 'select' : false}]},
  {'Start' : '2021-08-11 02:15:00.000', 'End' : '2021-08-11 03:30:00.000', 'postNum' : 2, 'status': 2, 'edit' : 1, 'selected' : false, 'carTypeSelected' : 'Легковой', 'carBrandSelected' : 'Газель', 'carModelSelected' : 'X-Ray', 'selectedColor' : 0, 'carNumber' : 'Н345НТ', 'carRegion' : '177', 'personName' : 'Ivan', 'personSyrname' : 'Sidorov', 'personPatronym' : 'Ivanovych', 'personPhone' : '+7 987 654 33 22', 'staffSelected' : 'Петрова А.И.',  'jobds' :[{'name' : 'wash 3', 'price' : 600.0, 'discount' : 0.0, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Услуга', 'select' : false}]},
  {'Start' : '2021-08-11 09:15:00.000', 'End' : '2021-08-11 11:00:00.000', 'postNum' : 7, 'status': 3, 'edit' : 1, 'selected' : false, 'carTypeSelected' : 'Легковой', 'carBrandSelected' : 'Газель', 'carModelSelected' : 'X-Ray', 'selectedColor' : 0, 'carNumber' : 'Н345НТ', 'carRegion' : '177', 'personName' : 'Ivan', 'personSyrname' : 'Sidorov', 'personPatronym' : 'Ivanovych', 'personPhone' : '+7 987 654 33 22', 'staffSelected' : 'Петрова А.И.',  'jobds' :[{'name' : 'wash 3', 'price' : 600.0, 'discount' : 0.0, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Услуга', 'select' : false}]},
  {'Start' : '2021-08-11 07:15:00.000', 'End' : '2021-08-11 09:00:00.000', 'postNum' : 7, 'status': 3, 'edit' : 1, 'selected' : false, 'carTypeSelected' : 'Легковой', 'carBrandSelected' : 'Газель', 'carModelSelected' : 'X-Ray', 'selectedColor' : 0, 'carNumber' : 'Н345НТ', 'carRegion' : '177', 'personName' : 'Ivan', 'personSyrname' : 'Sidorov', 'personPatronym' : 'Ivanovych', 'personPhone' : '+7 987 654 33 22', 'staffSelected' : 'Петрова А.И.',  'jobds' :[{'name' : 'wash 3', 'price' : 600.0, 'discount' : 0.0, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Услуга', 'select' : false}]},
]}];
List orders = [];
double postWidth = 50.0;
double cellHeigth = 50.0;

int maxDateForSlider = 600;
DateTime dateTimeStart = DateTime.parse(ordersBorn[0]['periodStart']);
DateTime dateTimeEnd = DateTime.parse(ordersBorn[0]['periodStart']).add(Duration(minutes: maxDateForSlider)).isBefore(DateTime.parse(ordersBorn[0]['periodEnd'])) ? DateTime.parse(ordersBorn[0]['periodStart']).add(Duration(minutes: maxDateForSlider)) :  DateTime.parse(ordersBorn[0]['periodEnd']);
int timePeriodinMinute = dateTimeEnd.difference(dateTimeStart).inHours;

bool enableDrag = false;
List _colors = [Color(0xFF0AA385),Color(0xFF797979),Color(0xFF1853A8),Color(0xFFFFA606)];
List<GlobalKey> keyRed = [];

class freeSize extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}


class _DemoState extends State<freeSize> {

  @override
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  String timeSet = '1 час';
  List<String> timeSetItems = ['5 минут', '15 минут','30 минут','1 час'];

  countBill(int index){
    List summ = [0.0,0.0];
    for(int i = 0; i < ordersBorn[0]['orderItems'][index]['jobds'].length; i++){
      summ[0] = summ[0] + ordersBorn[0]['orderItems'][index]['jobds'][i]['price'];
     summ[1] = summ[1] + ordersBorn[0]['orderItems'][index]['jobds'][i]['price'] * ordersBorn[0]['orderItems'][index]['jobds'][i]['discount'];
    }
    return summ;
  }

  mooveToColumn(int column){
    print(column);
    for(int i = 0; i < ordersBorn[0]['orderItems'].length; i++){
      ordersBorn[0]['orderItems'][i]['selected'] == true ? ordersBorn[0]['orderItems'][i]['postNum'] = column : null;
      ordersBorn[0]['orderItems'][i]['selected'] == true ? print('find') : null;
    }

    rebuildListOrders();
  }


  rebuildListOrders(){
    //создать массив массивов с числом массивов равным количеству постов
    List majorTemp = [];
    for(int i = 0; i < ordersBorn[0]['postCol']; i++){
      majorTemp.add([]);
    }
    //затем все записи раскидать по своим массивам в зависимости от номера поста
    for(int i = 0; i < ordersBorn[0]['orderItems'].length; i++){
      majorTemp[ordersBorn[0]['orderItems'][i]['postNum']].add(ordersBorn[0]['orderItems'][i]);
    }
    //потом все записи в каждом массиве отсортировать по дате
    for(int i = 0; i < majorTemp.length; i++){
      majorTemp[i].sort((a,b) {
        var adate = DateTime.parse(a['Start']);
        var bdate = DateTime.parse(b['Start']);
        return adate.compareTo(bdate);
      });
    }
    //убрать пустые строки
    for(int i=0; i< majorTemp.length; i++){
      majorTemp[i].length == 0 ? majorTemp.removeAt(i) : null;
    }
    ordersBorn[0]['orderItems']=[];
    for(int i = 0; i < majorTemp.length; i++){
      for(int ii = 0; ii < majorTemp[i].length; ii++) {
        ordersBorn[0]['orderItems'].add(majorTemp[i][ii]);
      }
    }
    orders.clear();
    orders = json.decode(jsonEncode(ordersBorn));

    //создаем массив с инидкаторами положения
    for(int i= 0; i < orders[0]['orderItems'].length; i++){
      keyRed.add(GlobalKey());
    }
    postWidth = (MediaQuery.of(context).size.width-35) / 3 ;
    cellHeigth = (MediaQuery.of(context).size.height-35-180) / timePeriodinMinute;


    for(int i = 0; i < orders[0]['orderItems'].length; i++){
      //время конца заказа не влазиет в период
      if(DateTime.parse(orders[0]['orderItems'][i]['Start']).isAfter(dateTimeStart) && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(dateTimeEnd)){
        orders[0]['orderItems'][i]['End'] = dateTimeEnd.toString();
        orders[0]['orderItems'][i]['edit'] = 0;
      }
      //если заказ раньше времни начала показываемого отрезка, но влезает во время конца показываемого отрезка, меняем ему время начала и ставим пометку, что он не редактируемый
      if(DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(dateTimeStart) && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(dateTimeStart)){
        orders[0]['orderItems'][i]['Start'] = dateTimeStart.toString();
        orders[0]['orderItems'][i]['edit'] = 0;
      }


      //заказ не влезает совсем
      if(DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(dateTimeStart) && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(dateTimeEnd)){
        orders[0]['orderItems'][i]['End'] = dateTimeEnd.toString();
        orders[0]['orderItems'][i]['Start'] = dateTimeStart.toString();
        orders[0]['orderItems'][i]['edit'] = 0;
      }
      //удалим заказы которые не должно быть видно сверху
      if(DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(dateTimeStart) && DateTime.parse(orders[0]['orderItems'][i]['End']).isBefore(dateTimeStart)){
        orders[0]['orderItems'].removeAt(i);
      }

      //удалим заказы которые не должно быть видно снизу
      try{
        if(DateTime.parse(orders[0]['orderItems'][i]['Start']).isAfter(dateTimeEnd) && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(dateTimeEnd)){
          //  print('error 5');
          orders[0]['orderItems'].removeAt(i);
        }}catch(e){}
    }

    bootResdy = true;
    setState(() {});
  }

  changeTimeForView(){
    timePeriodinMinute = dateTimeEnd.difference(dateTimeStart).inHours;
    rebuildListOrders();
  }



  @override
  void initState() {
    super.initState();
    const twentyMillis = Duration(seconds: 1);
    Timer(twentyMillis, () {
      changeTimeForView();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child:AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(20,50,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(onTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => profileMain()));
                          }, child:Container(
                            width:20,
                            height:20,
                            color:Colors.white,
                            child:Icon(Icons.menu, color: Color(0xFF1853A8)),
                          ),),
                          Spacer(),
                          GestureDetector(onTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => infoMain()));
                          }, child:Container(
                            width:20,
                            height:20,
                            color:Colors.white,
                            child:Icon(CupertinoIcons.info, color: Color(0xFF1853A8)),),),
                          SizedBox(width: 20,),
                          GestureDetector(onTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => orderMain()));
                          }, child:Container(
                            width:20,
                            height:20,
                            color:Colors.white,
                            child:Icon(CupertinoIcons.add, color: Color(0xFF1853A8)),),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/sizeSelect.png'),
                                  fit:BoxFit.none, alignment: Alignment.center
                              ),
                            ),),
                          DropdownButtonHideUnderline(
                            child:DropdownButton(
                              iconSize: 0.0,
                              value: timeSet,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items:timeSetItems.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(items, style: nameSubTitleDark,)
                                );
                              }
                              ).toList(),
                              onChanged: (String? newValue){
                                setState(() {
                                  timeSet = newValue!;
                                  timeSet == '5 минут' ? maxDateForSlider = 75 : timeSet == '15 минут' ? maxDateForSlider = 150 : timeSet == '30 минут' ? maxDateForSlider = 300 : maxDateForSlider = 600;
                                  timeSet == '5 минут' ? sliderDuration = 5 : timeSet == '15 минут' ? sliderDuration = 15 : timeSet == '30 минут' ? sliderDuration = 30 : sliderDuration = 60;
                                  dateTimeStart = DateTime.parse(ordersBorn[0]['periodStart']);
                                  dateTimeEnd = DateTime.parse(ordersBorn[0]['periodStart']).add(Duration(minutes: maxDateForSlider)).isBefore(DateTime.parse(ordersBorn[0]['periodEnd'])) ? DateTime.parse(ordersBorn[0]['periodStart']).add(Duration(minutes: maxDateForSlider)) :  DateTime.parse(ordersBorn[0]['periodEnd']);

                                  bootResdy = false;
                                });
                                changeTimeForView();
                              },
                            ),),
                          Spacer(),
                          Container(
                            height: 25,
                            width: 25,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/dateSelector.png'),
                                  fit:BoxFit.none, alignment: Alignment.center
                              ),
                            ),),
                          TextButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: dateTimeStart.add(Duration(days: -365)),
                                    maxTime: dateTimeStart.add(Duration(days: 365)),
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
                                    }, onConfirm: (date) {
                                      setState(() {
                                        //dateTimeStart = date;
                                        //dateTimeEnd = date.add(Duration(hours: 23, minutes: 59));
                                        //ordersBorn[0]['periodStart'] = dateTimeStart.toString();
                                        //ordersBorn[0]['periodEnd'] = dateTimeEnd.toString();
                                      });
                                    },
                                    currentTime: dateTimeStart,
                                    locale: LocaleType.ru);
                              },
                              child: Text(
                                DateFormat.yMd('ru').format(dateTimeStart),
                                style: nameSubTitleDark,
                              )),
                        ])
                    ])
              )
          ),
        ),
        body:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          child: Stack(
              children:[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: cellHeigth * timePeriodinMinute + 35, //высота ячеек на количество времени в минутах + высота индикатора постов
                    color: Colors.white,
                    alignment: Alignment.topCenter,
                    child: bootResdy == true ? ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children:[
                          Stack(
                              children: [
                                //индикатор постов
                                Container(
                                  margin: EdgeInsets.fromLTRB(35,0,0,0),
                                  width: postWidth * orders[0]['postCol'],
                                  height: 35,
                                  color: Colors.white,
                                  alignment: Alignment.topLeft,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: false,
                                      itemCount: ordersBorn[0]['postCol'],
                                      itemBuilder: (context, index) {
                                        return GestureDetector(onTap: (){mooveToColumn(index);}, child:Container(
                                          width: postWidth,
                                          height: 30,
                                          color: index % 2 > 0 ? Colors.white : Colors.black12,
                                          alignment: Alignment.center,
                                          child: Text('${index+1}',textAlign: TextAlign.center,style: TextStyle(fontSize: 12.0, color: Color(0xFF304655), fontFamily: 'Inter',)),
                                        ));}),
                                ),

                                paintAddOrderPole(),
                                Container(
                                  margin: EdgeInsets.fromLTRB(35,35,0,0),
                                  width: postWidth * orders[0]['postCol'],
                                  height: MediaQuery.of(context).size.height,
                                  //color: Colors.grey,
                                  alignment: Alignment.topLeft,
                                  child: Stack(
                                    children: List.generate(orders[0]['orderItems'].length,(index){
                                      return orders[0]['orderItems'][index]['selected'] == false ? paintOrdersNonDragg(index) : paintOrderDragg(index);}),
                                  ),
                                ),

                              ])
                        ]) : Container()
                ),
                //индикатор времени
                Container(
                  margin: EdgeInsets.fromLTRB(0,35,0,0),
                  width: 35,
                  height: cellHeigth * timePeriodinMinute, //отображать определенное количество часов
                  alignment: Alignment.topLeft,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: timePeriodinMinute,
                      itemBuilder: (context, index) {
                        return timeScale(index);}),
                ),
                //слайдер экрана
                bootResdy == true ? Container(
                  width: 50,
                  height: cellHeigth * timePeriodinMinute, //высота ячеек на количество времени в минутах + высота индикатора постов
                  //color: Colors.grey,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width - 50,35,0,0),
                  child: Transform(
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()
                        ..rotateZ(180 * 3.1415927 / 180),
                      child:SfSlider.vertical(
                        min: DateTime.parse(ordersBorn[0]['periodStart']),
                        max: DateTime.parse(ordersBorn[0]['periodEnd']).add(Duration(minutes: - maxDateForSlider)),
                        value: dateTimeStart,
                        showTicks: true,
                        showLabels: false,
                        stepDuration: SliderStepDuration(minutes: sliderDuration),
                        dateFormat: DateFormat.yMd('ru'),
                        dateIntervalType: DateIntervalType.hours,
                        onChanged: (dynamic value){
                          if(bootResdy == true) {
                            setState(() {
                              dateTimeStart = value;
                              value.add(
                                  Duration(minutes: maxDateForSlider))
                                  .isBefore(DateTime.parse(
                                  ordersBorn[0]['periodEnd']))
                                  ? dateTimeEnd = value.add(
                                  Duration(minutes: maxDateForSlider))
                                  : dateTimeEnd = DateTime.parse(
                                  ordersBorn[0]['periodEnd']);
                              bootResdy = false;
                            });
                            changeTimeForView();
                          }
                        },
                      )

                  ),
                ) : Container(),

              ]),
        )

    );
  }

  timeScale(int index){
    return Container(
      width: 35,
      height: cellHeigth,
      color: index % 2 > 0 ? Colors.white : Colors.black12,
      alignment: Alignment.topCenter,
      child: timeSet == '1 час' ? Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)
          :timeSet == '30 минут' ? Column(
        children: [
          Container(
              width: 35,
              height: cellHeigth / 2,
              alignment: Alignment.topCenter,
              child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
          Container(
              width: 35,
              height: cellHeigth / 2,
              alignment: Alignment.topCenter,
              child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 30)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
        ],
      ) : timeSet == '15 минут' ? Column(
          children: [
            Container(
                width: 35,
                height: cellHeigth / 4,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 4,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 15)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 4,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 30)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),

            Container(
                width: 35,
                height: cellHeigth / 4,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 45)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
          ]) : Column(
          children: [
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 5)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 10)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),

            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 15)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 20)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 25)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 30)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),

            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 35)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 40)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 45)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),

            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 50)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),
            Container(
                width: 35,
                height: cellHeigth / 12,
                alignment: Alignment.topCenter,
                child:Text('${DateFormat.Hm('ru').format(dateTimeStart.add(Duration(hours: index, minutes: 55)))}',style: TextStyle(fontSize: 10, color: Color(0xFF304655), fontFamily: 'Inter',), textAlign: TextAlign.center,)),

          ]) ,
    );
  }


  /*addOrder(double dX, double dY){
    //в каой столбеу(пост) размещать заказ
    var postNum = (dX / postWidth).round() -1 ;//ok
    //вычисляем время начала заказа в зависимости от того куда нажали
    var timeStart = dateTimeStart.add(Duration(minutes: (((( (dY-cellHeigth +15) * timePeriodinMinute ) / (cellHeigth*timePeriodinMinute)*60)+8).toInt())));
    //вычисляем время конца заказа
    var timeEnd = timeStart.add(Duration(minutes: 60));
    //влезаем ли сверху?
    if(timeStart.isBefore(dateTimeStart)){
      timeStart = dateTimeStart;
      timeEnd = dateTimeStart.add(Duration(minutes: 60));
    }
    //влезаем ли снизу,
    if(timeEnd.isAfter(dateTimeEnd)){
      timeStart = dateTimeEnd.add(Duration(minutes: -120));
      timeEnd = dateTimeEnd.add(Duration(minutes: -60));
    }
    bool top = false;
    bool down = false;
    //есть ли чье нибудь начало в моем времнно отрезке?
    for(int i = 0; i < orders[0]['orderItems'].length; i++) {
      top = orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(timeEnd);
      top == true ? timeEnd = DateTime.parse(orders[0]['orderItems'][i]['Start']) : null;
      orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(timeEnd)? i = orders[0]['orderItems'].length : null;
    }
    //есть ли чей нибудь конец в моем временном отрезке
    for(int i = 0; i < orders[0]['orderItems'].length; i++) {
      down = orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isBefore(timeEnd);
      orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isBefore(timeEnd) ? i = orders[0]['orderItems'].length : null;
    }
    if(top == false) {
      //добавляем виджет и заказ в массив
      ordersBorn[0]['orderItems'].add({'Start' : timeStart.toString(), 'End' : timeEnd.toString(), 'postNum' : postNum, 'status': 0, 'edit' : 1, 'selected' : false, 'carTypeSelected' : 'Легкоговой', 'carBrandSelected' : 'Газель', 'carModelSelected' : 'X-Ray', 'selectedColor' : 0, 'carNumber' : 'Н345НТ', 'carRegion' : '177', 'personName' : 'Ivan', 'personSyrname' : 'Sidorov', 'personPatronym' : 'Ivanovych', 'personPhone' : '+7 987 654 33 22', 'staffSelected' : 'Петрова А.И.',  'jobds' :[{'name' : 'wash 3', 'price' : 600.0, 'discount' : 0.0, 'description' : 'bla bla bla bla', 'type' : 'Мойка', 'subType' : 'Услуга', 'select' : false}]});
      keyRed.add(GlobalKey());
    }
    setState(() {});
    changeTimeForView();
  }*/

  //меняем местоположение заказа
  changePosition(int index) {
    var status = orders[0]['orderItems'][index]['status'];
    var orderDuration = DateTime.parse(orders[0]['orderItems'][index]['End']).difference(DateTime.parse(orders[0]['orderItems'][index]['Start'])).inMinutes;
    var copyOrder = ordersBorn[0]['orderItems'][index];
    ordersBorn[0]['orderItems'].removeAt(index);
    final RenderBox renderBoxRed = keyRed[index].currentContext!.findRenderObject() as RenderBox;
    final positionRedX = renderBoxRed.localToGlobal(Offset.zero).dx - 35; //верхний левый угол
    final positionRedY = renderBoxRed.localToGlobal(Offset.zero).dy - 160; //верхний левый угол ????? точность кнопки либо уход в глубокий минус
    keyRed.removeAt(index);
    //в каой столбец(пост) размещать заказ
    var postNum = (positionRedX / postWidth).round() ;//ok
    //вычисляем время начала заказа в зависимости от того куда нажали
    var timeStart = dateTimeStart.add(Duration(minutes: (((( positionRedY * timePeriodinMinute ) / (cellHeigth*timePeriodinMinute)*60-10)).toInt())));
    //вычисляем время конца заказа
    var timeEnd = timeStart.add(Duration(minutes: orderDuration));
    bool top = false;
    bool down = false;


    //есть ли чье нибудь начало в моем времнно отрезке?
    for(int i = 0; i < orders[0]['orderItems'].length; i++) {
      top = orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(timeEnd);
      orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['Start']).isBefore(timeEnd)? i = orders[0]['orderItems'].length : null;
    }

    //есть ли чей нибудь конец в моем временном отрезке
    for(int i = 0; i < orders[0]['orderItems'].length; i++) {
      down = orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isBefore(timeEnd);
      orders[0]['orderItems'][i]['postNum'] == postNum
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isAfter(timeStart)
          && DateTime.parse(orders[0]['orderItems'][i]['End']).isBefore(timeEnd) ? i = orders[0]['orderItems'].length : null;
    }

    if(top == false) {
      if (down == false) {
        //print('move');
      } else {
        timeStart = DateTime.parse(copyOrder['Start']);
        timeEnd = DateTime.parse(copyOrder['End']);
        postNum = copyOrder['postNum'];
      }
    }else {
      timeStart = DateTime.parse(copyOrder['Start']);
      timeEnd = DateTime.parse(copyOrder['End']);
      postNum = copyOrder['postNum'];
    }

    //влезаем ли сверху?
    if(timeStart.isBefore(dateTimeStart)){
      timeStart = dateTimeStart;
      timeEnd = dateTimeStart.add(Duration(minutes: orderDuration));
    }
    //влезаем ли снизу,
    if(timeEnd.isAfter(dateTimeEnd)){
      timeStart = DateTime.parse(copyOrder['Start']);
      timeEnd = DateTime.parse(copyOrder['End']);
      postNum = copyOrder['postNum'];
    }
    //добавляем виджет и заказ в массив
    ordersBorn[0]['orderItems'].add({'Start' : timeStart.toString(), 'End' : timeEnd.toString(), 'postNum' : postNum, 'status': status, 'edit' : 1, 'selected' : false, 'carTypeSelected' : copyOrder['carTypeSelected'], 'carBrandSelected' : copyOrder['carBrandSelected'], 'carModelSelected' : copyOrder['carModelSelected'], 'selectedColor' : copyOrder['selectedColor'], 'carNumber' : copyOrder['carNumber'], 'carRegion' : copyOrder['carRegion'], 'personName' : copyOrder['personName'], 'personSyrname' : copyOrder['personSyrname'], 'personPatronym' : copyOrder['personPatronym'], 'personPhone' : copyOrder['personPhone'], 'staffSelected' : copyOrder['staffSelected'],  'jobds' :copyOrder['jobds']});
    keyRed.add(GlobalKey());
    setState(() {});
    changeTimeForView();
  }


  paintOrdersNonDragg(int index){
    var height = cellHeigth * (DateTime.parse(orders[0]['orderItems'][index]['End']).difference(DateTime.parse(orders[0]['orderItems'][index]['Start'])).inMinutes /60);
    var topmargin = cellHeigth * (DateTime.parse(orders[0]['orderItems'][index]['Start']).difference(dateTimeStart).inMinutes /60);
    return //заказ
      topmargin > 0 && height > 0 ?  Container(
          width:postWidth,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.fromLTRB(orders[0]['orderItems'][index]['postNum'] * postWidth,topmargin,0,0),
          child:GestureDetector(
          onTap: () {
            //workWithOrder(index);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => curentOrderInfo(index: index)));
          },
          onLongPress: (){
            setState(() {
              orders[0]['orderItems'][index]['edit'] == 1 ? orders[0]['orderItems'][index]['selected'] = !orders[0]['orderItems'][index]['selected'] : null;
            });
          },
          child:Container(
              decoration: BoxDecoration(
                color: (_colors[orders[0]['orderItems'][index]['status']]).withOpacity(0.5),
                border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              width:postWidth,
              height: height,
              alignment: Alignment.topCenter,
              child:Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: _colors[orders[0]['orderItems'][index]['status']],
                          border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(height <= 30 ? 10 : 0),
                            bottomRight: Radius.circular(height <= 30 ? 10 : 0),
                          ),
                        ),
                        width:height > 30 ? 10 : postWidth-1,
                        height: height > 30 ? 30 : height,
                      ),
                      Container(
                       decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        width:height > 30 ? postWidth-11 : 0,
                        height: height < 30 ? 0 : 30,
                        child: Text('${orders[0]['orderItems'][index]['carNumber']} | ${orders[0]['orderItems'][index]['carRegion']}', style:orderBrickTitle)
                      )
                    ],
                  ),
                  height > cellHeigth ? Container(
                      alignment: Alignment.topLeft,
                      width:postWidth,
                      height: height - cellHeigth,
                      margin: EdgeInsets.fromLTRB(0,35,0,0),
                      padding: EdgeInsets.fromLTRB(5,5,5,5),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text: '· ${orders[0]['orderItems'][index]['carTypeSelected']}\n',
                            style:  TextStyle(fontSize: 13,fontFamily: 'Roboto', color: Color(0xFF000000)),
                            children: <TextSpan>[
                              TextSpan(text: '· ${orders[0]['orderItems'][index]['carBrandSelected']} ${orders[0]['orderItems'][index]['carModelSelected']}\n\n', style: TextStyle(fontSize: 13,fontFamily: 'Roboto', color: Color(0xFF000000)),),
                              TextSpan(text: 'Цена\n', style: TextStyle(fontSize: 13,fontFamily: 'Roboto', color: grey),),
                              TextSpan(text: '${countBill(index)[0]-countBill(index)[1]} ₽\n\n', style: TextStyle(fontSize: 13,fontFamily: 'Roboto', color: Color(0xFF000000)),),
                              TextSpan(text: 'Исполнитель\n', style: TextStyle(fontSize: 13,fontFamily: 'Roboto', color: grey),),
                              TextSpan(text: '${orders[0]['orderItems'][index]['staffSelected']}', style: TextStyle(fontSize: 13,fontFamily: 'Roboto', color: Color(0xFF000000)),),
                            ]),
                      )
                  ) : Container(),
                  Container(
                      alignment:Alignment.topCenter,
                      margin: EdgeInsets.fromLTRB(0,height - 15 > 0 ? height - 15 : 0,0,0),
                      child:ManipulatingBall(
                        onDrag: (dx, dy) {
                          var newHeight = dy;
                          if(newHeight > 0) {
                            if(index+1 < ordersBorn[0]['orderItems'].length) {
                              //проверяем чтоб не залазило на верхнюю ячейку
                              ordersBorn[0]['orderItems'][index+1]['postNum'] == ordersBorn[0]['orderItems'][index]['postNum'] && DateTime.parse(
                                  ordersBorn[0]['orderItems'][index]['End'])
                                  .add(
                                  Duration(minutes: 1)).isBefore(DateTime.parse(
                                  ordersBorn[0]['orderItems'][index+1]['Start'])) ? ordersBorn[0]['orderItems'][index]['End'] =
                                  DateTime.parse(
                                      ordersBorn[0]['orderItems'][index]['End'])
                                      .add(
                                      Duration(minutes: 1))
                                      .toString() : null;
                              ordersBorn[0]['orderItems'][index+1]['postNum'] != ordersBorn[0]['orderItems'][index]['postNum'] ? ordersBorn[0]['orderItems'][index]['End'] =
                                  DateTime.parse(
                                      ordersBorn[0]['orderItems'][index]['End'])
                                      .add(
                                      Duration(minutes: 1))
                                      .toString() : null;

                            }else{
                              //проверяем чтоб было не раньше расчетного периода
                              DateTime.parse(
                                  ordersBorn[0]['orderItems'][index]['End'])
                                  .add(
                                  Duration(minutes: 1)).isBefore(dateTimeEnd) ? ordersBorn[0]['orderItems'][index]['End'] =
                                  DateTime.parse(
                                      ordersBorn[0]['orderItems'][index]['End'])
                                      .add(
                                      Duration(minutes: 1))
                                      .toString() : null;
                            }
                          }else{
                            ordersBorn[0]['orderItems'][index]['End'] =
                                DateTime.parse(
                                    ordersBorn[0]['orderItems'][index]['End']).add(
                                    Duration(minutes: -1)).toString();
                          }
                          changeTimeForView();
                        },
                      )
                  ),
                ])
          )
      )) : Container();
  }



  paintOrderDragg(int index){
    var height = cellHeigth * (DateTime.parse(orders[0]['orderItems'][index]['End']).difference(DateTime.parse(orders[0]['orderItems'][index]['Start'])).inMinutes /60);
    var topmargin = cellHeigth * (DateTime.parse(orders[0]['orderItems'][index]['Start']).difference(dateTimeStart).inMinutes /60);

    return topmargin > 0 && height > 0 ? orders[0]['orderItems'][index]['edit'] == 1 ? GestureDetector(
        onTap: () {
          //workWithOrder(index); //пока не важно
        },
        onLongPress: (){
          setState(() {
            orders[0]['orderItems'][index]['selected'] = !orders[0]['orderItems'][index]['selected'];
          });
        },
        child:Draggable(
          data: '$index',
          child: GestureDetector(
                  onTap: () {
                    //workWithOrder(index);
                  },
                  onLongPress: (){
                    setState(() {
                      orders[0]['orderItems'][index]['edit'] == 1 ? orders[0]['orderItems'][index]['selected'] = !orders[0]['orderItems'][index]['selected'] : null;
                    });
                  },
                  child:Container(
                      decoration: BoxDecoration(
                        color: (_colors[orders[0]['orderItems'][index]['status']]).withOpacity(0.5),
                        border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width:postWidth,
                      height: height,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.fromLTRB(orders[0]['orderItems'][index]['postNum'] * postWidth,topmargin,0,0),
                      child:Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: _colors[orders[0]['orderItems'][index]['status']],
                                  border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(height <= 30 ? 10 : 0),
                                    bottomRight: Radius.circular(height <= 30 ? 10 : 0),
                                  ),
                                ),
                                width:height > 30 ? 10 : postWidth-1,
                                height: height > 30 ? 30 : height,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                  alignment: Alignment.center,
                                width:height > 30 ? postWidth-11 : 0,
                                height: height < 30 ? 0 : 30,
                                  child: Text('${orders[0]['orderItems'][index]['carNumber']} | ${orders[0]['orderItems'][index]['carRegion']}', style:orderBrickTitle)
                              )
                            ]),

                        ])
                  )
              ),
          feedback: Container(
              decoration: BoxDecoration(
                color: (_colors[orders[0]['orderItems'][index]['status']]).withOpacity(0.5),
                border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              width:postWidth,
              height: height,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(orders[0]['orderItems'][index]['postNum'] * postWidth,topmargin,0,0),
              child:Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          key: keyRed[index],
                          decoration: BoxDecoration(
                            color: _colors[orders[0]['orderItems'][index]['status']],
                            border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(height <= 30 ? 10 : 0),
                              bottomRight: Radius.circular(height <= 30 ? 10 : 0),
                            ),
                          ),
                          width:height > 30 ? 10 : postWidth-1,
                          height: height > 30 ? 30 : height,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: (_colors[orders[0]['orderItems'][index]['status']]).withOpacity(0.5),
                            border: Border.all(color: Colors.grey,width: 0.5,style: BorderStyle.solid),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          width:height > 30 ? postWidth-11 : 0,
                          height: height > 30 ? 0 : 30,
                        )
                      ],
                    )
                  ])
          ),
          childWhenDragging: Container(),
          onDragEnd: (data){
            changePosition(index);
          },
        )
    ) :  Container() : Container();
  }



  var _valueX;
  var _valueY;
  paintAddOrderPole(){
    return //полe для добавления заказа
      GestureDetector(
        onTapDown:(value){
          _valueX = value.localPosition.dx; _valueY = value.localPosition.dy;
        } ,
        onLongPress:(){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => speedOrderMain(X:_valueX, Y:_valueY)));
         // addOrder(_valueX, _valueY);
        } ,//switch to draggable mode
        child: Container(
          margin: EdgeInsets.fromLTRB(35,35,0,0),
          width: postWidth * orders[0]['postCol'],
          height: cellHeigth * timePeriodinMinute,
          color: Colors.white,
          child: Stack(
            children: [
              //горизонтальные полоски
              Container(
                margin: EdgeInsets.fromLTRB(0,0,0,0),
                width: postWidth * ordersBorn[0]['postCol'], //количество постов * 30 пикселей (ширина блока) сейчас 3 поста * 30 пикселей
                height: cellHeigth * timePeriodinMinute, //отображать определенное количество часов
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: timePeriodinMinute,
                    itemBuilder: (context, index) {
                      return Container(
                        width: postWidth * ordersBorn[0]['postCol'],
                        height: cellHeigth,
                        alignment: Alignment.topLeft,
                        child: Divider(height: 1,thickness: 0.5,color: Colors.black,),
                      );}),
              ),
              //вертикальные полосы
              Container(
                margin: EdgeInsets.fromLTRB(0,0,0,0),
                width: postWidth * ordersBorn[0]['postCol'], //количество постов * 30 пикселей (ширина блока) сейчас 3 поста * 30 пикселей
                height: cellHeigth * timePeriodinMinute, //отображать определенное количество часов
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: ordersBorn[0]['postCol'],
                    itemBuilder: (context, index) {
                      return Container(
                          width: postWidth,
                          height: cellHeigth * timePeriodinMinute,
                          alignment: Alignment.topLeft,
                          child: VerticalDivider(width: 1,thickness: 0.5,color: Colors.black,)
                      );}),
              ),
            ],
          ),
        ),
      );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key? key, required this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

