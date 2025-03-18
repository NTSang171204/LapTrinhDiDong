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
  @override
  void initState() {
    super.initState();
    futureUTH = fetchUTH();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter API")),
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

            return ListView.builder(
              itemCount: uth.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  decoration: BoxDecoration(
                    color:
                        uth[index]['status'] == 'In Progress'
                            ? Colors.blue[200]
                            : uth[index]['status'] == "Completed"
                            ? const Color.fromARGB(255, 129, 234, 133)
                            : const Color.fromARGB(255, 202, 84, 75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(uth[index]['title'] ?? 'No Title'),
                    subtitle: Text(
                      uth[index]['description'] ?? 'No Description',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(data: uth[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
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
            Text(widget.data['title'] ?? 'No Title', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Text(
              widget.data['description'] ?? 'No Description',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
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
                    final bool checkbox =
                        attachs[index]['isCompleted'] ??
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
                
                        title: Text(attachs[index]['title'] ?? 'No Title'),
                        subtitle: Text(
                          attachs[index]['description'] ?? 'No Description',
                        ),
                        // trailing: attachs[index]['status'] == 'In Progress'
                        //     ? Icon(Icons.play_arrow_rounded)
                        //     : attachs[index]['status'] == "Completed"
                        //         ? Icon(Icons.check_circle_rounded)
                        //         : Icon(Icons.error_rounded),
                        onChanged: (bool? value) {
                          setState(() {
                            attachs[index]['isCompleted'] =
                                value ?? false; // Cập nhật giá trị
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 6),
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
