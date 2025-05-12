import 'package:json_annotation/json_annotation.dart';

import '../classes/images.dart';
import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_content_and_images.xml.mustache.dart';

part 'title_content_and_images.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleContentAndImages extends Slide {
  SlideTitleContentAndImages({
    super.name = 'Title, Content and Images',
    this.title,
    this.content,
    this.image1,
    this.image2,
    this.caption1,
    this.caption2,
    super.speakerNotes,
    super.slideNumber,
  });

  TextValue? title;
  TextValue? content;
  ImageReference? image1;
  ImageReference? image2;
  TextValue? caption1;
  TextValue? caption2;

  @override
  int get layoutId => 4; // You'll need to create a custom layout in PowerPoint

  @override
  Map<int, ImageReference?> get imageRefs => {
        ...super.imageRefs,
        1: image1,
        2: image2,
      };

  @override
  Map<String, dynamic> toJson() => _$SlideTitleContentAndImagesToJson(this);

  @override
  String get source => template;
}
