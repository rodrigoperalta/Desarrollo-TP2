package entities;

import flixel.FlxG;
import flixel.FlxSprite;

import flixel.system.FlxAssets.FlxGraphicAsset;
import entities.Shot;

/**
 * ...
 * @author Rodrigo Peralta
 */
class Player extends FlxSprite
{

	public var bullet:Shot;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{

		super(X, Y, SimpleGraphic);

		loadGraphic(AssetPaths.hummingbird__png, true, 32, 16);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		bullet = new Shot();
		FlxG.state.add(bullet);

	}

	override public function update(elapsed:Float):Void
	{

		super.update(elapsed);
		velocity.set(Reg.velCamera, 0);
		movement();
		shoot();

	}

	private function movement():Void
	{

		if (FlxG.keys.pressed.RIGHT)
		{
			if (this.x<Reg.limiteX+FlxG.width-this.width)
			{
				velocity.x += 100;
			}

		}
		if (FlxG.keys.pressed.LEFT)
		{
			if (this.x>Reg.limiteX)
			{
				velocity.x -= 100;
			}

		}

		if (FlxG.keys.pressed.UP)
		{
			if (y>0+this.height/2)
			{
				velocity.y -= 100;
			}

		}

		if (FlxG.keys.pressed.DOWN)
		{
			if (y<FlxG.height-this.height)
			{
				velocity.y += 100;
			}

		}

	}

	private function shoot():Void
	{
		if (FlxG.keys.justPressed.SPACE)
		{
			bullet.reset(this.x + 10, this.y + 5);

			bullet.velocity.x = Reg.velBullet;
		}

	}

}