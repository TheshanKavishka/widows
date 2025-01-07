import 'package:flutter/material.dart';
import 'admin_user_view.dart';
import 'admin_widow_view.dart';
import 'admin_remark_view.dart';
import 'admin_leader_view.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isDarkMode = false; // Dark mode toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: isDarkMode ? Colors.amber : Colors.amber,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle, size: 28),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.amber,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Admin Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.dark_mode,
                color: isDarkMode ? Colors.amber : Colors.grey,
              ),
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.black : Colors.black,
                ),
              ),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.black : Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pop(context); // Navigate back to the login page
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to AdminUserView page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminUserView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.amber,
                minimumSize: const Size(double.infinity, 50), // Full-width button
              ),
              child: Text(
                'Users',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Leaders page (to be implemented)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminLeaderView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.amber,
                minimumSize: const Size(double.infinity, 50), // Full-width button
              ),
              child: Text(
                'Leaders',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to AdminWidowView page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminWidowView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.amber,
                minimumSize: const Size(double.infinity, 50), // Full-width button
              ),
              child: Text(
                'Widows',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to AdminRemarkView page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminRemarkView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.amber,
                minimumSize: const Size(double.infinity, 50), // Full-width button
              ),
              child: Text(
                'Remarks',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}