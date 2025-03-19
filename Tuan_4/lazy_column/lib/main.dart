import 'dart:math';

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
                MaterialPageRoute(builder: (context) => LazyColumnScreen()),
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


class LazyColumnScreen extends StatelessWidget {
  @override
  // TODO: implement key
  Key? get key => super.key;
  final List<String> items = List.generate(
    100000,
    (index) => "${index + 1} | ${_generateRandomQuote()}",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "LazyColumn",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(items[index]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LazyColumnDetailScreen(item: items[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LazyColumnDetailScreen extends StatelessWidget {
  final String item;
  LazyColumnDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Detail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item, style: TextStyle(fontSize: 20)),
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
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: Text(
              "Back to the root",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          ],
        ),
        
      ),
    );
  }
}

// Hàm tạo quote ngẫu nhiên
String _generateRandomQuote() {
  final quotes = [
    "The only way to do great work is to love what you do.",
    "Success is not the key to happiness. Happiness is the key to success.",
    "Do what you love and you'll never work a day in your life.",
    "Believe you can and you're halfway there.",
    "The future depends on what you do today."
  ];
  return quotes[Random().nextInt(quotes.length)];
}