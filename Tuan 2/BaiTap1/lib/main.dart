import 'package:flutter/material.dart';

void main() {
  runApp(AgeCheckerApp());
}

class AgeCheckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nguyen Truong Sang second app",
      home: AgeCheckerScreen(),
    );
  }
}




class AgeCheckerScreen extends StatefulWidget {
  @override
  _AgeCheckerScreenState createState() => _AgeCheckerScreenState();
}

class _AgeCheckerScreenState extends State<AgeCheckerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _result = "";

  void _checkAgeCategory() {
    String name = _nameController.text.trim();
    int? age = int.tryParse(_ageController.text.trim());

    if (name.isEmpty || age == null) {
      setState(() {
        _result = "Vui lòng nhập tên và tuổi hợp lệ.";
      });
      return;
    }

    String category;
    if (age < 2) {
      category = "Em bé";
    } else if (age >= 2 && age <= 6) {
      category = "Trẻ em";
    } else if (age >= 6 && age <= 65) {
      category = "Người lớn";
    } else {
      category = "Người già";
    }

    
  

    setState(() {
      _result = "$name thuộc nhóm: $category";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thuc Hanh 01")),
      
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Ho va ten"),
          ),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: "Nhap tuoi"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _checkAgeCategory,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            ),
            child: Text("Kiem tra", style: TextStyle(color: Colors.white)),
            
          ),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],)
      )
    );
  }
}
