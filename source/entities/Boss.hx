package entities;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite
{
	private var velocidad:FlxMath;
	private var timer:Float;
	public var vidas(get, null):Int;
	private var bossBullets:FlxTypedGroup<BossShot>;

	public function new(bB:FlxTypedGroup<BossShot>,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		timer = 0;
		bossBullets = bB;
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Boss__png, true, 100, 100);
		animation.add("Normal", [0], 1, false);
		velocity.y = -10;
		vidas = 50;

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		animation.play("Normal");
		shoot(elapsed);
		movimiento();
		timer+=1;
	}

	function movimiento()
	{
		if (y >  FlxG.height - 24 - height)
			velocity.y -= 10;
		if (y <= 0)
			velocity.y += 10;
	}

	public function lossLife()
	{

		vidas--;

	}

	private function shoot(elapsed:Float):Void
	{
		if ((FlxG.camera.scroll.x + FlxG.camera.width) > this.x && timer>80)
		{
			var bullet = new BossShot(this.x+this.width/2, this.y+this.height/2);
			bossBullets.add(bullet);
			FlxG.state.add(bossBullets);
			bullet.velocity.x = -Reg.velBullet;
			timer = 0;
		}
	}

	public function get_vidas():Int
	{
		return vidas;
	}

}