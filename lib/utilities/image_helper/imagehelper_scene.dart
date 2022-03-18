import 'package:flutter/material.dart';

import 'imagehelper.dart';

class ImageHelperScene extends StatefulWidget {
  static const String routeName = 'image_page';
  // ignore: sort_constructors_first
  const ImageHelperScene({Key? key}) : super(key: key);

  @override
  _ImageHelperSceneState createState() => _ImageHelperSceneState();
}

class _ImageHelperSceneState extends State<ImageHelperScene> {
  final String _imageURL = 'https://i.redd.it/im1zvb0l50c31.jpg';
  final String _imageFilePath = 'assets/images/image16.png';

  late Widget _imagePreview = Container(
    child: const Center(
      child: Text('No image selected'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Helper',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: _imagePreview,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _pickImageAction(ImageAction.GetImageFromURL),
                    child: const Text(
                      'From URL',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _pickImageAction(ImageAction.GetImageFromAsset),
                    child: const Text(
                      'From Asset',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImageAction(
                      ImageAction.TakeImageFromCamera,
                    ),
                    child: const Text(
                      'Open Camera',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _pickImageAction(ImageAction.PickImageFromPhotos),
                    child: const Text(
                      'Pick Photo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageAction(ImageAction action) async {
    switch (action) {
      case ImageAction.GetImageFromURL:
        setState(() {
          _imagePreview = ImageHelper.getImageFromURL(
              _imageURL,
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2,
              24);
        });
        break;
      case ImageAction.GetImageFromAsset:
        setState(() {
          _imagePreview = ImageHelper.getImageFromAsset(
              _imageFilePath,
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2,
              12);
        });
        break;
      case ImageAction.PickImageFromPhotos:
        _imagePreview = await ImageHelper.getImageFromPhotos(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2,
            12);
        setState(() {});
        break;
      case ImageAction.TakeImageFromCamera:
        _imagePreview = await ImageHelper.getImageFromCamera(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2,
            12);
        setState(() {});
        break;
      default:
    }
  }
}

enum ImageAction {
  GetImageFromURL,
  GetImageFromAsset,
  PickImageFromPhotos,
  TakeImageFromCamera
}
