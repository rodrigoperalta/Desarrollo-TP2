package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/gradius.oel", "assets/data/gradius.oel");
			type.set ("assets/data/gradius.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/gradius.oep", "assets/data/gradius.oep");
			type.set ("assets/data/gradius.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/bala boss.png", "assets/images/bala boss.png");
			type.set ("assets/images/bala boss.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/bala.png", "assets/images/bala.png");
			type.set ("assets/images/bala.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Boss.png", "assets/images/Boss.png");
			type.set ("assets/images/Boss.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/BossLife.png", "assets/images/BossLife.png");
			type.set ("assets/images/BossLife.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Enemigo1.png", "assets/images/Enemigo1.png");
			type.set ("assets/images/Enemigo1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Enemigo2.png", "assets/images/Enemigo2.png");
			type.set ("assets/images/Enemigo2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/explosion.png", "assets/images/explosion.png");
			type.set ("assets/images/explosion.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fondo.png", "assets/images/fondo.png");
			type.set ("assets/images/fondo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/gradius.png", "assets/images/gradius.png");
			type.set ("assets/images/gradius.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/gradius1.png", "assets/images/gradius1.png");
			type.set ("assets/images/gradius1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/NaveFinal.png", "assets/images/NaveFinal.png");
			type.set ("assets/images/NaveFinal.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/PowerUp.png", "assets/images/PowerUp.png");
			type.set ("assets/images/PowerUp.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/PowerUps.png", "assets/images/PowerUps.png");
			type.set ("assets/images/PowerUps.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/PowerUps2.png", "assets/images/PowerUps2.png");
			type.set ("assets/images/PowerUps2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/PowerUpsCol.png", "assets/images/PowerUpsCol.png");
			type.set ("assets/images/PowerUpsCol.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/level.ogg", "assets/music/level.ogg");
			type.set ("assets/music/level.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/menu.ogg", "assets/music/menu.ogg");
			type.set ("assets/music/menu.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/disparo.ogg", "assets/sounds/disparo.ogg");
			type.set ("assets/sounds/disparo.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/muerteEnemigos.ogg", "assets/sounds/muerteEnemigos.ogg");
			type.set ("assets/sounds/muerteEnemigos.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/muertePj.ogg", "assets/sounds/muertePj.ogg");
			type.set ("assets/sounds/muertePj.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
