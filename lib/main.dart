import 'package:flutter/material.dart';
import 'package:paranim/pages.dart';
import 'package:paranim/particle_blast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paranim'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: PageInfo.pages.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text('${PageInfo.title[index]}'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PageInfo.pages[index]
                ));
                },
            );
          }
      ),
    );
  }
}
