import 'fighter.dart';
import 'attack.dart'; // Added import for AttackType
import 'dart:math';

class Enemy extends Fighter {
  Enemy() {
    x = 150; // Start on right side
  }

  @override
  void update() {
    super.update();

    // Simple AI behavior
    if (!isAttacking) {
      // Random movement
      if (Random().nextDouble() < 0.02) {
        moveLeft = !moveLeft;
        moveRight = !moveRight;
      }

      // Random attacks
      if (Random().nextDouble() < 0.01) {
        final attacks = AttackType.values.where((a) => a != AttackType.special).toList();
        performAttack(attacks[Random().nextInt(attacks.length)]);
      }
    }
  }
}
