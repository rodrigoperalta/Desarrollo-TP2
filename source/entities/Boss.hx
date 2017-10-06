package entities;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite
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
		//shoot(elapsed);

	}
	
	
	
}