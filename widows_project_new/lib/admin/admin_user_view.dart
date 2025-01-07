import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminUserView extends StatefulWidget {
  const AdminUserView({Key? key}) : super(key: key);

  @override
  State<AdminUserView> createState() => _AdminUserViewState();
}

class _AdminUserViewState extends State<AdminUserView> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<User> users = []; // List of User objects
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      // Fetch users directly
      final List<User> fetchedUsers = await supabase.auth.admin.listUsers();
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch users: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin User View'),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? const Center(
        child: Text('No users found'),
      )
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(user.email ?? 'No Email'),
              subtitle: Text('ID: ${user.id}'),
            ),
          );
        },
      ),
    );
  }
}
