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
	private var highscore:FlxText;
	
	override public function create() 
	{
		FlxG.mouse.visible = true;
		var x:Int = Math.floor(FlxG.width / 2 - 40);
		ganaste = new FlxText (35, 20, 0, "¡You Win!", 28); 		
		var botonNuevoJuego = new FlxButton(x, 100, "Go to Menu", menu);
		highscore = new FlxText(40, 200, 0, "HighScore: " + Reg.highscore, 14);
		add(botonNuevoJuego);
		add(ganaste);
		add(highscore);
		
		
		FlxG.sound.play(AssetPaths.menu__ogg, 1,true);
	}
	
	private function menu()
	{
		FlxG.switchState(new MenuState());
	}
}