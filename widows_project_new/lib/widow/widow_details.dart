import 'package:flutter/material.dart';

class WidowDetails extends StatefulWidget {
  final Map<String, dynamic> widow;

  const WidowDetails({Key? key, required this.widow}) : super(key: key);

  @override
  State<WidowDetails> createState() => _WidowDetailsState();
}

class _WidowDetailsState extends State<WidowDetails> {
  bool isDarkMode = false; // Dark mode toggle

  // Mapping field names to professional labels
  final Map<String, String> fieldLabels = {
    'full_name': 'Full Name',
    'dob': 'Date of Birth',
    'age': 'Age',
    'address': 'Address',
    'area': 'Area',
    'contact_number': 'Contact Number',
    'nic': 'NIC',
    'status': 'Status',
    'occupation': 'Occupation',
    'no_of_children': 'Number of Children',
    'pcl_name': 'PCL Name',
    'time_period': 'Time Period',
  };

  @override
  Widget build(BuildContext context) {
    final widow = widget.widow; // Access widow details
    final imageUrl = widow['imagURL'] ?? ''; // Correct key name for image URL

    return Scaffold(
      appBar: AppBar(
        title: Text(widow['full_name'] ?? 'Details'),
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
      body: SingleChildScrollView(
        child: Container(
          color: isDarkMode ? Colors.black : Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display image with placeholder and error handling
              if (imageUrl.isNotEmpty)
                Image.network(
                  imageUrl,
                  height: 200, // Increased size
                  width: 200, // Increased size
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const CircleAvatar(
                      radius: 100, // Increased size
                      child: Icon(Icons.error, size: 100),
                    );
                  },
                )
              else
                const CircleAvatar(
                  radius: 100, // Increased size
                  child: Icon(Icons.person, size: 100),
                ),
              const SizedBox(height: 20),
              // Display details beautifully
              ...widow.entries
                  .where((entry) => entry.key != 'id' && entry.key != 'imagURL') // Exclude 'id' and 'imagURL'
                  .map((entry) {
                final label = fieldLabels[entry.key] ?? entry.key;
                final value = entry.value?.toString() ?? 'N/A';

                return Card(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$label: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.grey[300] : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
