import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'main.dart';
import 'music_repo.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  AnimationController controller;
  String musicTitle;
  String backgroundImageUri;
  double toolbarIconSize = 25;
  List musicList = MusicRepo().musicList;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var sliderValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  bool get _status {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  int getCurrentMusicPosition() {
    for (int i = 0; i < musicList.length; i++) {
      if (Home.currentMusic != null) {
        if (Home.currentMusic.title == musicList[i].title) {
          return i;
        }
      } else {
        return 0;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(controller.status);
    if (Home.isMusicPlaying && controller.status == AnimationStatus.forward) {
      controller.fling(velocity: 2.0);
    } else if (Home.isMusicPlaying &&
        controller.status == AnimationStatus.dismissed) {
      controller.fling(velocity: 2.0);
    } else {
      controller.fling(velocity: -2.0);
    }

    //prevent app from changing to landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage((Home.currentMusic == null)
                  ? musicList[0].imageUri
                  : Home.currentMusic.imageUri),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        DecoratedBox(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0x80000000), Color(0x30000000)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter),
        )),
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 130.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      (Home.currentMusic == null)
                          ? musicList[0].title
                          : Home.currentMusic.title,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
//                width: 30.0,
//                height: 30.0,
                child: Row(children: <Widget>[
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        if (getCurrentMusicPosition() > 0) {
                          Home.currentMusic =
                              musicList[getCurrentMusicPosition() - 1];
                        } else {
                          Home.currentMusic = musicList[musicList.length - 1];
                        }
                        //cancel song looping if timerOfSongLooping !=null
                        if(HomeState.timerOfSongLooping!=null) {
                          HomeState.timerOfSongLooping.cancel();
                        }
                        HomeState().stopSound();
                        HomeState().playSound();
                        //loop song
                        HomeState().setTimerOfSongLooping(musicList[getCurrentMusicPosition()].durationSeconds);
                        Home.isMusicPlaying = true;
                      });
                    },
                    elevation: 20.0,
                    shape: CircleBorder(),
                    child: new Icon(
                      Icons.skip_previous,
                      size: 55.0,
                    ),
//                    child: Container(
//                        width: 80.0,
//                        height: 80.0,
//                        child: Center(
//                            child: AnimatedIcon(
//                          icon: AnimatedIcons.play_pause,
//                          progress: controller.view,
//                          color: Colors.white,
//                          size: 50,
//                        ))),
                    fillColor: Colors.white54,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      Home.isMusicPlaying = !Home.isMusicPlaying;
                      if (Home.isMusicPlaying == true) {
                        setState(() {
                          HomeState().playSound();
                          Home.isMusicPlaying = true;
                          //cancel song looping if timerOfSongLooping !=null
                          if(HomeState.timerOfSongLooping!=null) {
                            HomeState.timerOfSongLooping.cancel();
                          }
                          //loop song
                          HomeState().setTimerOfSongLooping(musicList[getCurrentMusicPosition()].durationSeconds);
                        });
                      } else if (Home.isMusicPlaying == false) {
                        setState(() {
                          //hide Notification bar
//                        hideMusicNotificationBar();
                          //toggles to PLAY button, when sound is paused
                          HomeState().pauseSound();
                          Home.isMusicPlaying = false;
                          //cancel song looping if timerOfSongLooping !=null
                          if(HomeState.timerOfSongLooping!=null) {
                            HomeState.timerOfSongLooping.cancel();
                          }
                        });
                      }
//                      setState(() {
//                        Home.isMusicPlaying = !Home.isMusicPlaying;
//                        controller.fling(velocity: _status ? -2.0 : 2.0);
//                        if (Home.isMusicPlaying)
//                          HomeState().playSound();
//                        else
//                          HomeState().pauseSound();
//                      });
                    },
                    elevation: 20.0,
                    shape: CircleBorder(),
                    child: Home.isMusicPlaying
                        ? new Icon(
                            Icons.pause,
                            size: 70.0,
                          )
                        : new Icon(
                            Icons.play_arrow,
                            size: 70.0,
                          ),
//                    child: Container(
//                        width: 80.0,
//                        height: 80.0,
//                        child: Center(
//                            child: AnimatedIcon(
//                          icon: AnimatedIcons.play_pause,
//                          progress: controller.view,
//                          color: Colors.white,
//                          size: 50,
//                        ))),
                    fillColor: Colors.white54,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        if (getCurrentMusicPosition() < musicList.length - 1) {
                          Home.currentMusic =
                              musicList[getCurrentMusicPosition() + 1];
                        } else {
                          Home.currentMusic = musicList[0];
                        }
                        HomeState().stopSound();
                        HomeState().playSound();
                        Home.isMusicPlaying = true;
                        //cancel previous song looping if timerOfSongLooping !=null
                        if(HomeState.timerOfSongLooping!=null) {
                          HomeState.timerOfSongLooping.cancel();
                        }
                        //loop song
                        HomeState().setTimerOfSongLooping(musicList[getCurrentMusicPosition()].durationSeconds);
                      });
                    },
                    elevation: 20.0,
                    shape: CircleBorder(),
                    child: new Icon(
                      Icons.skip_next,
                      size: 55.0,
                    ),
//                    child: Container(
//                        width: 80.0,
//                        height: 80.0,
//                        child: Center(
//                            child: AnimatedIcon(
//                          icon: AnimatedIcons.play_pause,
//                          progress: controller.view,
//                          color: Colors.white,
//                          size: 50,
//                        ))),
                    fillColor: Colors.white54,
                  ),
                ]),
              ),
//              Row(
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                          Listener(
//                            onPointerDown: (details) {
////                              _increaseVolumeButtonPressed = true;
////                              volumeButtonLongPress();
//                              print("increase vol button long hold");
//                            },
//                            onPointerUp: (details) {
////                              _increaseVolumeButtonPressed = false;
//                              print("increase vol button long hold off");
//                            },
//                            child: RaisedButton(
//                              color: Colors.white54,
//                              child: Icon(
//                                Icons.volume_up,
//                                size: 35.0,
//                              ),
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(30.0)),
//                              onPressed: () {
////                            Volume.volUp() already called during onPointerUp
//                              increaseVolume();
//                              },
//                            ),
//                          ),
//                          Listener(
//                            onPointerDown: (details) {
////                              _decreaseVolumeButtonPressed = true;
////                              volumeButtonLongPress();
//                              print("decrease vol button long hold");
//                            },
//                            onPointerUp: (details) {
////                              _decreaseVolumeButtonPressed = false;
//                              print("decrease vol button long hold off");
//                            },
//                            child: RaisedButton(
//                              color: Colors.white54,
//                              child: Icon(
//                                Icons.volume_down,
//                                size: 35.0,
//                              ),
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(30.0)),
//                              onPressed: () {
////                            Volume.volDown() already called during onPointerUp
//                              decreaseVolume();
//                              },
//                            ),
//                          ),
//                    ],
//                  ),
//                ],
//              )
            ],
          ),
        )
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
