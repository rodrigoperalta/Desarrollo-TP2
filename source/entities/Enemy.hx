package entities;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite
{
	public var eneBullets(get, null):FlxTypedGroup<Shot>;
	private var timer:Float;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		eneBullets = new FlxTypedGroup<Shot>();
		timer = 0;

	}
	
	public function get_eneBullets():FlxTypedGroup<Shot> 
	{
		return eneBullets;
	}

}