import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:jodi/styleguide/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tinderImages = [
    "assets/images/anne.jpeg",
    "assets/images/rena.jpeg",
    "assets/images/rona.jpeg",
    "assets/images/anne.jpeg",
    "assets/images/rena.jpeg",
    "assets/images/rona.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Start Swiping',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: TinderSwapCard(
                orientation: AmassOrientation.TOP,
                totalNum: 6,
                stackNum: 3,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.8,
                cardBuilder: (context, index) => Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      '${tinderImages[index]}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  elevation: 10,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 21),
                  onPressed: () {},
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.pinkAccent,
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  onPressed: () {},
                  child: Text(
                    'MATCH',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.pinkAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
