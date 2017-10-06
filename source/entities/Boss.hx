package entities;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Boss extends Enemy 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Boss__png, true, 100, 100);
		animation.add("Normal", [0], 1, false);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		animation.play("Normal");
		shoot(elapsed);

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