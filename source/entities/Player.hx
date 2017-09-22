package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Rodrigo Peralta
 */
class Player extends FlxSprite
{
	private var limiteIzqX:Float;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		limiteIzqX = 0;
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.hummingbird__png, true, 32, 16);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		

	}

	override public function update(elapsed:Float):Void
	{

		limiteIzqX += Reg.velCamera*elapsed;
		super.update(elapsed);
		velocity.set(Reg.velCamera, 0);
		movement();

	}

	private function movement():Void
	{

		

		if (FlxG.keys.pressed.RIGHT)
		{
			if (x<FlxG.width+width/2)
			{
				velocity.x += 100;
			}

		}
		if (FlxG.keys.pressed.LEFT)
		{
			if (this.x>limiteIzqX)
			{
				velocity.x -= 100;
			}

		}

		if (FlxG.keys.pressed.UP)
		{
			if (y>0-height/2)
			{
				velocity.y -= 100;
			}

		}

		if (FlxG.keys.pressed.DOWN)
		{
			if (y<FlxG.height-height)
			{
				velocity.y += 100;
			}

		}

	}

}