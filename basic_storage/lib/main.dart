import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Default to light mode
  File? _storedImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load user preferences
    _loadImage();       // Load stored image on startup
  }

  // Method to store user preference (theme setting)
  Future<void> _savePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Method to load user preference (theme setting)
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Method to save the image locally
  Future<void> _saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final newImage = await image.copy('$path/saved_image.png');
    setState(() {
      _storedImage = newImage;
    });
  }

  // Method to load the image from local storage
  Future<void> _loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/saved_image.png';
    final File imageFile = File(imagePath);
    if (await imageFile.exists()) {
      setState(() {
        _storedImage = imageFile;
      });
    }
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _saveImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image & Preferences Storage'),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  _savePreference(_isDarkMode); // Save preference
                });
              },
              activeColor: Colors.white,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Displaying the stored image (if any)
                  _storedImage != null
                      ? Image.file(
                          _storedImage!,
                          height: 200,
                        )
                      : const Text('No image stored'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick and Save Image'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Displaying the user theme preference at the bottom
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    _isDarkMode ? 'Dark Mode is ON' : 'Light Mode is ON',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
