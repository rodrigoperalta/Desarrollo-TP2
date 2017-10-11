package entities;

//import cpp.Void;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.weapon.FlxBullet;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import entities.Shot;
import entities.Guide;

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
	private var verif:Bool;
	private var shield:Bool;
	private var optionNum1:Bool;
	private var optionNum2:Bool;
	private var option1:Option;
	private var option2:Option;
	private var guide:Guide;

	public function new(g:Guide,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		guide = g;
		super(X, Y, SimpleGraphic);
		pU = new PowerUp();
		double = false;
		missile = false;
		verif = false;
		shield = false;
		vidas = 10006;
		loadGraphic(AssetPaths.NaveFinal__png, true, 38, 38);
		animation.add("up", [1], 1, false);
		animation.add("down", [2], 1, false);
		animation.add("straight", [0], 1, false);
		optionNum1 = false;
		optionNum2 = false;

		animation.play("straight");
		bullets = new FlxTypedGroup<Shot>();
		scale.set(0.7, 0.7);
		updateHitbox();
		height = height / 2;
		offset.y = height;
		powerUp = 5;
	}

	override public function update(elapsed:Float):Void
	{

		super.update(elapsed);
		if (!verif)
			velocity.set(Reg.velCamera, 0);
		else
			velocity.set(0, 0);
		movement();
		shoot();
		aniMov();
		activatePowerUp();

		bullets.forEachAlive(detectarVelocidad);

	}

	public function getguide(g:Guide)
	{
		guide = g;
	}

	public function detectarVelocidad(shoot:Shot):Void
	{
		if (shoot.velocity.x < Reg.velBullet && shoot.velocity.y == 0)
			shoot.kill();
	}

	public function verificador()
	{
		verif = true;
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

		if (FlxG.keys.justPressed.P)
		{
			vidas = 1000;
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

	public function die():Void
	{
		if (shield == false)
		{
			this.kill();
			this.reset(guide.x - (FlxG.width / 2) + this.width / 2, FlxG.height / 2);
		}
		if (shield == true)
		{
			shield = false;
		}

	}

	public function resetPlayer(x:Float,y:Float):Void
	{
		this.reset(x, y);
		double = false;
		missile = false;
		if (optionNum1)
			option1.destroy();
		optionNum1 = false;
		if (optionNum2)
			option2.destroy();
		optionNum2 = false;
		if (Reg.velPlayer == 250)
			Reg.velPlayer -= 100;
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

			if (powerUp == 4)
			{
				if (optionNum1 && !optionNum2)
				{
					option2 = new Option(guide,option1.x - option1.width, option1.y, option1);
					optionNum2 = true;
					FlxG.state.add(option2);
				}
				else
				{
					if (!optionNum1)
					{
						option1 = new Option (guide,x - width, y, this);
						optionNum1 = true;
						FlxG.state.add(option1);
					}
				}

			}

			if (powerUp == 5)
			{
				shield = true;
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

	public function get_Option1():Option
	{
		return option1;
	}

	public function get_Option2():Option
	{
		return option2;
	}

	public function get_OptionNum1():Bool
	{
		return optionNum1;
	}

	public function get_OptionNum2():Bool
	{
		return optionNum2;
	}
}

