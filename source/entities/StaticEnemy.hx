package entities;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class StaticEnemy extends Enemy
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Enemigo2__png, true, 26, 18);
		animation.add("Ceiling", [0], 1, false);
		animation.add("Floor", [1], 1, false);
	

	}
	
	override public function update(elapsed:Float):Void
	{
		if (this.y<FlxG.height/2)
		{
			animation.play("Ceiling");
		}
		else
		{
			animation.play("Floor");
		}
	}

}