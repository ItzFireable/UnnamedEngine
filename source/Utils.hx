package;

import sys.FileSystem;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxSort;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Json;
import lime.math.Rectangle;
import lime.utils.Assets;

class Utils
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
			dumbArray.push(i);

		return dumbArray;
	}

	public static function camLerpShit(lerp:Float):Float
	{
		return lerp * (FlxG.elapsed / (1 / 60));
	}

	public static function coolLerp(a:Float, b:Float, ratio:Float):Float
	{
		return FlxMath.lerp(a, b, camLerpShit(ratio));
	}

	public static function setDarkMode(title:String, enable:Bool)
	{
		#if windows
		Windows.setDarkMode(title, enable);
		#end
	}

	public static inline function getFPSRatio(ratio:Float):Float
	{
		return FlxMath.bound(ratio * 60 * FlxG.elapsed, 0, 1);
	}

	public static inline function fpsLerp(v1:Float, v2:Float, ratio:Float):Float
	{
		return FlxMath.lerp(v1, v2, getFPSRatio(ratio));
	}

	public static function getSizeString(size:Float):String
	{
		var labels = ["B", "KB", "MB", "GB", "TB"];
		var rSize:Float = size;
		var label:Int = 0;
		while (rSize > 1024 && label < labels.length - 1)
		{
			label++;
			rSize /= 1024;
		}
		return '${Std.int(rSize) + "." + addZeros(Std.string(Std.int((rSize % 1) * 100)), 2)}${labels[label]}';
	}

	public static inline function addZeros(str:String, num:Int)
	{
		while (str.length < num)
			str = '0${str}';
		return str;
	}

	public static function sortNotesAsc(Obj1:Note, Obj2:Note):Int
	{
		return Utils.sortNotes(FlxSort.ASCENDING, Obj1, Obj2);
	}

	public static function sortNotes(order:Int = FlxSort.ASCENDING, Obj1:Note, Obj2:Note)
	{
		return FlxSort.byValues(order, Obj1.strumTime, Obj2.strumTime);
	}

	public static function getCharacters():Array<String>
	{
		var chars:Array<String> = [];
		var directory:String = 'assets/data/characters';

		if (FileSystem.exists(directory))
			for (file in FileSystem.readDirectory(directory))
			{
				var path = haxe.io.Path.join([directory, file]);
				if (!sys.FileSystem.isDirectory(path) && file.endsWith('.json'))
					chars.push(file);
			}

		for (i in 0...chars.length)
			chars[i] = StringTools.replace(chars[i], '.json', '');

		return chars;
	}

	public static function parseSongJSON(rawJson:String):SongData
	{
		var swagShit = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}

	public static function getRawJSON(path:String):String
	{
		var rawJson = Assets.getText(Paths.json(path)).trim();
		while (!rawJson.endsWith("}"))
			rawJson = rawJson.substr(0, rawJson.length - 1);

		return rawJson;
	}

	public static function getSongData(object:String, ?folder:String):SongData
	{
		var targetFolder = folder.length > 0 ? 'charts/' + folder.toLowerCase() : 'charts';
		var rawJson = getRawJSON(targetFolder + '/' + object.toLowerCase());
		return parseSongJSON(rawJson);
	}

	public static function getCharacterData(object:String, ?folder:String):CharacterData
	{
		var targetFolder = folder.length > 0 ? 'characters/' + folder.toLowerCase() : 'characters';
		var name:String = targetFolder + '/' + object.toLowerCase();
		
		if(!Paths.fileExists('data/' + name + '.json', IMAGE)) 
		{
			object = 'bf';
			name = targetFolder + '/' + object.toLowerCase();
		}

		var rawJson = getRawJSON(name);
		var swagShit = cast Json.parse(rawJson);

		return swagShit;
	}
}
