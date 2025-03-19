import 'package:flutter/material.dart';
import 'package:lazy/api/researchuth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.grey[100],
      title: "Flutter API",
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<dynamic>> futureUTH;
  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    futureUTH = fetchUTH();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/Logo.png"),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SmartTasks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Text('A simple and efficient to-do app', style: TextStyle(fontSize: 12, color: Colors.blue)),
          ],
        ),
        actions: [Image.asset("assets/images/bell.png")],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureUTH,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final uth = snapshot.data ?? [];
            if (uth.isEmpty) return Sleep();

            // Khởi tạo danh sách checkbox nếu chưa có dữ liệu
            if (checkboxValues.length != uth.length) {
              checkboxValues = List.generate(uth.length, (index) => uth[index]['status'] == 'Completed');
            }

            return ListView.builder(
              itemCount: uth.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: uth[index]['status'] == 'In Progress'
                        ? Colors.blue[200]
                        : uth[index]['status'] == "Completed"
                            ? Color.fromARGB(255, 129, 234, 133)
                            : Color.fromARGB(255, 202, 84, 75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailPage(data: uth[index])),
                            );
                          },
                          child: Text(uth[index]['title'] ?? 'No Title'),
                        ),
                        subtitle: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailPage(data: uth[index])),
                            );
                          },
                          child: Text(uth[index]['description'] ?? 'No Description'),
                        ),
                        value: checkboxValues[index],
                        onChanged: (value) {
                          setState(() {
                            checkboxValues[index] = value ?? false;
                          });
                        },
                        secondary: Icon(Icons.arrow_forward_ios_rounded),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status: ${uth[index]['status']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("${uth[index]['dueDate']}", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(60.0),
        child: BottomAppBar(
          height: 40.0,
          elevation: 20.0,
          notchMargin: 4.0,
          shape:CircularNotchedRectangle(),
          child: Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 0),
                _buildNavItem(Icons.calendar_today, 1),
                SizedBox(width: 40), // Khoảng trống cho FAB
                _buildNavItem(Icons.insert_drive_file, 2),
                _buildNavItem(Icons.settings, 3),
        
              ],
            )
          ),
        ),
      ),
      
    );
  }
  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(icon, color: Colors.blue),
      onPressed: () {
        
      },
    );
  }
}

class Sleep extends StatelessWidget {
  const Sleep({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/sleep.png', height: 200),
          Text(
            'Sleep well, no tasks yet.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Stay productive, add something to do',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}




class DetailPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailPage({super.key, required this.data});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> subtasks = widget.data['subtasks'] ?? [];
    List<dynamic> attachs = widget.data['attachments'] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          ),
        ),
        title: Text('Details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.amber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data['title'] ?? 'No Title',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.data['description'] ?? 'No Description',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Container(
              height: 80,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTaskItem(
                    Icons.grid_view,
                    "Category",
                    widget.data['category'] ?? "N/A",
                  ),
                  _buildTaskItem(
                    Icons.assignment,
                    "Status",
                    widget.data['status'] ?? "N/A",
                  ),
                  _buildTaskItem(
                    Icons.emoji_events,
                    "Priority",
                    widget.data['priority'] ?? "N/A",
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Subtasks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            subtasks.isNotEmpty
                ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: subtasks.length,
                  itemBuilder: (context, index) {
                    final bool checkbox =
                        subtasks[index]['isCompleted'] ??
                        false; // Đảm bảo là bool

                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Màu nền xám nhạt
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CheckboxListTile(
                        value: checkbox,

                        title: Text(subtasks[index]['title'] ?? 'No Title'),
                        subtitle: Text(
                          subtasks[index]['description'] ?? 'No Description',
                        ),
                        // trailing: subtasks[index]['status'] == 'In Progress'
                        //     ? Icon(Icons.play_arrow_rounded)
                        //     : subtasks[index]['status'] == "Completed"
                        //         ? Icon(Icons.check_circle_rounded)
                        //         : Icon(Icons.error_rounded),
                        onChanged: (bool? value) {
                          setState(() {
                            subtasks[index]['isCompleted'] =
                                value ?? false; // Cập nhật giá trị
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    );
                  },
                )
                : Text("No Subtasks"),

            Text(
              "Attachments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            attachs.isNotEmpty
                ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: attachs.length,
                  itemBuilder: (context, index) {
//                     final bool checkbox =
                        // attachs[index]['isCompleted'] ??
//                         false; // Đảm bảo là bool

                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Màu nền xám nhạt
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        // value: checkbox,
                        leading: IconButton(onPressed: () {
                          
                        }, icon: Icon(Icons.attach_file)),
                        title: Text(attachs[index]['fileName'] ?? 'No Title'),
                        subtitle: Text(
                          attachs[index]['description'] ?? 'No Description',
                        ),
                        // trailing: attachs[index]['status'] == 'In Progress'
                        //     ? Icon(Icons.play_arrow_rounded)
                        //     : attachs[index]['status'] == "Completed"
                        //         ? Icon(Icons.check_circle_rounded)
                        //         : Icon(Icons.error_rounded),

                        
                        // onChanged: (bool? value) {
                        //   setState(() {
                        //     attachs[index]['isCompleted'] =
                        //         value ?? false; // Cập nhật giá trị
                        //   });
                        // },
                        // controlAffinity: ListTileControlAffinity.leading,
                      ),
                    );
                  },
                )
                : Text("No Subtasks"),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(IconData icon, String label, String value) {
    return Row(
      spacing: 5,
      children: [
        Icon(icon, size: 24, color: Colors.black),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.black54)),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


