import 'package:contactbook/database.dart';
import 'package:contactbook/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class second extends StatefulWidget {
  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  TextEditingController name = TextEditingController();
  TextEditingController comp = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone1 = TextEditingController();

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;

  @override
  Widget build(BuildContext context) {
    double totalewidth = MediaQuery.of(context).size.width;
    double totaleheight = MediaQuery.of(context).size.height;

    double stbarheight = MediaQuery.of(context).padding.top;
    double nvbarheight = MediaQuery.of(context).padding.bottom;
    double bodyheight = totaleheight - stbarheight - nvbarheight;

    return WillPopScope(
        onWillPop: () {
          showDialog(
              builder: (context) {
                return AlertDialog(
                  title: Text("Are you sure Exit"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return first();
                            },
                          ));
                        },
                        child: Text("yes")),
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"))
                  ],
                );
              },
              context: context);
          return Future.value();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: totaleheight,
                      alignment: Alignment.center,
                      child: Text(
                        "New Contact",
                        style: TextStyle(fontSize: totalewidth * 0.055),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        String name1 = name.text;
                        String comp1 = comp.text;
                        String title1 = title.text;
                        String phone1 = phone.text;
                        value1 = false;
                        value2 = false;
                        value3 = false;
                        value4 = false;

                        if (name1.isEmpty) {
                          value1 = true;
                        } else if (comp1.isEmpty) {
                          value2 = true;
                        } else if (title1.isEmpty) {
                          value3 = true;
                        } else if (phone1.isEmpty) {
                          value4 = true;
                        } else {
                          database.inserdata(name1,comp1,title1,phone1,db!);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return first();
                          },));
                        }
                      });
                    },
                    child: Container(
                      height: totaleheight * 0.05,
                      width: totalewidth * 0.075,
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.check),
                    ),
                  )
                ],
              )
            ]),
          ),
          body: Container(
            color: Colors.black,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.03,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.005,
                          alignment: Alignment.center,
                          child: Icon(Icons.people, color: Colors.white60),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white60))),
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.10,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.80,
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                                errorText: value1 ? "enter name" : null,
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.white60)),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: totaleheight * 0.024,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.03,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.005,
                          alignment: Alignment.center,
                          child: Icon(Icons.add_business_rounded,
                              color: Colors.white60),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white60))),
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.10,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.80,
                          child: TextField(
                            controller: comp,
                            decoration: InputDecoration(
                                errorText: value2 ? "enter company name" : null,
                                labelText: "Company",
                                labelStyle: TextStyle(color: Colors.white60)),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: totaleheight * 0.024,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white60))),
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.15,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.80,
                          child: TextField(
                            controller: title,
                            decoration: InputDecoration(
                                errorText: value3 ? "enter title" : null,
                                labelText: "Title",
                                labelStyle: TextStyle(color: Colors.white60)),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: totaleheight * 0.024,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.03,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.005,
                          alignment: Alignment.center,
                          child: Icon(Icons.call, color: Colors.white60),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white60))),
                          margin: EdgeInsets.only(
                              left: totalewidth * 0.10,
                              top: totaleheight * 0.03),
                          height: totaleheight * 0.080,
                          width: totalewidth * 0.80,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            autofillHints: [AutofillHints.telephoneNumber],
                            controller: phone,
                            decoration: InputDecoration(
                                errorText: value4 ? "enter phone number" : null,
                                labelText: "Phone",
                                labelStyle: TextStyle(color: Colors.white60)),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: totaleheight * 0.024,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ));

  }
Database? db;
  @override
  void initState() {
    super.initState();
    get();
  }

  void get() {
    database().getdata().then((value) {
      setState(() {
        db = value;
      });
    });
  }
}
