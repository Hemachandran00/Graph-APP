import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../fl_chart.dart';

class BarChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;
  static BarChartGroupData barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7;
  int touchedGroupIndex;

  List lis = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List lis1 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  final Duration animDuration = Duration(milliseconds: 250);
  final databaseReference = Firestore.instance;
  List<BarChartGroupData> items = [
    barGroup1,
    barGroup2,
    barGroup3,
    barGroup4,
    barGroup5,
    barGroup6,
    barGroup7,
  ];

  void value2() async {
    lis = [];
    debugPrint("Value");
    await databaseReference
        .collection('chart')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        debugPrint('${f.documentID} ${f.data}');
        lis.add(f.data['value']);
      });
    });
    setState(() {
      lis1[0] = lis[0].toDouble();
      lis1[1] = lis[1].toDouble();
      lis1[2] = lis[2].toDouble();
      lis1[3] = lis[3].toDouble();
      lis1[4] = lis[4].toDouble();
      lis1[5] = lis[5].toDouble();
      lis1[6] = lis[6].toDouble();
      lis1[7] = lis[7].toDouble();
      lis1[8] = lis[8].toDouble();
      lis1[9] = lis[9].toDouble();
      lis1[10] = lis[10].toDouble();
      lis1[11] = lis[11].toDouble();
      lis1[12] = lis[12].toDouble();
      lis1[13] = lis[13].toDouble();
    });
    barGroup1 = makeGroupData(0, lis1[0], lis1[1]);
    barGroup2 = makeGroupData(1, lis1[2], lis1[3]);
    barGroup3 = makeGroupData(2, lis1[4], lis1[5]);
    barGroup4 = makeGroupData(3, lis1[6], lis1[7]);
    barGroup5 = makeGroupData(4, lis1[8], lis1[9]);
    barGroup6 = makeGroupData(5, lis1[10], lis1[11]);
    barGroup7 = makeGroupData(6, lis1[12], lis1[13]);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    debugPrint("Ended value");
  }

  @override
  void initState() {
    super.initState();
    value2();
    barGroup1 = makeGroupData(0, 0, 0);
    barGroup2 = makeGroupData(1, 0, 0);
    barGroup3 = makeGroupData(2, 0, 0);
    barGroup4 = makeGroupData(3, 0, 0);
    barGroup5 = makeGroupData(4, 0, 0);
    barGroup6 = makeGroupData(5, 0, 0);
    barGroup7 = makeGroupData(6, 0, 0);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    debugPrint("Ended value");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
        ),
        Text(
          "Bar Chart",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: const Color(0xff2c4260),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      makeTransactionsIcon(),
                      const SizedBox(
                        width: 38,
                      ),
                      Text(
                        'Transactions',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'state',
                        style: TextStyle(
                            color: const Color(0xff77839a), fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        BarChartData(
                          maxY: 20,
                          barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.grey,
                                getTooltipItem: (_a, _b, _c, _d) => null,
                              ),
                              touchCallback: (response) {
                                if (response.spot == null) {
                                  setState(() {
                                    touchedGroupIndex = -1;
                                    showingBarGroups = List.of(rawBarGroups);
                                  });
                                  return;
                                }

                                touchedGroupIndex =
                                    response.spot.touchedBarGroupIndex;

                                setState(() {
                                  if (response.touchInput is FlLongPressEnd ||
                                      response.touchInput is FlPanEnd) {
                                    touchedGroupIndex = -1;
                                    showingBarGroups = List.of(rawBarGroups);
                                  } else {
                                    showingBarGroups = List.of(rawBarGroups);
                                    if (touchedGroupIndex != -1) {
                                      double sum = 0;
                                      for (BarChartRodData rod
                                          in showingBarGroups[touchedGroupIndex]
                                              .barRods) {
                                        sum += rod.y;
                                      }
                                      final avg = sum /
                                          showingBarGroups[touchedGroupIndex]
                                              .barRods
                                              .length;

                                      showingBarGroups[touchedGroupIndex] =
                                          showingBarGroups[touchedGroupIndex]
                                              .copyWith(
                                        barRods:
                                            showingBarGroups[touchedGroupIndex]
                                                .barRods
                                                .map((rod) {
                                          return rod.copyWith(y: avg);
                                        }).toList(),
                                      );
                                    }
                                  }
                                });
                              }),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              textStyle: TextStyle(
                                  color: const Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 20,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Mn';
                                  case 1:
                                    return 'Te';
                                  case 2:
                                    return 'Wd';
                                  case 3:
                                    return 'Tu';
                                  case 4:
                                    return 'Fr';
                                  case 5:
                                    return 'St';
                                  case 6:
                                    return 'Sn';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              textStyle: TextStyle(
                                  color: const Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 32,
                              reservedSize: 14,
                              getTitles: (value) {
                                if (value == 0) {
                                  return '1K';
                                } else if (value == 10) {
                                  return '5K';
                                } else if (value == 19) {
                                  return '10K';
                                } else {
                                  return '';
                                }
                              },
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
