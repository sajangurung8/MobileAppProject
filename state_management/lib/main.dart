import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Color Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorPickerPage(),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> with WidgetsBindingObserver {
  Color _backgroundColor = Colors.white;
  final Map<String, Color> _colorOptions = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow,
    'Purple': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadBackgroundColor();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveBackgroundColor();
    } else if (state == AppLifecycleState.resumed) {
      _loadBackgroundColor();
    }
  }

  Future<void> _loadBackgroundColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorString = prefs.getString('backgroundColor') ?? 'White';
    setState(() {
      _backgroundColor = _colorOptions[colorString] ?? Colors.white;
    });
  }

  Future<void> _saveBackgroundColor() async {
    final prefs = await SharedPreferences.getInstance();
    String colorName = _colorOptions.entries
        .firstWhere((entry) => entry.value == _backgroundColor)
        .key;
    await prefs.setString('backgroundColor', colorName);
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Color Demo'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _colorOptions.entries.map((entry) {
              return ElevatedButton(
                onPressed: () => _changeBackgroundColor(entry.value),
                child: Text('Set ${entry.key} Background'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: entry.value,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
