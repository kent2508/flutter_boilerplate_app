import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: avoid_classes_with_only_static_members
class ImageHelper {
  static final picker = ImagePicker();
  static Widget getImageFromURL(String imageURL, double? imageWidth, double? imageHeight, double? radius) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      child: CachedNetworkImage(
        imageUrl: imageURL,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (BuildContext context, String url, dynamic error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }

  static Widget getImageFromAsset(String imageFilePath, double? imageWidth, double? imageHeight, double? radius) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.asset(
          imageFilePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Future<Widget> getImageFromCamera(double? imageWidth, double? imageHeight, double? radius) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return const SizedBox();
    } else {
      final File _image = File(pickedFile.path);
      return Container(
        width: imageWidth,
        height: imageHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 0),
          child: Image.file(
            _image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  static Future<Widget> getImageFromPhotos(double? imageWidth, double? imageHeight, double? radius) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return const SizedBox();
    } else {
      final File _image = File(pickedFile.path);
      return Container(
        width: imageWidth,
        height: imageHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 0),
          child: Image.file(
            _image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
