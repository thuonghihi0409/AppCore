import 'dart:io';
import 'package:appcore/screens/login_screen.dart';
import 'package:appcore/screens/payment_methods_screen.dart';
import 'package:appcore/models/user.dart';
import 'package:appcore/providers/auth_provider.dart';
import 'package:appcore/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationEnabled = true;
  File? _imageFile; // Lưu ảnh đã chọn hoặc chụp
  final ImagePicker _picker = ImagePicker();

  // Hàm chụp ảnh
  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Hàm chọn ảnh từ thư viện
  Future<void> _chooseFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Hiển thị các tùy chọn


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 50),
                child: GestureDetector(
                  onTap: _showAvatarOptions, // Nhấn vào avatar để chọn ảnh
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!) // Hiển thị ảnh đã chọn/chụp
                        : null,
                    child: _imageFile == null
                        ? Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
              ),Text(
                '${userProvider.user?.name}' ?? " ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          const SizedBox(height: 40),
          ListTile(
            title: const Text(
              'Payment',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentMethodsScreen()));
            },
          ),
          Divider(color: Colors.grey.shade800, thickness: 1),
          ListTile(
            title: const Text(
              'Notification',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
              value: isNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationEnabled = value;
                });
              },
              activeColor: Colors.yellow,
            ),
          ),
          Divider(color: Colors.grey.shade800, thickness: 1),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              _showAskLogoutDialog(context);
            },
          ),
          const Spacer(),
          const Text(
            'Version: 1.0.0',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  void _showAvatarOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.white),
                title: Text(
                  'Take a photo',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto(); // Gọi hàm chụp ảnh
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Colors.white),
                title: Text(
                  'Choose image',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _chooseFromGallery(); // Gọi hàm chọn ảnh
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.white),
                title: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _showAskLogoutDialog(BuildContext context) {
    final screen = ScreenSize(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(25, 22, 22, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Waring",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: screen.percentWidth(0.15),
                  height: screen.percentHeight(0.03),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                    BorderRadius.circular(screen.percentHeight(0.01)),
                  ),
                  child: InkWell(
                    child: Center(child: Text("Oke")),
                    onTap: () {
                      final authProvider =
                      context.read<AuthProvider>();
                      authProvider.logout();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  ),
                ),
                Container(
                  width: screen.percentWidth(0.15),
                  height: screen.percentHeight(0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(screen.percentHeight(0.01)),
                  ),
                  child: InkWell(
                    child: Center(child: Text("Cancel")),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
