import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_graph/barchart/bar_chart/samples/bar_chart_sample1.dart';

BarChartSample1State _barChartSample1 = new BarChartSample1State();

class DropDown extends StatefulWidget {
  // final Function callback;
  // DropDown({this.callback}) : super();

  @override
  DropDownState createState() => DropDownState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Monday'),
      Company(2, 'Tuesday'),
      Company(3, 'Wednesday'),
      Company(4, 'Thursday'),
      Company(5, 'Friday'),
      Company(4, 'Saturday'),
      Company(7, 'Sunday'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  final databaseReference = Firestore.instance;

  static int _n = 0;
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
  static String day = "Monday";

  void upload() async {
    debugPrint("Upload");
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.toString();
    await databaseReference.collection("User").document(day).setData({
      "value": _n,
    });
    debugPrint("$day  $_n");
    debugPrint("End Upload");

    // if (this.widget.callback != null) this.widget.callback(l);
  }

  void add() {
    setState(() {
      if (_n != 20) {
        _n++;
      }
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) {
        _n--;
      }
    });
  }

  //

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
      day = _selectedCompany.name;
      _n = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Color(0xff132240),
        body: new Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14),
                  ),
                  Text(
                    "Select day",
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                  ),
                  Container(
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white, width: 3.0)),
                    child: Container(
                      color: Colors.white24,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value: _selectedCompany,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropdownItem,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                  ),
                  Container(
                      child: new Center(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: add,
                          child: new Icon(Icons.add,
                              color: Colors.black, size: 28.0),
                          backgroundColor: Colors.white,
                        ),
                        new Text('$_n',
                            style: new TextStyle(
                                fontSize: 28.0, color: Colors.white)),
                        new FloatingActionButton(
                          onPressed: minus,
                          child: new Icon(
                              const IconData(0xe15b,
                                  fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                              size: 28.0),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8),
                  ),
                  BarChartSample1(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
