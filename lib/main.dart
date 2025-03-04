import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() =>
    runApp(const MyApp()); // เริ่มแอปด้วยฟังก์ชัน main() และเรียกใช้ MyApp

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // สร้าง MyApp class เป็น StatelessWidget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ซ่อน debug banner
      title: 'Simple UI Design', // กำหนดชื่อแอป
      theme:
          ThemeData(primarySwatch: Colors.blue), // กำหนดธีมสีหลักเป็นสีน้ำเงิน
      home: const UserProfilePage(), // กำหนดหน้าแรกของแอป
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // สร้างหน้าของโปรไฟล์ผู้ใช้
  String username = "Abbas Leenud";
  String profileName = "";

  String showPosition() {
    return "";
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileName = prefs.getString('proflieName') ?? 'ยังไม่ระบุชื่อ';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    print("โหลดหน้าเสร็จละ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'), // ชื่อแถบ AppBar
      ),
      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.grey,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://as1.ftcdn.net/v2/jpg/06/53/65/68/1000_F_653656803_ubFVWbTrVzYZ7GYE1kr9fkZEjcUGYRgh.jpg'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Abbas Leenud',
                    style: TextStyle(fontSize: 18),
                  ),
                ]
              )
            ),
            ListTile(
              title: const Text('Profile Page'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Todo List'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
      body: Center(
        // ใช้ Center widget เพื่อจัดตำแหน่งทั้งหมดให้อยู่ตรงกลาง
        child: Column(
          // ใช้ Column เพื่อจัดเรียง widget แนวตั้ง
          mainAxisAlignment: MainAxisAlignment.center, // จัดกลางตามแนวตั้ง
          crossAxisAlignment: CrossAxisAlignment.center, // จัดกลางตามแนวนอน
          children: [
            CircleAvatar(
              radius: 50, // กำหนดขนาดของวงกลมรูปภาพ
              backgroundImage: NetworkImage(
                  'https://as1.ftcdn.net/v2/jpg/06/53/65/68/1000_F_653656803_ubFVWbTrVzYZ7GYE1kr9fkZEjcUGYRgh.jpg'), // ใช้รูปโปรไฟล์จาก URL
            ),
            SizedBox(height: 16), // เพิ่มช่องว่างระหว่างรูปภาพและข้อความ
            if (profileName == "")
              Text(
                "ยังไม่ระบุชื่อ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Text(
                profileName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 8), // เพิ่มช่องว่างระหว่างชื่อและอาชีพ
            Text(
              showPosition() == "" ? "ยังไม่ระบุตำแหน่ง" : showPosition(), // ถ้า positionว่าง จะใช้ "ยังไม่ระบุ"
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16), // เพิ่มช่องว่างระหว่างอาชีพและเบอร์โทร
            Text(
              '098 117 0254', // เบอร์โทรของผู้ใช้
              style: TextStyle(fontSize: 18), // กำหนดขนาดฟอนต์
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // ใช้ context เพื่อเข้าถึง Navigator
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(), // ไปหน้า Edit
                  ),
                );
              },
              child: const Text('แก้ไข'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _loadData, child: const Text('ดึงข้อมูล'))
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController profilenameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('proflieName', profilenameController.text);
    prefs.setString('position', positionController.text);
    prefs.setString('phone', phoneController.text);

    print("บันทึกเรียบร้อย");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green, // กำหนดสีพื้นหลัง
        content: Text('เซฟเรียบร้อย'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: profilenameController,
                decoration: InputDecoration(
                    hintText: 'ชื่อ สกุล', labelText: 'กรุณากรอกชื่อ สกุล'),
              ),
              TextField(
                controller: positionController,
                decoration: InputDecoration(labelText: "ตำแหน่ง"),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'หมายเลขโทรศัพท์'),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  _saveData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage()));
                },
                child: const Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}