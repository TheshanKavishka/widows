import 'package:flutter/material.dart';
import 'widow_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WidowPage extends StatefulWidget {
  const WidowPage({Key? key}) : super(key: key);

  @override
  State<WidowPage> createState() => _WidowPageState();
}

class _WidowPageState extends State<WidowPage> {
  bool isDarkMode = false;
  List<dynamic> widows = [];
  List<dynamic> filteredWidows = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWidows();
  }

  Future<void> fetchWidows() async {
    try {
      final response = await Supabase.instance.client.from('widows').select();

      if (response != null && response.isNotEmpty) {
        setState(() {
          widows = (response as List<dynamic>)
            ..sort((a, b) => (a['full_name'] ?? '').toLowerCase().compareTo((b['full_name'] ?? '').toLowerCase()));
          filteredWidows = widows;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  void filterWidows(String query) {
    final results = widows
        .where((widow) =>
        (widow['full_name'] ?? '').toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredWidows = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widow Page'),
        backgroundColor: isDarkMode ? Colors.amber : Colors.amber,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle, size: 28),
              onPressed: () {
                // Open the profile drawer or navigate to a profile page
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
                    'User Profile',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterWidows,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black),
                  hintText: 'Search names',
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredWidows.isEmpty
                  ? Center(
                child: Text(
                  'No data found',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: filteredWidows.length,
                itemBuilder: (context, index) {
                  final widow = filteredWidows[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidowDetails(
                              widow: widow,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: isDarkMode ? Colors.amber : Colors.grey,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            widow['full_name'] ?? 'No Name',
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
