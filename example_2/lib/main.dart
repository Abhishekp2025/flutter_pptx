import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pptx/flutter_pptx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PPTX Demo 2',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _createPresentation() async {
    final presentation = FlutterPowerPoint();

    // First slide - Introduction
    presentation.addTitleContentAndImagesSlide(
      title: TextValue.uniform('Project Overview'),
      content: TextValue.uniform(
        'This presentation demonstrates the capabilities of our custom slide layout:\n\n'
        '• Title at the top\n'
        '• Content on the left\n'
        '• Two images with captions on the right\n\n'
        'Perfect for comparing two related images or showing before/after results.',
      ),
      image1: ImageReference(
        path: 'assets/images/sample_jpg.jpg',
        name: 'Sample JPG',
      ),
      image2: ImageReference(
        path: 'assets/images/sample_png.png',
        name: 'Sample PNG',
      ),
      caption1: TextValue.uniform('Before: Original Image'),
      caption2: TextValue.uniform('After: Processed Image'),
    );

    // Second slide - Features
    presentation.addTitleContentAndImagesSlide(
      title: TextValue.uniform('Key Features'),
      content: TextValue.uniform(
        'Our custom slide layout offers several advantages:\n\n'
        '• Clean and professional design\n'
        '• Flexible content placement\n'
        '• Support for multiple images\n'
        '• Customizable captions\n'
        '• Easy to maintain and update',
      ),
      image1: ImageReference(
        path: 'assets/images/sample_gif.gif',
        name: 'Sample GIF',
      ),
      image2: ImageReference(
        path: 'assets/images/sample_jpg.jpg',
        name: 'Sample JPG',
      ),
      caption1: TextValue.uniform('Feature Demo 1'),
      caption2: TextValue.uniform('Feature Demo 2'),
    );

    // Third slide - Implementation
    presentation.addTitleContentAndImagesSlide(
      title: TextValue.uniform('Implementation Details'),
      content: TextValue.uniform(
        'Technical implementation highlights:\n\n'
        '• Built with Flutter and Dart\n'
        '• Uses custom XML templates\n'
        '• Supports dynamic content\n'
        '• Easy to extend and customize\n'
        '• Compatible with all platforms',
      ),
      image1: ImageReference(
        path: 'assets/images/sample_png.png',
        name: 'Sample PNG',
      ),
      image2: ImageReference(
        path: 'assets/images/sample_gif.gif',
        name: 'Sample GIF',
      ),
      caption1: TextValue.uniform('Code Structure'),
      caption2: TextValue.uniform('Runtime Preview'),
    );

    // Generate the PPTX file
    final bytes = await presentation.save();
    if (bytes == null) return;

    // Save to temporary file
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/custom_presentation.pptx');
    await file.writeAsBytes(bytes);

    // Share the file
    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Check out my custom presentation!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Slide Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Custom Slide Layout Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This demo creates a presentation with three slides\n'
              'using our custom title_content_and_images layout.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _createPresentation,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Create Presentation'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
