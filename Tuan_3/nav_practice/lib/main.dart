import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Class Practice',

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Image.asset('assets/images/image1.png'),
          SizedBox(height: 20),
          Text(
            'Welcome to Flutter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Jetpack Compose is a modern toolkit for building native Android UI. Jetpack Compose simplifies and accelerates UI development on Android with less code, powerful tools, and intuitive Kotlin APIs.",
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(flex: 3),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComponentsListScreen()),
              );
            },
            child: Text(
              "I'm Ready",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class ComponentsListScreen extends StatelessWidget {
  ComponentsListScreen({super.key});

  final List<Widget> screens = [DetailScreen(), ImageScreen()];

  final List<Widget> screens1 = [TextFieldScreen(), PasswordFieldScreen()];

  final List<Widget> screens2 = [RowScreen(), ColumnScreen()];

  final List<Map<String, String>> comps = [
    {"title": "Text", "subtitle": "Displays text"},
    {"title": "Image", "subtitle": "Displays an image"},
  ];

  final List<Map<String, String>> Input = [
    {"title": "TextField", "subtitle": "Input field for text"},
    {"title": "PasswordField", "subtitle": "Input field for passwords"},
  ];

  final List<Map<String, String>> Layout = [
    {"title": "Row", "subtitle": "Aranges elements horizontally"},
    {"title": "Column", "subtitle": "Arranges elements verticallyvertically"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 40.0)),
          Center(
            child: Text(
              'UI Components List',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),
          ),

          // Display
          Text("Display", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: screens.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ), // Khoảng cách giữa các ListTile
                  decoration: BoxDecoration(
                    color: Colors.blue[100], // Màu nền
                    borderRadius: BorderRadius.circular(10), // Bo góc
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2, 2), // Hiệu ứng bóng đổ
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Text(
                      comps[index]["title"]!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      comps[index]["subtitle"]!,
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screens[index]),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          Text("Input", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: screens1.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ), // Khoảng cách giữa các ListTile
                  decoration: BoxDecoration(
                    color: Colors.blue[100], // Màu nền
                    borderRadius: BorderRadius.circular(10), // Bo góc
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2, 2), // Hiệu ứng bóng đổ
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Text(
                      Input[index]["title"]!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Input[index]["subtitle"]!,
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => screens1[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          Text("Display", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: screens2.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ), // Khoảng cách giữa các ListTile
                  decoration: BoxDecoration(
                    color: Colors.blue[100], // Màu nền
                    borderRadius: BorderRadius.circular(10), // Bo góc
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2, 2), // Hiệu ứng bóng đổ
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Text(
                      Layout[index]["title"]!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Layout[index]["subtitle"]!,
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => screens2[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Các màn hình khác nhau
class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Detail Screen",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
      body: Center(child: Text("This is the Display text Screen")),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Screen")),
      body: Column(
        children: [
          Image.asset('assets/images/image1.png'),
          SizedBox(height: 20),
          Text("This is the Display Image Screen"),
        ],
      ),
    );
  }
}

class TextFieldScreen extends StatelessWidget {
  const TextFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TextField Screen",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("This is the TextField Screen"),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFieldScreen extends StatelessWidget {
  const PasswordFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Password Screen",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("This is the PasswordField Screen"),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnScreen extends StatelessWidget {
  const ColumnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Column Screen",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Text("This is the Column Screen"),
            Text("This is the Column Screen"),
            Text("This is the Column Screen"),
          ],
        ),
      ),
    );
  }
}

class RowScreen extends StatelessWidget {
  const RowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Row Screen",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),

      body: Row(
        children: [
          Text("Nguyen 1"),
          Text("Truong 2"),
          Text("Sang 3"),
        ],
      ),
    );
  }
}
