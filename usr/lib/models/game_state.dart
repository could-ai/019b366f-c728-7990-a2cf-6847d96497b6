import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'player.dart';
import 'enemy.dart';

class GameState {
  final Player player = Player();
  final Enemy enemy = Enemy();

  void update() {
    player.update();
    enemy.update();

    // Collision detection and damage
    if (player.isAttackActive() && _checkCollision()) {
      enemy.takeDamage(player.currentAttack!.damage);
      // Hit feedback would be added here
    }

    if (enemy.isAttackActive() && _checkCollision()) {
      player.takeDamage(enemy.currentAttack!.damage);
      // Hit feedback would be added here
    }
  }

  bool _checkCollision() {
    // Simplified collision detection
    final distance = (player.x - enemy.x).abs();
    final attackingFighter = player.isAttacking ? player : (enemy.isAttacking ? enemy : null);
    if (attackingFighter != null && attackingFighter.currentAttack != null) {
      return distance <= attackingFighter.currentAttack!.range;
    }
    return false;
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState());

  void updateGame() {
    state.update();
  }
}