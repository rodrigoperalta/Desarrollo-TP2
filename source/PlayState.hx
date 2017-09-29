package;

import entities.Guide;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import entities.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var player:Player;
	private var guide:Guide;
	private var loader:FlxOgmoLoader;
	private var tileMap:FlxTilemap;
	
	override public function create():Void
	{
		super.create();
		
		loader = new FlxOgmoLoader(AssetPaths.gradius__oel);
		player = new entities.Player(200, 200);		
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);		
		add(new FlxSprite(0, 0, AssetPaths.fondo__png));
		FlxG.camera.follow(guide);
		
		//FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		
		
		
		add(guide);
		add(player);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		Reg.limiteX += Reg.velCamera*elapsed;
		trace(player.x);
	}
}