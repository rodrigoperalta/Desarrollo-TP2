package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BossShot extends FlxSprite 
{
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.balaBoss__png);
		updateHitbox();
		
		
	}
	
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (x>Reg.limiteX+FlxG.width) 
			kill();
		if (y<0) 
		{
			kill();
		}
	}
	

}