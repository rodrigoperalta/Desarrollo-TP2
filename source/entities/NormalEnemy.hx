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
	private var eneBullets:FlxTypedGroup<Shot>;
	public function new(pU:FlxTypedGroup<PowerUp>,eB:FlxTypedGroup<Shot>,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(pU,X, Y, SimpleGraphic);
		eneBullets = eB;
		loadGraphic(AssetPaths.Enemigo1__png, true, 20, 26);
		scale.set(0.7, 0.7);
		xOriginal = X;
		velocity.x = Reg.velEnemy;
		updateHitbox();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
		shoot(elapsed);
		
	}

	private function movement()
	{
		if (x < xOriginal)
		{
			velocity.x = -velocity.x;
			y = y + 30;
		}
	}

	private function shoot(elapsed:Float):Void
	{
		timer += 1*elapsed;
		if (timer>1)
		{

			var bullet = new Shot(this.x+this.width/2, this.y+this.height/2);
			eneBullets.add(bullet);
			FlxG.state.add(eneBullets);
			bullet.velocity.x = -Reg.velBullet;
			timer = 0;

		}
	}

}