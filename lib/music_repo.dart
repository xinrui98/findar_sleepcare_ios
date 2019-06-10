import 'music.dart';

class MusicRepo {
  static String defaultText = "Default Text";
  List allMusic = [
    Music("Dreaming", "assets/dreaming.mp3", "assets/dreaming.jpg",defaultText,5),
    Music("Fountain Bubbling", "assets/test_sound.mp3","assets/fountain_bubbling1.jpg",defaultText,5),
    Music("Harmony", "assets/harmony.mp3", "assets/harmony.jpg", defaultText,60),
    Music("Gentle Lake", "assets/gentle_lake.mp3", "assets/gentle_lake.jpg",defaultText,60),
    Music("Ocean Waves", "assets/ocean_waves.mp3", "assets/ocean_waves.jpg",defaultText,60),
    Music("Tranquility", "assets/tranquility.mp3", "assets/tranquility.jpg",defaultText,60),
    Music("Clouds", "assets/clouds_in_the_sky.mp3", "assets/clouds.jpg",defaultText,60),
    Music("Force Of Nature", "assets/force_of_nature.mp3", "assets/force_of_nature.jpg",defaultText,60),
  ];

  List get musicList => allMusic;
}