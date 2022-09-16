import 'package:flutter/material.dart';

class FillData extends StatefulWidget {
  const FillData({Key? key}) : super(key: key);

  @override
  State<FillData> createState() => _FillDataState();
}

class _FillDataState extends State<FillData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter details'),
        centerTitle: true,
      ),
      body: Center(

      ),
    );
  }
}
