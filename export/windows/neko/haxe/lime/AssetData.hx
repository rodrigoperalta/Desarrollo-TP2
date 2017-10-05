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
			path.set ("assets/images/Boss.png", "assets/images/Boss.png");
			type.set ("assets/images/Boss.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Enemigo 1.png", "assets/images/Enemigo 1.png");
			type.set ("assets/images/Enemigo 1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Enemigo2.png", "assets/images/Enemigo2.png");
			type.set ("assets/images/Enemigo2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fondo.png", "assets/images/fondo.png");
			type.set ("assets/images/fondo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/NaveFinal.png", "assets/images/NaveFinal.png");
			type.set ("assets/images/NaveFinal.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
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
