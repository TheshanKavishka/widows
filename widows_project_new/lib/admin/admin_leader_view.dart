import 'package:flutter/material.dart';

class AdminLeaderView extends StatelessWidget {
  const AdminLeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Leader View'),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Text('Leader management page'),
      ),
    );
  }
}