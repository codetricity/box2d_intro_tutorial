import 'package:flame/components.dart';
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
  MyGame() : super(gravity: Vector2(0, 7.0));
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    print(gameSize);
    add(Ground(gameSize));
    add(
      Player(
        position: Vector2(40, 5),
        sprite: await loadSprite('natsuki_casual.webp'),
      ),
    );
    add(
      Player(
        position: Vector2(60, 10),
        sprite: await loadSprite('monika.webp'),
      ),
    );
    add(
      Player(
        position: Vector2(30, 35),
        sprite: await loadSprite('kieran.webp'),
      ),
    );
    add(
      Player(
        position: Vector2(50, 30),
        sprite: await loadSprite('yuri_casual.webp'),
      ),
    );
    add(GroundObstacle(Vector2(100, 36)));
    add(GroundObstacle(Vector2(5, 50)));
    add(Obstacle(Vector2(100, 28)));
    add(Obstacle(Vector2(100, 20)));
    add(Obstacle(Vector2(100, 12)));
  }
}

class Player extends BodyComponent {
  final Vector2 position;
  final Sprite sprite;

  Player({required this.position, required this.sprite});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent(
        sprite: sprite,
        size: Vector2.all(12),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 6;
    final fixtureDef =
        FixtureDef(shape, density: 1.0, restitution: .4, friction: 0.5);
    final bodyDef = BodyDef(position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground(this.gameSize);

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(Vector2(0, gameSize.y - 4), Vector2(gameSize.x, gameSize.y));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class GroundObstacle extends BodyComponent {
  final Vector2 position;

  GroundObstacle(this.position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent(
        sprite: await gameRef.loadSprite('barrel.png'),
        size: Vector2.all(6),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    final vertices = [
      Vector2(-3, -3),
      Vector2(3, -3),
      Vector2(-3, 2.8),
      Vector2(3, 3)
    ];
    shape.set(vertices);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.3,
      density: 1,
    );
    final bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Obstacle extends BodyComponent {
  final Vector2 position;

  Obstacle(this.position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(
      SpriteComponent(
        sprite: await gameRef.loadSprite('crate.png'),
        size: Vector2.all(6),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    final vertices = [
      Vector2(-3, -3),
      Vector2(3, -3),
      Vector2(-3, 3),
      Vector2(3, 3)
    ];
    shape.set(vertices);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.3,
      density: 1,
    );
    final bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
