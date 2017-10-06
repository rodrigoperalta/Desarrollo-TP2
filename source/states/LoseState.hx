package states;

import flixel.FlxState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * ...
 * @author ...
 */
class LoseState extends FlxState 
{
	private var perdiste:FlxText;
	
	override public function create() 
	{
		FlxG.mouse.visible = true;
		var x:Int = Math.floor(FlxG.width / 2 - 40);
		perdiste = new FlxText (35, 20, 0, "You Lose!", 28);  
		var botonReiniciar = new FlxButton(x, 120, "Restart", reiniciar);
		var botonMenu = new FlxButton(x, 180, "Back to Menu", menu);
		
		add(botonMenu);
		add(botonReiniciar);
		add(perdiste);
	}
	
	function reiniciar() 
	{
		FlxG.switchState(new PlayState());
	}
	
	function menu() 
	{
		FlxG.switchState(new MenuState());
	}
	
}