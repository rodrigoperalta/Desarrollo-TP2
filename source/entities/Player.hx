package entities;

//import cpp.Void;
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
	private var vidas(get, null):Int;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{

		super(X, Y, SimpleGraphic);
		vidas = 3;
		loadGraphic(AssetPaths.NaveFinal__png, true, 38, 38);
		animation.add("up", [1], 1, false);
		animation.add("down", [2], 1, false);
		animation.add("straight", [0], 1, false);
		animation.play("straight");
		bullet = new Shot();
		FlxG.state.add(bullet);
		scale.set(0.7, 0.7);
		updateHitbox();
		height = height / 2;
		offset.y = height;
	}

	override public function update(elapsed:Float):Void
	{

		super.update(elapsed);
		velocity.set(Reg.velCamera, 0);
		movement();
		shoot();
		aniMov();

	}

	private function movement():Void
	{

		if (FlxG.keys.pressed.RIGHT)
		{
			if (this.x<Reg.limiteX+FlxG.width-this.width)
			{
				velocity.x += Reg.velPlayer;
			}

		}
		if (FlxG.keys.pressed.LEFT)
		{
			if (this.x>Reg.limiteX)
			{
				velocity.x -= Reg.velPlayer;
			}

		}

		if (FlxG.keys.pressed.UP)
		{
			if (y>0/*+this.height/2*/)
			{
				velocity.y -= Reg.velPlayer;
			}

		}

		if (FlxG.keys.pressed.DOWN)
		{
			if (y<FlxG.height-this.height)
			{
				velocity.y += Reg.velPlayer;
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

	private function aniMov():Void
	{
		if (this.velocity.y == 0)
		{
			animation.play("straight");
		}
		else if (this.velocity.y >0)
		{
			animation.play("down");
		}
		else
		{
			animation.play("up");
		}
	}

	function get_vidas():Int
	{
		return vidas;
	}
	
	public function lose_Life():Void
	{
		if (vidas !=0)
		{
			vidas--;
		}

	}
}

