import 'package:carwash/profile/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

bool _edit = true;
bool emailSw = false;
bool whatsappSw = false;
bool telegramSw = false;
bool newOrder = false;
bool newFeed = false;
bool delOrder = false;
bool newComment = false;
bool tuneOrders = false;
bool tuneStaff = false;
bool tuneSale = false;
bool tunePrice = false;
bool tuneInfo = false;

class notifEdit extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<notifEdit> {


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
          title: Text('Уведомления', style: boldText),
          actions: []
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
                  child: Text('Способ получения уведомлений', style: taskTitle ),
                ),
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
                              Text('E-mail', style: nameSubTitle ),
                              Spacer(),
                        Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                                value: emailSw,
                                onChanged: (value) {
                                  setState(() {
                                    emailSw = value;
                                  });
                                },
                                //activeTrackColor: Colors.yellow,
                                activeColor: Color(0xFF32D74B),
                              ),
                        ),
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
                              Text('Whatsapp', style: nameSubTitle ),
                              Spacer(),
                              Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: whatsappSw,
                                  onChanged: (value) {
                                    setState(() {
                                      whatsappSw = value;
                                    });
                                  },
                                  //activeTrackColor: Colors.yellow,
                                  activeColor: Color(0xFF32D74B),
                                ),
                              ),
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
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: telegramSw,
                            onChanged: (value) {
                              setState(() {
                                telegramSw = value;
                              });
                            },
                            //activeTrackColor: Colors.yellow,
                            activeColor: Color(0xFF32D74B),
                          ),
                        ),
                            ])
                    )
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                SizedBox(height: 22,),
                Container(
                  margin: const EdgeInsets.fromLTRB(30,0,0,10),
                  alignment: Alignment.centerLeft,
                  child: Text('События', style: taskTitle ),
                ),
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
                              Text('Новый заказ', style: nameSubTitle ),
                              Spacer(),
                              Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: newOrder,
                                  onChanged: (value) {
                                    setState(() {
                                      newOrder = value;
                                    });
                                  },
                                  //activeTrackColor: Colors.yellow,
                                  activeColor: Color(0xFF32D74B),
                                ),
                              ),
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
                              Text('Об удалении заказ', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                  activeColor: Color(0xFF32D74B),
                                  value: delOrder,
                                  onChanged: (newValue) {
                                    setState(() {
                                      delOrder = newValue!;
                                    });
                                  },
                                )
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
                              Text('О новом отзыве', style: nameSubTitle ),
                              Spacer(),
                              Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: newFeed,
                                  onChanged: (value) {
                                    setState(() {
                                      newFeed = value;
                                    });
                                  },
                                  //activeTrackColor: Colors.yellow,
                                  activeColor: Color(0xFF32D74B),
                                ),
                              ),
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
                              Text('О новом коментарии', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF32D74B),
                                value: newComment,
                                onChanged: (newValue) {
                                  setState(() {
                                    newComment = newValue!;
                                  });
                                },
                              )
                            ])
                    )
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
                SizedBox(height: 22,),
                Container(
                  margin: const EdgeInsets.fromLTRB(30,0,0,10),
                  alignment: Alignment.centerLeft,
                  child: Text('Изменения настроек', style: taskTitle ),
                ),
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
                              Text('Записи', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF32D74B),
                                value: tuneOrders,
                                onChanged: (newValue) {
                                  setState(() {
                                    tuneOrders = newValue!;
                                  });
                                },
                              )
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
                              Text('Персонала', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF32D74B),
                                value: tuneStaff,
                                onChanged: (newValue) {
                                  setState(() {
                                    tuneStaff = newValue!;
                                  });
                                },
                              )
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
                              Text('Скидок', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF32D74B),
                                value: tuneSale,
                                onChanged: (newValue) {
                                  setState(() {
                                    tuneSale = newValue!;
                                  });
                                },
                              )
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
                              Text('Прайс листа', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF32D74B),
                                value: tunePrice,
                                onChanged: (newValue) {
                                  setState(() {
                                    tunePrice = newValue!;
                                  });
                                },
                              )
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
                              Text('Информация об автомойке', style: nameSubTitle ),
                              Spacer(),
                              Checkbox(
                                checkColor: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF32D74B),
                                value: tuneInfo,
                                onChanged: (newValue) {
                                  setState(() {
                                    tuneInfo = newValue!;
                                  });
                                },
                              )
                            ])
                    )
                ),
                Divider(height: 1,thickness: 0.5,color: lightGrey,),
              ]),
        ),
      ),
    );
  }

}
