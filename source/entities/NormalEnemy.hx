package entities;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class NormalEnemy extends Enemy 
{	
	public var xOriginal:Float;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		//makeGraphic(4, 4, FlxColor.WHITE);
		loadGraphic(AssetPaths.Enemigo1__png, true, 20, 26);
		scale.set(0.7, 0.7);
		xOriginal = X;
		velocity.x = Reg.velEnemy;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
	}
	
	private function movement()
	{
		if (x < xOriginal) 
		{
			velocity.x = -velocity.x;
			y = y + 30;
		}
	}
}