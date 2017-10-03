package states;

import entities.Guide;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import entities.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
class PlayState extends FlxState
{
	private var player:Player;
	private var guide:Guide;
	private var loader:FlxOgmoLoader;
	private var tileMap:FlxTilemap;
	private var backGround:FlxBackdrop;
	

	override public function create():Void
	{
		super.create();

		loader = new FlxOgmoLoader(AssetPaths.gradius__oel);
		tileMap = loader.loadTilemap(AssetPaths.tiles__png, 18, 18, "Tiles");
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		guide.velocity.x = Reg.velCamera;
		backGround = new FlxBackdrop(AssetPaths.fondo__png);
		add(backGround);
		FlxG.camera.follow(guide);
		tileMap.setTileProperties(0, FlxObject.ANY);
		
		//FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);

		add(tileMap);
		add(guide);

		loader.loadEntities(entityCreator, "Entities");
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		Reg.limiteX += Reg.velCamera*elapsed;

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

			//case "enemy":
			

		}
	}

}