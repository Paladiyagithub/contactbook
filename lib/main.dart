import 'dart:io';

import 'package:contactbook/database.dart';
import 'package:contactbook/edit.dart';
import 'package:contactbook/seconpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  bool search = false;

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
                          exit(0);
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
        child: SafeArea(
          child: Scaffold(
            appBar: search
                ? AppBar(
                    backgroundColor: Colors.black,
                    title: Container(
                      height: 50,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    search = false;
                                    searchlist = list1;
                                  });
                                },
                                icon: Icon(Icons.close,size: 30,))),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              searchlist = list1;
                              searchlist = [];
                              for (int i = 0; i < list1.length; i++) {
                                String name = list1[i]['name'];
                                if (name.toLowerCase().contains(value.toLowerCase())) {
                                  searchlist.add(list1[i]);
                                  print("==============$searchlist");
                                }
                              }
                            } else {
                              search = false;
                              searchlist = list1;
                            }
                          });
                        },
                      ),
                    ),
                  )
                : AppBar(
                    backgroundColor: Colors.black,
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: totaleheight * 0.008,
                                  top: totaleheight * 0.01),
                              child: Text("Contacts",
                                  style: TextStyle(
                                      fontSize: totaleheight * 0.050)),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: totaleheight * 0.045,
                                      top: totaleheight * 0.012),
                                  child: Icon(Icons.check_box)),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    search = true;
                                  });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: totaleheight * 0.030,
                                        top: totaleheight * 0.012),
                                    child: Icon(Icons.search)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: totaleheight * 0.030,
                                      top: totaleheight * 0.012),
                                  child: Icon(Icons.more_vert_sharp)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
            body: ListView.builder(
              itemCount: search ? searchlist.length : list1.length,
              itemBuilder: (context, index) {
                Map map = search ? searchlist[index] : list1[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 15,
                  shadowColor: Colors.black,
                  child: ListTile(
                      subtitle: Text("${map['number']}"),
                      title: Text("${map['name']}"),
                      trailing: PopupMenuButton(
                        onSelected: (int v) {
                          id = list1[index]['ID'];
                          if (v == 1) {
                            setState(() {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return editfill(id!, list1, index);
                                },
                              ));
                            });
                          }
                          if (v == 2) {
                            setState(() {
                              database.delete(db!, id!);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return first();
                                },
                              ));
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Edit"),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text("Delete"),
                            value: 2,
                          ),
                        ],
                      )),
                );
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.indigoAccent,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return second();
                    },
                  ));
                },
                label: Icon(
                  Icons.add,
                )),
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdata();
  }

  int? id;
  Database? db;
  List<Map> list1 = [];
  List searchlist = [];

  void viewdata() {
    database().getdata().then((value) {
      setState(() {
        db = value;
        print("-------------$db");
      });
      database().viewdatabase(db!).then((listofmap) {
        list1 = listofmap;
        searchlist = listofmap;
        print("+++++++++++++++$list1");
      });
    });
  }
}
