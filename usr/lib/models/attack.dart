enum AttackType {
  lightPunch,
  heavyPunch,
  lightKick,
  heavyKick,
  special,
}

class Attack {
  final AttackType type;
  final int damage;
  final int startupFrames;
  final int activeFrames;
  final int recoveryFrames;
  final double range;

  const Attack({
    required this.type,
    required this.damage,
    required this.startupFrames,
    required this.activeFrames,
    required this.recoveryFrames,
    required this.range,
  });

  static const Map<AttackType, Attack> attacks = {
    AttackType.lightPunch: Attack(
      type: AttackType.lightPunch,
      damage: 5,
      startupFrames: 4,
      activeFrames: 2,
      recoveryFrames: 8,
      range: 50,
    ),
    AttackType.heavyPunch: Attack(
      type: AttackType.heavyPunch,
      damage: 12,
      startupFrames: 8,
      activeFrames: 3,
      recoveryFrames: 15,
      range: 45,
    ),
    AttackType.lightKick: Attack(
      type: AttackType.lightKick,
      damage: 7,
      startupFrames: 6,
      activeFrames: 2,
      recoveryFrames: 10,
      range: 60,
    ),
    AttackType.heavyKick: Attack(
      type: AttackType.heavyKick,
      damage: 15,
      startupFrames: 10,
      activeFrames: 4,
      recoveryFrames: 18,
      range: 55,
    ),
  };
}