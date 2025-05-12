import 'package:dart_pptx/dart_pptx.dart'
    show PowerPoint, SlideTitleContentAndImages;
import 'package:flutter_pptx/flutter_pptx.dart';
// ignore: implementation_imports
import 'package:dart_pptx/src/util.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

class FlutterPowerPoint extends PowerPoint {
  final _screenshotController = ScreenshotController();

  @override
  // ignore: overridden_fields
  var context = FlutterPresentationContext();

  Future<Uint8List?> save() async {
    return super.save();
  }

  Future<void> addWidgetSlide(Widget widget) async {
    final bytes = await _screenshotController.captureFromWidget(
      widget,
      delay: const Duration(milliseconds: 10),
    );
    if (bytes == null) return;

    final slide = addBlankSlide();
    slide.background.image = ImageReference.fromBytes(
      bytes,
      name: 'Widget Image',
    );
  }

  Future<void> addTitleContentAndImagesSlide({
    required TextValue title,
    required TextValue content,
    required ImageReference image1,
    required ImageReference image2,
    TextValue? caption1,
    TextValue? caption2,
  }) async {
    final slide = SlideTitleContentAndImages(
      title: title,
      content: content,
      image1: image1,
      image2: image2,
      caption1: caption1,
      caption2: caption2,
    );
    addSlide(slide);
  }

  Future<ImageReference> imageFromWidget(Widget widget) async {
    final bytes = await _screenshotController.captureFromWidget(
      widget,
      delay: const Duration(milliseconds: 10),
    );
    if (bytes == null) {
      throw Exception('Failed to capture widget as image');
    }

    return ImageReference.fromBytes(
      bytes,
      name: 'Widget Image',
    );
  }
}

Future<ImageReference> imageFromWidget(
  FlutterPowerPoint pres,
  Widget Function(Size size) builder, {
  Duration delay = const Duration(seconds: 1),
  double? pixelRatio,
  BuildContext? context,
  Size? targetSize,
}) async {
  final ctx = pres.context as FlutterPresentationContext;
  final size = targetSize ??
      Size(
        Util.ptToPixle(pres.layout.width),
        Util.ptToPixle(pres.layout.height),
      );
  final bytes = await ctx.screenshotController.captureFromWidget(
    builder(size),
    delay: delay,
    pixelRatio: pixelRatio,
    context: context,
    targetSize: size,
  );
  final image = ImageReference.fromBytes(
    bytes,
    name: 'widget',
    description: 'image created from a widget',
  );
  return image;
}
