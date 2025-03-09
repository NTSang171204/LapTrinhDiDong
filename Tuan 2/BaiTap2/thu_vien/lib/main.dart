import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Flutter Library",
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    StaffManagementScreen(),
    BookListScreen(),
    StaffListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Quản lý'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'DS Sách'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Nhân viên'),
        ],
      ),
    );
  }
}

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}


//Staff Management Screen

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  String staffName = "Nguyen Van A";
  List<bool> bookSelections = [true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hệ thống quản lý thư viện")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              "Staff",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: staffName),
                    decoration: InputDecoration(
                      labelText: "Staff Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text("Change", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Book List",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(30),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),

              child: Column(
                children: [
                  for (int i = 0; i < bookSelections.length; i++)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      child: CheckboxListTile(
                        title: Text("Book number${i + 1}"),
                        tileColor: Colors.white,
                        checkColor: Colors.white,
                        activeColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.blue, width: 2),
                        ),
                        value: bookSelections[i],
                        onChanged: (bool? value) {
                          setState(() {
                            bookSelections[i] = value!;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text("Add", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//The Nav Bar

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Quản lý'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'DS Sách'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Nhân viên'),
      ],
      onTap: (index) {
        // Logic chuyển trang
      },
    );
  }
}


//Book List Screen

class BookListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> books = [
    {'title': 'Sách 01', 'image': Icons.book, 'quantity': 5},
    {'title': 'Sách 02', 'image': Icons.menu_book, 'quantity': 3},
    {'title': 'Sách 03', 'image': Icons.auto_stories, 'quantity': 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách Sách')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(books[index]['image'], size: 40),
            title: Text(books[index]['title']),
            trailing: Text('SL: ${books[index]['quantity']}'),
          );
        },
      ),
    );
  }
}



class StaffListScreen extends StatefulWidget {
  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  List<String> staffMembers = ["Nguyen Van A", "Tran Thi B", "Le Van C"];
  TextEditingController _controller = TextEditingController();

  void _addStaff() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        staffMembers.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _removeStaff(int index) {
    setState(() {
      staffMembers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách Nhân viên')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Nhập tên nhân viên",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addStaff,
                  child: Text("Thêm"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: staffMembers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(staffMembers[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeStaff(index),
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


