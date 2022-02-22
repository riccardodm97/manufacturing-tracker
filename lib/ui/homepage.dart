import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food Traceability'),
          backgroundColor: Colors.grey[900],
        ),
        body: Container(
          color: Colors.grey[800],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/upload');
                    },
                    child: Text('Add product'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[400],
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/download');
                    },
                    child: Text('Get product'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[400],
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/saved');
                    },
                    child: Text('My products'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[400],
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ),
        ));
  }
}
