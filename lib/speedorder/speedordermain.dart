import 'dart:async';
import 'package:carwash/order/automotivenum.dart';
import 'package:carwash/order/jobselect.dart';
import 'package:carwash/order/ordermain.dart';
import 'package:carwash/profile/profilemain.dart';
import 'package:carwash/table/tablemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../styles.dart';


var _date = DateTime.now();
var _timeStart = DateTime.now();

List _showDec =[];


class speedOrderMain extends StatefulWidget {
  final double X;
  final double Y;

  speedOrderMain({
    this.X = 0.0,
    this.Y = 0.0,
  });


  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<speedOrderMain> {
  @override
  FutureOr onGoBack(dynamic value) {

    setState(() {});
  }

  selectJobs(){
    var jobsList=[];
    for(int i = 0; i < jobs.length; i++){
      jobs[i]['select'] == true ? jobsList.add(jobs[i]) : null;
    }
    return jobsList;
  }

  addOrder(double dX, double dY){
    //в каой столбеу(пост) размещать заказ
    var postNum = (dX / postWidth).round() -1 ;//ok
    //вычисляем время начала заказа в зависимости от того куда нажали
    //var timeStart = _timeStart.difference(timeStart) <> 0 ? _timeStart = dateTimeStart.add(Duration(minutes: (((( (dY-cellHeigth +15) * timePeriodinMinute ) / (cellHeigth*timePeriodinMinute)*60)+8).toInt())));
    var timeStart = _timeStart;
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
      ordersBorn[0]['orderItems'].add({'Start' : timeStart.toString(), 'End' : timeEnd.toString(), 'postNum' : postNum, 'status': 0, 'edit' : 1, 'selected' : false, 'carTypeSelected' : carTypeSelected, 'carBrandSelected' : 'Не выбран', 'carModelSelected' : 'Не выбран', 'selectedColor' : 0, 'carNumber' : carNumber, 'carRegion' : carRegion, 'personName' : '', 'personSyrname' : '', 'personPatronym' : '', 'personPhone' : '', 'staffSelected' : 'Петрова А.И.',  'jobds' : selectJobs()});
      keyRed.add(GlobalKey());
      Navigator.pushReplacement (context,
          MaterialPageRoute(builder: (context) => freeSize()));
    } else {
      //сообщение об ошибке
      return showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.transparent,
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
                  alignment: Alignment.center,
                  child: Container(
                      width: 250,
                      //height: 250
                      height: 300,
                      margin: EdgeInsets.fromLTRB(20,20,20,20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(16.5),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.fromLTRB(20,20,20,20),
                      child:  Column(
                          children: <Widget>[
                            Text('В указанное время заказ не может быть добавлен в выранный на предидущем экране пост', textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0, color: Color(0xFF304655)),),

                            SizedBox(height: 10,),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.fromLTRB(0,10,0,0),
                              child: TextButton(
                                onPressed:(){
                                  Navigator.of(context).pop();
                                } ,
                                child: Text('Закрыть', style: TextStyle(fontSize: 16.0, color: Color(0xFF304655)),textAlign: TextAlign.center,),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  minimumSize: Size(MediaQuery.of(context).size.width, 20),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                ),
                              ),
                            ),
                          ])
                  ),
                )
            );
          });
    }
    //setState(() {});
    //changeTimeForView();
  }
  

  @override
  void initState() {
    super.initState();
    for(int i =0; i < jobs.length; i++){
      _showDec.add(false);
    }
    _timeStart = dateTimeStart.add(Duration(minutes: (((( (widget.Y-cellHeigth +15) * timePeriodinMinute ) / (cellHeigth*timePeriodinMinute)*60)+8).toInt())));
    //addOrder(widget.X, widget.Y);
  }

  countBill(){
    List summ = [0.0,0.0];
    for(int i = 0; i < jobs.length; i++){
      jobs[i]['select'] == true ? summ[0] = summ[0] + jobs[i]['price'] : null;
      jobs[i]['select'] == true ? summ[1] = summ[1] + jobs[i]['price'] * jobs[i]['discount'] : null;
    }
    return summ;
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
          title: Text('Быстрая запись', style: boldText),
          actions: []
      ),
      body: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(20,10,20,0),
          width: MediaQuery.of(context).size.width,
            height: 90,
            color: Colors.white,
            alignment: Alignment.center,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text('Время начала', style: nameSubTitleDark ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Text('Часы', style: nameSubTitleDark ),
                      Container(
                        height: 50,
                        width: 70,
                        margin: const EdgeInsets.fromLTRB(20,0,20,0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                          color: filterButton,
                        ),
                        child: TextButton(
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
                              DateFormat.H('ru').format(_timeStart),
                              style: TextStyle(fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w500, color: Color(0xFF4F4F4F)),
                            )),),
                    ]),
                Text(':', style: nameSubTitleDark ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text('Минуты', style: nameSubTitleDark ),
                Container(
                  height: 50,
                  width: 70,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(20,0,20,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                    color: filterButton,
                  ),
                  child: TextButton(
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
                        DateFormat.m('ru').format(_timeStart),
                        style: TextStyle(fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w500, color: Color(0xFF4F4F4F)),
                      )),),
                    ]),
              ],
            )),
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
                        child: Text('Основная информация', style: taskTitle ),
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
                                            _date = date;
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
                  separatorBuilder: (context, index) => jobs[index]['select'] == true ? Container(
                    color: Color(0xFFFFFFFF),
                    child:Container(
                      color: Color(0xFFFFFFFF),
                      margin: const EdgeInsets.fromLTRB(70,0,20,0), child:Divider(height: 1,thickness: 0.5,color: lightGrey,),),) : Container(),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) => jobs[index]['select'] == true ? Container(
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
                                        Text(jobs[index]['name'], style: nameSubTitle),
                                        Spacer(),
                                        Text('${jobs[index]['price'].toString()} ₽', style: nameSubTitleDark ),
                                        SizedBox(width:5),
                                        GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                jobs[index]['select'] = !jobs[index]['select'];
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
                              child: Text(jobs[index]['description'], style: nameSubTitle),
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


                SizedBox(height: 100,)
              ]),

        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20,0,20,40),
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        height: 48,
        width: MediaQuery.of(context).size.width - 40,
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed:(){
            addOrder(widget.X, widget.Y);
          } ,
          child: Text('Записать', style: buttonText,textAlign: TextAlign.center,),
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