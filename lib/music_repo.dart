import 'music.dart';

class MusicRepo {
  static String defaultText = "Default Text";
  List allMusic = [
    Music("Dreaming", "assets/dreaming.mp3", "assets/dreaming.jpg",defaultText,1178),
    Music("Fountain Bubbling", "assets/fountain_bubbling.mp3","assets/fountain_bubbling1.jpg",defaultText,1200),
    Music("Harmony", "assets/harmony.mp3", "assets/harmony.jpg", defaultText,1177),
    Music("Gentle Lake", "assets/gentle_lake.mp3", "assets/gentle_lake.jpg",defaultText,1198),
    Music("Ocean Waves", "assets/ocean_waves.mp3", "assets/ocean_waves.jpg",defaultText,1198),
    Music("Tranquility", "assets/tranquility.mp3", "assets/tranquility.jpg",defaultText,1176),
    Music("Clouds", "assets/clouds_in_the_sky.mp3", "assets/clouds.jpg",defaultText,1198),
    Music("Force Of Nature", "assets/force_of_nature.mp3", "assets/force_of_nature.jpg",defaultText,1198),
  ];

  List get musicList => allMusic;
}