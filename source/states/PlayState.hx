package states;

import entities.Guide;
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
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;

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

	override public function create():Void
	{
		super.create();

		powerUp = new PowerUp(200, 10);
		powerUp2 = new PowerUp(250, 10);
		powerUp3 = new PowerUp(150, 10);
		enemies = new FlxTypedGroup<Enemy>();
		loader = new FlxOgmoLoader(AssetPaths.gradius__oel);
		tileMap = loader.loadTilemap(AssetPaths.tiles__png, 18, 18, "Tiles");
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		guide.velocity.x = Reg.velCamera;
		backGround = new FlxBackdrop(AssetPaths.fondo__png);
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

		loader.loadEntities(entityCreator, "Entities");

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.limiteX += Reg.velCamera * elapsed;
		colPlayerPowerUp();
		colPlayerTileMap();
		FlxG.overlap(enemies, player.get_bullet(), colStaticEnemyBullet);
		FlxG.overlap(enemies, player.get_bulletDouble(), colStaticEnemyBullet);
		FlxG.overlap(enemies, player.get_bulletMissile(), colStaticEnemyBullet);

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

		}
	}

	private function colPlayerTileMap():Void
	{
		
		if (FlxG.collide(tileMap, player))
		{
			trace("holi");
		}
	}
	
	private function colStaticEnemyBullet(e:Enemy,s:Shot):Void
	{
		enemies.remove(e, true);
		s.kill();
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

}