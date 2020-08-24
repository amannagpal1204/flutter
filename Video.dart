import 'package:flutter/material.dart';
import 'package:musicapp/Videoasset.dart';
import 'package:musicapp/main.dart';
import 'package:video_player/video_player.dart';
import 'package:toast/toast.dart';

void main() => runApp(Videoplayer());

class Videoplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player ',
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
    _controller = VideoPlayerController.network(
      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4?_=1',
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
              MaterialPageRoute(builder: (context) => Home()),
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
          IconButton(
            icon: Icon(Icons.video_library),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Video()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          )
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
            "Network Video",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: FlatButton(
            child: Text(
              "Asset Video",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            color: Colors.purple[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Video()),
              );
            },
          ),
        )
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
              Toast.show("Video is Stop!!", context,
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
