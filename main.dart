import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/Video.dart';
import 'package:toast/toast.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.purple);
    FlutterStatusbarcolor.setStatusBarColor(Colors.purple);

    return Scaffold(
      appBar: AppBar(
        title: Text("Music App"),
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        elevation: 5.0,
        leading: Icon(Icons.music_video),
        actions: <Widget>[
          Icon(Icons.playlist_add),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          IconButton(
            icon: Icon(Icons.video_library),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Videoplayer()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 400,
                  height: 50,
                  color: Colors.grey[300],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Play Assets"),
                          color: Colors.purple[200],
                          splashColor: Colors.white,
                          onPressed: () {
                            var a = AudioCache();
                            a.play('3voice.wav');
                            Toast.show("Playing!!", context,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Colors.grey[200],
                                backgroundRadius: 5.0,
                                border: Border.all(
                                  width: 20.0,
                                ),
                                duration: Toast.LENGTH_SHORT,
                                textColor: Colors.purple[300]);
                          },
                        ),
                      ]),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 400,
                  height: 50,
                  color: Colors.grey[300],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Play Network"),
                          color: Colors.purple[200],
                          splashColor: Colors.white,
                          onPressed: () {
                            // Video();
                            var a = AudioPlayer();
                            a.play(
                                'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4');

                            Toast.show("Playing!!", context,
                                gravity: Toast.BOTTOM,
                                duration: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.grey[200],
                                backgroundRadius: 5.0,
                                border: Border.all(
                                  width: 20.0,
                                ),
                                textColor: Colors.purple[300]);
                          },
                        ),
                      ]),
                ),
              ),
            ),
            Center(
              child: FlatButton(
                child: Text("Video Player",
                    style: TextStyle(fontSize: 25.0, color: Colors.white)),
                color: Colors.purple[600],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Videoplayer()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
