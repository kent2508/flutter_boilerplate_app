import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

class VideoHelperScene extends StatefulWidget {
  const VideoHelperScene({Key? key}) : super(key: key);

  @override
  _VideoHelperSceneState createState() => _VideoHelperSceneState();
}

class _VideoHelperSceneState extends State<VideoHelperScene> {
  final String videoURL =
      'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(videoURL)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => _pickVideoAction(VideoAction.PlayFromAsset),
                    child: Container(
                      color: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: const Text(
                        'Assets',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _pickVideoAction(VideoAction.PlayFromLibrary),
                    child: Container(
                      color: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: const Text(
                        'Library',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _pickVideoAction(VideoAction.PlayFromURL),
                    child: Container(
                      color: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: const Text(
                        'URL',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: const Center(
                    // child: _controller.value.isInitialized
                    //     ? AspectRatio(
                    //         aspectRatio: _controller.value.aspectRatio,
                    //         child: VideoPlayer(_controller),
                    //       )
                    //     : Container(
                    //         child: Center(
                    //           child: Text('No video selected'),
                    //         ),
                    //       ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickVideoAction(VideoAction action) {
    switch (action) {
      case VideoAction.PlayFromAsset:
        // print('Video player isInitialized ${_controller.value.isInitialized}');
        // print('Video player isBuffering ${_controller.value.isBuffering}');
        // print('Video player isLooping ${_controller.value.isLooping}');
        // print('Video player isPlaying ${_controller.value.isPlaying}');
        break;
      case VideoAction.PlayFromLibrary:
        break;
      case VideoAction.PlayFromURL:
        // _controller = VideoPlayerController.network(videoURL)
        //   ..initialize().then((_) {
        //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        //     setState(() {});
        //   });
        break;
      default:
    }
  }
}

enum VideoAction { PlayFromAsset, PlayFromLibrary, PlayFromURL }
