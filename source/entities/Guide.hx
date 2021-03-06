package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Rodrigo Peralta
 */
class Guide extends FlxSprite
{
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{

		super(X, Y, SimpleGraphic);
		makeGraphic(1, 1, 0x00000000);
		velocity.x = Reg.velCamera;

	}

	override function update (elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	

}