import 'fighter.dart';

class Player extends Fighter {
  Player() {
    x = -150; // Start on left side
  }

  @override
  void update() {
    super.update();
    // Player-specific logic
  }
}