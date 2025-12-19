import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';

class GameUI extends ConsumerWidget {
  const GameUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Health bars
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: gameState.player.health / 100,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: LinearProgressIndicator(
                  value: gameState.enemy.health / 100,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Meters
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('OFFENSIVE', style: TextStyle(color: Colors.white, fontSize: 12)),
                    LinearProgressIndicator(
                      value: gameState.player.offensiveMeter / 100,
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    const Text('DEFENSIVE', style: TextStyle(color: Colors.white, fontSize: 12)),
                    LinearProgressIndicator(
                      value: gameState.player.defensiveMeter / 100,
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          // Controls hint
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black54,
            child: const Text(
              'Controls: A/D Move, W Jump, S Crouch, J/K/U/I Attacks',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}