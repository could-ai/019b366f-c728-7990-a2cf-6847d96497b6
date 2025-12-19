import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';

class FighterWidget extends ConsumerWidget {
  final dynamic fighter;
  final bool isPlayer;

  const FighterWidget({
    super.key,
    required this.fighter,
    required this.isPlayer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    return Container(
      alignment: isPlayer ? Alignment.centerLeft : Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(
        children: [
          // Fighter sprite (placeholder)
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: isPlayer ? Colors.blue : Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                isPlayer ? 'PLAYER' : 'ENEMY',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Attack effects
          if (fighter.isAttacking)
            Positioned(
              right: isPlayer ? -20 : null,
              left: isPlayer ? null : -20,
              top: 50,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}