package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class PowerUp extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(5, 5);
		
	}
	
	override function update (elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	
	public function speedUP():Void
	{
		Reg.velPlayer += 400;
	}
	
	
	
	
	
	
}