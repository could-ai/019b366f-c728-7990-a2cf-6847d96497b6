import 'attack.dart';

class Fighter {
  double x = 0; // Position on screen
  double y = 0;
  bool isJumping = false;
  bool isCrouching = false;
  bool moveLeft = false;
  bool moveRight = false;
  bool isAttacking = false;
  Attack? currentAttack;
  int attackFrame = 0;
  int health = 100;
  double offensiveMeter = 0;
  double defensiveMeter = 0;
  int comboCount = 0;

  void update() {
    // Movement
    if (moveLeft && !isAttacking) x -= 2;
    if (moveRight && !isAttacking) x += 2;

    // Keep within bounds
    x = x.clamp(-200, 200);

    // Attack timing
    if (isAttacking && currentAttack != null) {
      attackFrame++;
      if (attackFrame >= currentAttack!.startupFrames + currentAttack!.activeFrames + currentAttack!.recoveryFrames) {
        isAttacking = false;
        currentAttack = null;
        attackFrame = 0;
      }
    }

    // Meter regeneration
    offensiveMeter = (offensiveMeter + 0.5).clamp(0, 100);
    defensiveMeter = (defensiveMeter + 0.3).clamp(0, 100);
  }

  void performAttack(AttackType type) {
    if (isAttacking) return;
    currentAttack = Attack.attacks[type];
    isAttacking = true;
    attackFrame = 0;
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      // Simple jump animation would be implemented here
    }
  }

  void takeDamage(int damage) {
    health -= damage;
    health = health.clamp(0, 100);
    comboCount = 0; // Reset combo on taking damage
  }

  bool isAttackActive() {
    if (!isAttacking || currentAttack == null) return false;
    return attackFrame >= currentAttack!.startupFrames && 
           attackFrame < currentAttack!.startupFrames + currentAttack!.activeFrames;
  }
}