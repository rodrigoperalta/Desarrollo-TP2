package states;

import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import states.PlayState;
import openfl.Lib;
import flixel.FlxSprite;
/**
 * ...
 * @author ...
 */
class MenuState extends FlxState 
{
	private var nombreGrupo:FlxText;
	
	override public function create() 
	{
		FlxG.mouse.visible = true;
		var x:Int = Math.floor(FlxG.width / 2 - 40);
		var gradius = new FlxSprite(2,20,AssetPaths.gradius__png);
		add(gradius);
		nombreGrupo = new FlxText (60, 220, 0, "© 2017 R.M.N industries", 10);
		var botonNuevoJuego = new FlxButton(x, 100, "New game", nuevo);
		var botonSalir = new FlxButton(x, 160, "Exit", salida);
		add(botonNuevoJuego);
		add(botonSalir);
		add(nombreGrupo);
		
		FlxG.sound.play(AssetPaths.menu__ogg,1, true);
	}
	
	private function nuevo()
	{
		FlxG.switchState(new PlayState());
	}
	
	private function salida()
	{
		Lib.close();
	}
}