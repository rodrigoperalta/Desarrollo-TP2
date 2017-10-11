package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BossInterface extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.BossLife__png, true, 240, 27);//falta la posicion
		scale.set(0.7, 0.7);
		animation.add("vidallena", [0], 1, false);
		animation.add("vida--", [1], 1, false);
		animation.add("vida-2",[2], 1, false);
		animation.add("vida-3", [3], 1, false);
		animation.add("vida-4", [4], 1, false);
		animation.add("chile", [5], 1, false);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		velocity.set(Reg.velCamera, 0);
	}

	/*public function BarraDelBoss():Void
	{
		if (Boss.get_vidas()== 50)
		{
			animation.play("vidallena");
		}
		if (Boss.get_vidas() == 40)
		{
			animation.play("vida--");
		}
		if (Boss.get_vidas() == 30)
		{
			animation.play("vida-2");
		}
		if (Boss.get_vidas()== 20)
		{
			animation.play("vida-3");
		}
		if (Boss.get_vidas()== 10)
		{
			animation.play("vida-4");
		}
		if (Boss.get_vidas() == 0)
		{
			animation.play("chile");
		}
	}*/

}