package;

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

using StringTools;

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
}
