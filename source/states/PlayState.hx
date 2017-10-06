package states;

import entities.Boss;
import entities.Guide;
import entities.NormalEnemy;
import entities.PowerUp;
import entities.Enemy;
import entities.Shot;
import entities.StaticEnemy;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import entities.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.Lib;
import states.LoseState;
import entities.EnemyMove;

class PlayState extends FlxState
{
	private var player:Player;
	private var guide:Guide;
	private var loader:FlxOgmoLoader;
	private var tileMap:FlxTilemap;
	private var backGround:FlxBackdrop;
	private var powerUp:PowerUp;
	private var powerUp2:PowerUp;
	private var powerUp3:PowerUp;
	private var enemies:FlxTypedGroup<Enemy>;
	private var enemiesMove:FlxTypedGroup<EnemyMove>;
	private var score:FlxText;
	private var puntos:Int = 0;
	private var lifes:FlxText;
	private var puntosVidas:Int = 3;

	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;
		powerUp = new PowerUp(200, 10);
		powerUp2 = new PowerUp(250, 10);
		powerUp3 = new PowerUp(150, 10);
		enemies = new FlxTypedGroup<Enemy>();
		enemiesMove = new FlxTypedGroup<EnemyMove>();
		loader = new FlxOgmoLoader(AssetPaths.gradius__oel);
		tileMap = loader.loadTilemap(AssetPaths.tiles__png, 18, 18, "Tiles");
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		guide.velocity.x = Reg.velCamera;
		backGround = new FlxBackdrop(AssetPaths.fondo__png);
		score = new FlxText(50, 220, 0, "SCORE", 8);
		score.scrollFactor.x = 0;
		score.scrollFactor.y = 0;
		lifes = new FlxText(2, 220, 0, "LIFE", 8);
		lifes.scrollFactor.x = 0;
		lifes.scrollFactor.y = 0;
		add(backGround);
		FlxG.camera.follow(guide);
		tileMap.setTileProperties(0, FlxObject.NONE);
		tileMap.setTileProperties(1, FlxObject.ANY);

		FlxG.worldBounds.set(0, 0, tileMap.width, tileMap.height);

		add(tileMap);
		add(guide);
		add(powerUp);
		add(powerUp2);
		add(powerUp3);
		add(score);
		add(lifes);

		loader.loadEntities(entityCreator, "Entities");

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.limiteX += Reg.velCamera * elapsed;
		colPlayerPowerUp();
		colPlayerTileMap();
		checkLose();
		FlxG.collide(enemies, player.get_bullets(), colEnemybullet);
		FlxG.collide(enemiesMove, player.get_bullets(), colEnemyMovebullet);
		FlxG.collide(enemies, player, colPlayerEnemies);
		FlxG.collide(enemiesMove, player, colPlayerEnemiesMove);
		//FlxG.collide(, player, colPlayerEnemiesMove);
		scorePantalla();
		lifePantalla();
		FlxG.collide(enemies, tileMap);
		enemiesMove.forEachAlive(checkEnemyVision);
	}

	private function checkEnemyVision(e:EnemyMove):Void
	{
		if (tileMap.ray(e.getMidpoint(), player.getMidpoint()))
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(player.getMidpoint());
		}
		else
			e.seesPlayer = false;
	}

	private function entityCreator(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "Player":
				player = new Player();

				player.x = x;
				player.y = y;
				add(player);

			case "FixEnemy":
				var staticEne = new StaticEnemy();
				staticEne.x = x;
				staticEne.y = y;
				enemies.add(staticEne);
				add(enemies);

			case "Enemy":
				var normalEne = new NormalEnemy();
				normalEne.x = x;
				normalEne.y = y;
				enemies.add(normalEne);
				add(enemies);

			case "EnemyMove":
				var eneMove = new EnemyMove();
				eneMove.x = x;
				eneMove.y = y;
				enemiesMove.add(eneMove);
				add(enemiesMove);

			case "Boss":
				var boss = new Boss();
				boss.x = x;
				boss.y = y;
				add(boss);

		}
	}

	private function colPlayerTileMap():Void
	{

		if (FlxG.collide(tileMap, player))
		{
			player.kill();
			player.lose_Life();
			player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
			contadorVidas();

		}
	}

	private function colPlayerEnemies(e:Enemy, p:Player):Void
	{
		enemies.remove(e, true);
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();		
	}
	
	
	/*private function colPlayerBullets(b:Shot, p:Player):Void
	{
		enemies.remove(b, true);
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();		
	}*/
	
	private function colPlayerEnemiesMove(e:EnemyMove, p:Player):Void
	{
		enemiesMove.remove(e, true);
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();		
	}

	/*private function colNormalEnemyMap()
	{
	if (FlxG.collide(tileMap, enemies))
	enemies.kill();
	}*/

	private function colEnemybullet(e:Enemy,s:Shot):Void
	{
		enemies.remove(e, true);
		player.get_bullets().remove(s, true);
		contadorPuntaje();
	}

	private function colEnemyMovebullet(e:EnemyMove,s:Shot):Void
	{
		enemiesMove.remove(e, true);
		player.get_bullets().remove(s, true);
		contadorPuntaje();
	}

	private function colStaticEnemyBulletplayer(p:Player,s:Shot):Void
	{

	}

	private function checkLose():Void
	{
		if (player.get_vidas()<0)
		{

			FlxG.switchState(new LoseState());
		}
	}

	private function colPlayerPowerUp():Void
	{
		if (FlxG.overlap(player,powerUp) )
		{
			player.getPowerUp();
			powerUp.kill();
		}

		if (FlxG.overlap(player,powerUp2) )
		{
			player.getPowerUp();
			powerUp2.kill();
		}

		if (FlxG.overlap(player,powerUp3) )
		{
			player.getPowerUp();
			powerUp3.kill();
		}
	}

	public function contadorPuntaje()
	{
		puntos += 100;
	}

	public function contadorVidas()
	{
		puntosVidas -= 1;
	}

	public function lifePantalla()
	{
		lifes.text = "LIFE " + puntosVidas;
	}
	public function scorePantalla()
	{
		score.text = "SCORE " + puntos;
	}
}