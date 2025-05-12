import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pptx/flutter_pptx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'download/download.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PPTX Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _createPresentation() async {
    final presentation = FlutterPowerPoint();

    // Create a slide with title, content, and two images
    presentation.addTitleContentAndImagesSlide(
      title: TextValue.uniform('My Custom Slide'),
      content: TextValue.uniform(
        'This is the main content of the slide. It can contain multiple lines of text and will be displayed on the left side of the slide.',
      ),
      image1: ImageReference(
        path: 'assets/images/sample_jpg.jpg',
        name: 'Image 1',
      ),
      image2: ImageReference(
        path: 'assets/images/sample_png.png',
        name: 'Image 2',
      ),
      caption1: TextValue.uniform('Caption for first image'),
      caption2: TextValue.uniform('Caption for second image'),
    );

    // Generate the PPTX file
    final bytes = await presentation.save();
    if (bytes == null) return;

    // Save to temporary file
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/presentation.pptx');
    await file.writeAsBytes(bytes);

    // Share the file
    await Share.shareXFiles([XFile(file.path)],
        text: 'Check out my presentation!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter PPTX Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _createPresentation,
          child: const Text('Create Presentation'),
        ),
      ),
    );
  }
}
