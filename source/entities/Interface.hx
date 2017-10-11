package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Interface extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PowerUpsCol__png,true,240,27);
		scale.set(0.7, 0.7);
		
		animation.add("Idle", [0], 1, false);
		animation.add("SpeedUp", [5], 1, false);
		animation.add("Missile", [4], 1, false);
		animation.add("Double", [3], 1, false);
		animation.add("Option", [2], 1, false);
		animation.add("Shield", [1], 1, false);
		velocity.set(Reg.velCamera, 0);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
	
	}
	
	public function beIdle():Void
	{
		animation.play("Idle");
	}
	
	public function doPowerUp(powerUp:Int):Void
	{
		if (powerUp == 0) 
		{
			animation.play("Idle");
		}
		if (powerUp == 1) 
		{
			animation.play("SpeedUp");
		}
		if (powerUp == 2) 
		{
			animation.play("Missile");
		}
		if (powerUp == 3) 
		{
			animation.play("Double");
		}
		if (powerUp == 4)
		{
			animation.play("Option");
		}
		if (powerUp == 5)
		{
			animation.play("Shield");
		}
	}
	
}