import 'package:flutter/material.dart';

class AdminWidowView extends StatelessWidget {
  const AdminWidowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Widow View'),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Text('Widow management page'),
      ),
    );
  }
}