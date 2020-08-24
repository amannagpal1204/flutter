import 'package:flutter/material.dart';
import 'package:musicapp/Video.dart';
import 'package:musicapp/main.dart';
import 'package:video_player/video_player.dart';
import 'package:toast/toast.dart';

void main() => runApp(Video());

class Video extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player Demo',
      home: Videoplayerclass(),
    );
  }
}

class Videoplayerclass extends StatefulWidget {
  Videoplayerclass({Key key}) : super(key: key);

  @override
  _VideoplayerclassState createState() => _VideoplayerclassState();
}

class _VideoplayerclassState extends State<Videoplayerclass> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'assets/video.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
        centerTitle: true,
        backgroundColor: Colors.purple[200],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Videoplayer()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Asset Video",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.show("Video is Playing!!", context,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.grey[200],
              backgroundRadius: 5.0,
              border: Border.all(
                width: 20.0,
              ),
              duration: Toast.LENGTH_SHORT,
              textColor: Colors.purple[300]);
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
              Toast.show("Video is stop!!", context,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.grey[200],
                  backgroundRadius: 5.0,
                  border: Border.all(
                    width: 20.0,
                  ),
                  duration: Toast.LENGTH_SHORT,
                  textColor: Colors.purple[300]);
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
