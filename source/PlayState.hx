package;

import entities.Guide;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import entities.Player;

class PlayState extends FlxState
{
	private var player:Player;
	private var guide:Guide;
	
	override public function create():Void
	{
		super.create();
		
		
		player = new entities.Player(200, 200);		
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);		
		add(new FlxSprite(0, 0, AssetPaths.cielo__jpg));
		FlxG.camera.follow(guide);
		
		//FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		
		if (FlxG.camera.x < player.x) 
		{
			
		}
		
		
		add(guide);
		add(player);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
	}
}