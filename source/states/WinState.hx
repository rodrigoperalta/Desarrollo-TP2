package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;

/**
 * ...
 * @author ...
 */
class WinState extends FlxState 
{

	private var ganaste:FlxText;
	
	override public function create() 
	{
		FlxG.mouse.visible = true;
		var x:Int = Math.floor(FlxG.width / 2 - 40);
		ganaste = new FlxText (35, 20, 0, "¡You Win!", 28); 
		
		var botonNuevoJuego = new FlxButton(x, 100, "Go back to Menu", menu);
		add(botonNuevoJuego);
		add(ganaste);
		
		FlxG.sound.play(AssetPaths.menu__ogg, true);
	}
	
	private function menu()
	{
		FlxG.switchState(new MenuState());
	}
}