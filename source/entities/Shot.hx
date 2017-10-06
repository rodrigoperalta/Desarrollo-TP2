package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Shot extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(3, 3);
		
		
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