package states;

import entities.Boss;
import entities.BossInterface;
import entities.BossShot;
import entities.Guide;
import entities.Interface;
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
	private var eneBullets:FlxTypedGroup<Shot>;
	private var bossBullets:FlxTypedGroup<BossShot>;
	private var powerUps:FlxTypedGroup <PowerUp>;
	private var player:Player;
	private var guide:Guide;
	private var loader:FlxOgmoLoader;
	private var tileMap:FlxTilemap;
	private var backGround:FlxBackdrop;
	private var enemies:FlxTypedGroup<Enemy>;
	private var enemiesMove:FlxTypedGroup<EnemyMove>;
	private var score:FlxText;
	private var puntos:Int = 0;
	private var lifes:FlxText;
	private var puntosVidas:Int = 6;
	private var boss:Boss;
	private var gui:Interface;
	private var bossGui:BossInterface;
	

	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;
		eneBullets = new FlxTypedGroup<Shot>();
		bossBullets = new FlxTypedGroup<BossShot>();
		enemies = new FlxTypedGroup<Enemy>();
		enemiesMove = new FlxTypedGroup<EnemyMove>();
		powerUps = new FlxTypedGroup<PowerUp>();
		boss = new Boss(bossBullets);
		loader = new FlxOgmoLoader(AssetPaths.gradius__oel);
		tileMap = loader.loadTilemap(AssetPaths.tiles__png, 18, 18, "Tiles");
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		guide.velocity.x = Reg.velCamera;
		backGround = new FlxBackdrop(AssetPaths.fondo__png);
		score = new FlxText(35, 220, 0, "SCORE", 8);
		score.scrollFactor.x = 0;
		score.scrollFactor.y = 0;
		lifes = new FlxText(2, 220, 0, "LIFE", 8);
		gui = new Interface(60, 215);
		//bossGui = new BossInterface(1, 1); falta la posicion
		lifes.scrollFactor.x = 0;
		lifes.scrollFactor.y = 0;
		add(backGround);
		FlxG.camera.follow(guide);
		checkTileCol();
		FlxG.worldBounds.set(0, 0, tileMap.width, tileMap.height);

		add(tileMap);
		add(guide);
		add(gui);
		add(score);
		add(lifes);
		
		FlxG.sound.play(AssetPaths.level__ogg, true);
		
		loader.loadEntities(entityCreator, "Entities");

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.limiteX += Reg.velCamera * elapsed;
		gui.doPowerUp(player.get_powerUp());
		colPlayerTileMap();
		checkLose();
		FlxG.collide(enemies, player.get_bullets(), colEnemybullet);
		if (player.get_OptionNum1())
		{
			FlxG.collide(enemies, player.get_Option1().get_bullets(), colEnemybullet);
			FlxG.collide(enemiesMove, player.get_Option1().get_bullets(), colEnemyMovebullet);
		}
		if (player.get_OptionNum2())	
		{
			FlxG.collide(enemies, player.get_Option2().get_bullets(), colEnemybullet);
			FlxG.collide(enemiesMove, player.get_Option2().get_bullets(), colEnemyMovebullet);
		}
		FlxG.collide(enemiesMove, player.get_bullets(), colEnemyMovebullet);
		FlxG.collide(enemies, player, colPlayerEnemies);
		FlxG.collide(enemiesMove, player, colPlayerEnemiesMove);		
		FlxG.collide(eneBullets , player, colPlayerBullets);	
		FlxG.collide(bossBullets , player, colPlayerBossBullets);	
		scorePantalla();
		lifePantalla();
		FlxG.collide(enemies, tileMap);
		enemiesMove.forEachAlive(checkEnemyVision);
		bossBattle();
		FlxG.collide(powerUps, player, colPlayerPowerUps);
		FlxG.collide(boss, player.get_bullets(), colBossbullet);
		FlxG.collide(boss, player, colPlayerBoss);
	
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
				var staticEne = new StaticEnemy(powerUps,eneBullets );
				staticEne.x = x;
				staticEne.y = y;
				enemies.add(staticEne);
				add(enemies);

			case "Enemy":
				var normalEne = new NormalEnemy( powerUps,eneBullets);
				normalEne.x = x;
				normalEne.y = y;
				enemies.add(normalEne);
				add(enemies);

			case "EnemyMove":
				var eneMove = new EnemyMove(powerUps);
				eneMove.x = x;
				eneMove.y = y;
				enemiesMove.add(eneMove);
				add(enemiesMove);

			case "Boss":
				//var boss = new Boss(bossBullets);
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
	
	private function colPlayerBoss(b:Boss, p:Player):Void
	{
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();
	}
	
	private function colPlayerBullets(b:Shot, p:Player):Void 
	{
		eneBullets.remove(b, true);
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();
	}
	
	private function colPlayerBossBullets(b:BossShot, p:Player):Void 
	{
		bossBullets.remove(b, true);
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();
	}

	private function colPlayerEnemiesMove(e:EnemyMove, p:Player):Void
	{
		enemiesMove.remove(e, true);
		player.kill();
		player.lose_Life();
		player.resetPlayer(guide.x - (FlxG.width / 2) + player.width / 2, FlxG.height / 2);
		contadorVidas();
	}
	
	private function colPlayerPowerUps(pU:PowerUp, p:Player):Void
	{
		powerUps.remove(pU, true);
		player.getPowerUp();
		
	}

	private function colEnemybullet(e:Enemy,s:Shot):Void
	{
		e.dropPowerUp();
		enemies.remove(e, true);
		player.get_bullets().remove(s, true);
		contadorPuntaje();
	}
	
	private function colBossbullet(b:Boss,s:Shot):Void
	{
		b.lossLife();
		player.get_bullets().remove(s, true);
		if (boss.get_vidas()==0) 
		{
			contadorPuntaje();
			boss.kill();
		}
	}

	private function colEnemyMovebullet(e:EnemyMove,s:Shot):Void
	{
		enemiesMove.remove(e, true);
		player.get_bullets().remove(s, true);
		contadorPuntaje();
	}
	
	private function checkLose():Void
	{
		if (player.get_vidas()<0)
		{
			Reg.limiteX = 0;
			FlxG.switchState(new LoseState());
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
	
	public function bossBattle()
	{
		if (FlxG.overlap(guide, boss))
		{	
			guide.velocity.x = 0;			
			player.verificador();
		}
	}
	
	public function checkTileCol()
	{
		tileMap.setTileProperties(0, FlxObject.NONE);
		for (i in 1...23)
		{
			tileMap.setTileProperties(i, FlxObject.ANY);
		}
		for (j in 24...39)
		{
			tileMap.setTileProperties(j, FlxObject.NONE);
		}
		for (k in 40...43)
		{
			tileMap.setTileProperties(k, FlxObject.ANY);
		}
		for (l in 44...59)
		{
			tileMap.setTileProperties(l, FlxObject.NONE);
		}
		for (m in 60...79)
		{
			tileMap.setTileProperties(m, FlxObject.ANY);
		}
		for (n in 80...87)
		{
			tileMap.setTileProperties(n, FlxObject.NONE);
		}
		for (o in 88...95)
		{
			tileMap.setTileProperties(o, FlxObject.ANY);
		}
		for (p in 96...99)
		{
			tileMap.setTileProperties(p, FlxObject.NONE);
		}
		for (q in 100...104)
		{
			tileMap.setTileProperties(q, FlxObject.NONE);
		}
		for (r in 105...106)
		{
			tileMap.setTileProperties(r, FlxObject.ANY);
		}
		for (s in 107...108)
		{
			tileMap.setTileProperties(s, FlxObject.NONE);
		}
		for (t in 109...110)
		{
			tileMap.setTileProperties(t, FlxObject.ANY);
		}
		tileMap.setTileProperties(111, FlxObject.NONE);
		for (u in 112...115)
		{
			tileMap.setTileProperties(u, FlxObject.ANY);

		}
		tileMap.setTileProperties(116, FlxObject.NONE);
		for (v in 117...118)
		{
			tileMap.setTileProperties(v, FlxObject.ANY);
		}
		for (w in 119...120)
		{
			tileMap.setTileProperties(w, FlxObject.NONE);
		}
		for (x in 121...122)
		{
			tileMap.setTileProperties(x, FlxObject.ANY);
		}
		for (y in 123...124)
		{
			tileMap.setTileProperties(y, FlxObject.NONE);
		}
		for (z in 125...127)
		{
			tileMap.setTileProperties(z, FlxObject.ANY);
		}
		for (i in 128...129)
		{
			tileMap.setTileProperties(i, FlxObject.NONE);
		}
		tileMap.setTileProperties(130, FlxObject.ANY);
		for (j in 131...132)
		{
			tileMap.setTileProperties(j, FlxObject.NONE);
		}
		for (k in 133...134)
		{
			tileMap.setTileProperties(k, FlxObject.ANY);
		}
		for (l in 135...139)
		{
			tileMap.setTileProperties(l, FlxObject.NONE);
		}
		for (m in 140...147)
		{
			tileMap.setTileProperties(m, FlxObject.ANY);
		}
		for (n in 148...155)
		{
			tileMap.setTileProperties(n, FlxObject.NONE);
		}
		for (o in 156...159)
		{
			tileMap.setTileProperties(o, FlxObject.ANY);
		}
		for (p in 160...167)
		{
			tileMap.setTileProperties(p, FlxObject.NONE);
		}
		for (q in 168...179)
		{
			tileMap.setTileProperties(q, FlxObject.ANY);
		}
		for (r in 180...184)
		{
			tileMap.setTileProperties(r, FlxObject.NONE);
		}
		for (s in 185...186)
		{
			tileMap.setTileProperties(s, FlxObject.ANY);
		}
		for (t in 187...188)
		{
			tileMap.setTileProperties(t, FlxObject.NONE);
		}
		for (u in 189...190)
		{
			tileMap.setTileProperties(u, FlxObject.ANY);
		}
		for (v in 191...192)
		{
			tileMap.setTileProperties(v, FlxObject.NONE);
		}
		for (w in 193...194)
		{
			tileMap.setTileProperties(w, FlxObject.ANY);
		}
		for (x in 195...200)
		{
			tileMap.setTileProperties(x, FlxObject.NONE);
		}
		for (y in 201...202)
		{
			tileMap.setTileProperties(y, FlxObject.ANY);
		}
		for (z in 203...204)
		{
			tileMap.setTileProperties(z, FlxObject.NONE);
		}
		for (i in 205...206)
		{
			tileMap.setTileProperties(i, FlxObject.ANY);
		}
		for (j in 207...212)
		{
			tileMap.setTileProperties(j, FlxObject.NONE);
		}
		for (k in 213...214)
		{
			tileMap.setTileProperties(k, FlxObject.ANY);
		}
		for (l in 215...216)
		{
			tileMap.setTileProperties(l, FlxObject.NONE);
		}
		for (m in 217...218)
		{
			tileMap.setTileProperties(m, FlxObject.ANY);
		}
		tileMap.setTileProperties(219, FlxObject.NONE);
		for (n in 219...227)
		{
			tileMap.setTileProperties(n, FlxObject.ANY);
		}
		for (o in 228...243)
		{
			tileMap.setTileProperties(o, FlxObject.NONE);
		}
		for (p in 244...247)
		{
			tileMap.setTileProperties(p, FlxObject.ANY);
		}
		for (q in 248...261)
		{
			tileMap.setTileProperties(q, FlxObject.NONE);
		}

		tileMap.setTileProperties(262, FlxObject.ANY);
		for (r in 263...285)
		{
			tileMap.setTileProperties(r, FlxObject.NONE);
		}
		tileMap.setTileProperties(286, FlxObject.ANY);
		for (s in 286...299)
		{
			tileMap.setTileProperties(s, FlxObject.NONE);
		}
		for (t in 300...303)
		{
			tileMap.setTileProperties(t, FlxObject.ANY);
		}
		for (u in 304...400)
		{
			tileMap.setTileProperties(u, FlxObject.NONE);
		}

	}
}