import 'package:flutter/material.dart';

void main() {
  runApp(const MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nguyen Truong Sang First App',
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( 
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: null, icon: const Icon(Icons.arrow_back)),
                  IconButton(onPressed: null, icon: const Icon(Icons.edit)),
                ],
            ),
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2, // Chiếm 50% màn hình
          ),

          Center(
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/Avatar.jpg'),
            ),
          ),

          const Text(
              'Nguyễn Trương Sang',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
              'Thành Phố Hồ Chí Minh, Việt Nam',
              style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          ],
        ),
      ),
    );
  }
}