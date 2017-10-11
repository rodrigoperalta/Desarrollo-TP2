package entities;

import entities.Player;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Option extends Player 
{
	private var player:Player;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, _player:Player) 
	{
		super(X, Y, SimpleGraphic);
		
		player = _player;
		
	}
	
	override function movement():Void 
	{
		if (player.velocity.y != 0)
        {
            if (y > player.y - player.height)
                velocity.y -= Reg.velPlayer;
            if (y < player.y + player.height)
                velocity.y += Reg.velPlayer;
        }
        if (player.velocity.x != Reg.velCamera)
        {
            if (x > player.x + player.width)
                velocity.x -= Reg.velPlayer + Reg.velCamera;
            if (x < player.x - player.width)
                velocity.x += Reg.velPlayer;
        }
	}
	
	override function activatePowerUp():Void
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
}