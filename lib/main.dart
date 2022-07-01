import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

class MyGame extends Forge2DGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(Player());
  }
}

class Player extends BodyComponent {
  @override
  Body createBody() {
    final shape = CircleShape()..radius = 6;
    final fixtureDef = FixtureDef(shape, friction: 0.5);
    final bodyDef = BodyDef(position: Vector2(20, 5), type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
