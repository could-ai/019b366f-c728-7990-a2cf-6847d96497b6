import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player.dart';
import '../models/enemy.dart';
import '../models/game_state.dart';
import '../widgets/fighter_widget.dart';
import '../widgets/game_ui.dart';
import '../widgets/background_widget.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> with TickerProviderStateMixin {
  late AnimationController _gameLoopController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _gameLoopController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60 FPS
    )..repeat();

    // Request focus for keyboard input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _gameLoopController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event, GameState gameState) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.keyA:
          gameState.player.moveLeft = true;
          break;
        case LogicalKeyboardKey.keyD:
          gameState.player.moveRight = true;
          break;
        case LogicalKeyboardKey.keyW:
          if (!gameState.player.isJumping) {
            gameState.player.jump();
          }
          break;
        case LogicalKeyboardKey.keyS:
          gameState.player.isCrouching = true;
          break;
        case LogicalKeyboardKey.keyJ:
          gameState.player.performAttack(AttackType.lightPunch);
          break;
        case LogicalKeyboardKey.keyK:
          gameState.player.performAttack(AttackType.heavyPunch);
          break;
        case LogicalKeyboardKey.keyU:
          gameState.player.performAttack(AttackType.lightKick);
          break;
        case LogicalKeyboardKey.keyI:
          gameState.player.performAttack(AttackType.heavyKick);
          break;
      }
    } else if (event is KeyUpEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.keyA:
          gameState.player.moveLeft = false;
          break;
        case LogicalKeyboardKey.keyD:
          gameState.player.moveRight = false;
          break;
        case LogicalKeyboardKey.keyS:
          gameState.player.isCrouching = false;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);

    return Scaffold(
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (event) => _handleKeyEvent(event, gameState),
        child: Stack(
          children: [
            const BackgroundWidget(),
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: FighterWidget(
                      fighter: gameState.player,
                      isPlayer: true,
                    ),
                  ),
                  Expanded(
                    child: FighterWidget(
                      fighter: gameState.enemy,
                      isPlayer: false,
                    ),
                  ),
                ],
              ),
            ),
            const GameUI(),
            AnimatedBuilder(
              animation: _gameLoopController,
              builder: (context, child) {
                // Update game logic here
                gameState.update();
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}