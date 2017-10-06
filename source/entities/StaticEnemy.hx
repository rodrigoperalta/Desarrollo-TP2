package entities;

import flixel.FlxG;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author ...
 */
class StaticEnemy extends Enemy
{

	private var eneBullets:FlxTypedGroup<Shot>;

	public function new(pU:FlxTypedGroup<PowerUp>,eB:FlxTypedGroup<Shot>, ?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(pU,X, Y, SimpleGraphic);
		eneBullets = eB;
		loadGraphic(AssetPaths.Enemigo2__png, true, 26, 18);
		animation.add("Ceiling", [0], 1, false);
		animation.add("Floor", [1], 1, false);

	}

	override public function update(elapsed:Float):Void
	{
		addSprite();
		shoot(elapsed);
		
		
	}

	private function addSprite():Void
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

	private function shoot(elapsed:Float):Void
	{
		timer += 1*elapsed;
		if (timer>3)
		{
			if (this.y>FlxG.height/2)
			{
				var bullet = new Shot(this.x+this.width/2, this.y + 5);
				eneBullets.add(bullet);
				FlxG.state.add(eneBullets);
				bullet.velocity.y = -Reg.velBullet;

			}

			if (this.y<FlxG.height/2)
			{
				var bullet = new Shot(this.x+this.width/2, this.y + 5);
				eneBullets.add(bullet);
				FlxG.state.add(eneBullets);
				bullet.velocity.y = Reg.velBullet;
			}

			timer = 0;

		}
	}

}