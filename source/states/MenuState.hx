package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import states.PlayState;
import openfl.Lib;

/**
 * ...
 * @author ...
 */
class MenuState extends FlxState 
{
	private var nombreJuego:FlxText;
	private var nombreGrupo:FlxText;
	
	override public function create() 
	{
		var x:Int = Math.floor(FlxG.width / 2 - 40);
		nombreJuego = new FlxText (50, 20, 0, "GRADIUS", 32);  
		nombreGrupo = new FlxText (130, 390, 0, "© 2017 R.M.N industries", 12);
		var botonNuevoJuego = new FlxButton(x, 120, "New game", nuevo);
		var botonSalir = new FlxButton(x, 180, "Exit", salida);
		
		add(botonNuevoJuego);
		add(botonSalir);
		add(nombreJuego);
		add(nombreGrupo);
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