package entities;

//import cpp.Void;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import entities.Shot;


/**
 * ...
 * @author Rodrigo Peralta
 */
class Player extends FlxSprite
{

	private var bullets(get, null):FlxTypedGroup<Shot>;
	private var vidas(get, null):Int;
	private var powerUp(get, null):Int;
	private var pU:PowerUp;
	private var double:Bool;
	private var missile:Bool;
	

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{

		super(X, Y, SimpleGraphic);
		pU = new PowerUp();
		double = false;
		missile = false;
		vidas = 3;
		loadGraphic(AssetPaths.NaveFinal__png, true, 38, 38);
		animation.add("up", [1], 1, false);
		animation.add("down", [2], 1, false);
		animation.add("straight", [0], 1, false);
		
		
		animation.play("straight");
		bullets = new FlxTypedGroup<Shot>();
		scale.set(0.7, 0.7);
		updateHitbox();
		height = height / 2;
		offset.y = height;
		powerUp = 0;
	}

	override public function update(elapsed:Float):Void
	{

		super.update(elapsed);
		velocity.set(Reg.velCamera, 0);
		movement();
		shoot();
		aniMov();
		activatePowerUp();
		//trace(powerUp);

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
			if (y>0)
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
			var bullet = new Shot(this.x + 5, this.y + 5);
			bullets.add(bullet);
			FlxG.state.add(bullets);

			bullet.velocity.x = Reg.velBullet;

			if (double == true)
			{

				var bulletDouble = new Shot(this.x + 5, this.y + 5);
				bullets.add(bulletDouble);
				FlxG.state.add(bullets);

				bulletDouble.velocity.x = Reg.velBulletDoubleX;
				bulletDouble.velocity.y = Reg.velBulletDoubleY;

			}

			if (missile == true)
			{

				var bulletMissile = new Shot(this.x + 5, this.y + 5);
				bullets.add(bulletMissile);
				FlxG.state.add(bullets);

				bulletMissile.velocity.x = Reg.velBulletMissileX;
				bulletMissile.velocity.y = Reg.velBulletMissileY;

			}
		}

	}
	
	public function resetPlayer(x:Float,y:Float):Void
	{
		this.reset(x, y);
		double = false;
		missile = false;
		powerUp = 0;
	}

	public function getPowerUp():Void
	{
		powerUp+=1;
	}

	private function activatePowerUp():Void
	{
		if (FlxG.keys.justPressed.Z)
		{

			if (powerUp == 1)
			{
				pU.speedUP();
			}

			if (powerUp == 2)
			{
				double = true;
			}

			if (powerUp == 3)
			{
				missile = true;
			}

			powerUp = 0;
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

	public function get_vidas():Int
	{
		return vidas;
	}

	public function lose_Life():Void
	{
		
			vidas-=1;
		

	}

	public function get_bullets():FlxTypedGroup<Shot>
	{
		return bullets;
	}
	
	public function get_powerUp():Int 
	{
		return powerUp;
	}

	
}

