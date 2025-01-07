import 'package:flutter/material.dart';

class AdminRemarkView extends StatelessWidget {
  const AdminRemarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Remark View'),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Text('Remark management page'),
      ),
    );
  }
}