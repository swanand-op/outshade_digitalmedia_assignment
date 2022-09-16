import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outshade_digitalmedia_assignment/display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users list',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List _users = [];

  Future getUser() async {
    final String response = await rootBundle.loadString('jsonFlies/users.json');
    final data = await json.decode(response);
    setState(() {
      _users = data["users"];
    });
    return _users;
  }

  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Enter your information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: ageController,
            decoration: InputDecoration(
              hintText: 'Enter your age'
            ),
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
                hintText: 'Enter your age'
            ),
          )
        ],
      ),
      actions: [
        TextButton(onPressed: (){}, child: Text('Submit'))
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users list', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot){
              if(snapshot.data == null){
                return Container(child: Center(child: Text('Loading'),),);
              }else{
                return ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Text(_users[index]["id"]),
                      title: Text(_users[index]["name"]),
                      trailing: ElevatedButton(
                        onPressed: () {
                          openDialog();
                          User user = User(id: _users[index]["id"], name: _users[index]["name"], age: ageController.text, gender: genderController.text);
                          },
                        child: Text('Sign in'),
                      ),
                    );
                  }
                );
              }
            }
          ),
        ),
      ),
    );
  }
}


void _navigateToFillData(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FillData()));
}

class User {
  final String id, name, age, gender;
  User({required this.id, required this.name, required this.age, required this.gender});
}