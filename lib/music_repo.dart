import 'music.dart';

class MusicRepo {
  static String defaultText = "Default Text";
  List allMusic = [
    Music("Fountain Bubbling", "assets/l1_fountain_bubbling.mp3", "assets/fountain_bubbling1.jpg","Level 1", 1200),
    Music("Gentle Lake", "assets/l1_gentle_lake.mp3","assets/gentle_lake.jpg","Level 1",1198),
    Music("Ocean Waves", "assets/l1_ocean_waves.mp3", "assets/ocean_waves.jpg", "Level 1",1198),
    Music("Clouds", "assets/l2_clouds_in_the_sky.mp3", "assets/clouds.jpg","Level 2",1198),
    Music("Dreaming", "assets/l2_dreaming.mp3", "assets/dreaming.jpg","Level 2",1178),
    Music("Force Of Nature", "assets/l2_force_of_nature.mp3", "assets/force_of_nature.jpg","Level 2",1198),
    Music("Harmony", "assets/l2_harmony.mp3", "assets/harmony.jpg","Level 2",1177),
    Music("Tranquility", "assets/l2_tranquility.mp3", "assets/tranquility.jpg","Level 2",1176),
  ];

  List get musicList => allMusic;
}