import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart'; 


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'My App',storage: CounterStorage(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final CounterStorage storage;
  MyHomePage({Key key, this.title, @required this.storage}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter;
 @override
 void initState(){
   super.initState();
   widget.storage.readCounter().then((int value){
     setState(() {
       _counter = value ;
     });

   });
 }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
   widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: new ListView.builder(
        itemCount: _counter,
        itemBuilder: (context, index){
          return ListTile(
            leading: const Icon(Icons.check_circle),
            title: Text('Name of the Item'),
            subtitle: Text("nirav"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => SecondPage()));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage  extends StatelessWidget{
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Add Contact"),
    ),
   body: new Column(
     children: <Widget>[
        TextField(
        obscureText: true,
        decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contact Name',
      ),
      ),
      TextField(
        obscureText: true,
        decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contact Number',
      ),
      ),
    
    ],
  ),
  );
}

}


class CounterStorage {
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async{
    try{
      final file = await _localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    }catch(e){
      //if no data 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async{
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
}