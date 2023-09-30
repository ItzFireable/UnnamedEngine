package funkin.framerate;

import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.math.FlxPoint;
import openfl.events.KeyboardEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import flixel.math.FlxMath;

class Framerate extends Sprite
{
	public static var instance:Framerate;

	public static var textFormat:TextFormat;
	public static var fpsCounter:FramerateCounter;
	public static var memoryCounter:MemoryCounter;

	/**
	 * 0: FPS INVISIBLE
	 * 1: FPS VISIBLE
	 * 2: FPS & DEBUG INFO VISIBLE
	 */
	public static var debugMode:Int = 1;

	public static var offset:FlxPoint = new FlxPoint();

	public var bgSprite:Bitmap;

	public var categories:Array<FramerateCategory> = [];

	@:isVar public static var __bitmap(get, null):BitmapData = null;

	private static function get___bitmap():BitmapData
	{
		if (__bitmap == null)
			__bitmap = new BitmapData(1, 1, 0xFF000000);
		return __bitmap;
	}

	public function new()
	{
		super();
		if (instance != null)
			throw "Cannot create another instance";

		instance = this;
		textFormat = new TextFormat("VCR OSD Mono", 12, -1);

		x = 4;
		y = 4;

		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case #if web Keyboard.NUMBER_3 #else Keyboard.F3 #end: // 3 on web or F3 on windows, linux and other things that runs code
					debugMode = (debugMode + 1) % 3;
			}
		});

		if (__bitmap == null)
			__bitmap = new BitmapData(1, 1, 0xFF000000);

		bgSprite = new Bitmap(__bitmap);
		bgSprite.alpha = 0;
		addChild(bgSprite);

		__addToList(fpsCounter = new FramerateCounter());
		__addToList(memoryCounter = new MemoryCounter());

		__addCategory(new ConductorInfo());
		__addCategory(new FlixelInfo());
		__addCategory(new SystemInfo());

		#if (gl_stats && !disable_cffi && (!html5 || !canvas))
		__addCategory(new StatsInfo());
		#end
	}

	private function __addCategory(category:FramerateCategory)
	{
		categories.push(category);
		__addToList(category);
	}

	private var __lastAddedSprite:DisplayObject = null;

	private function __addToList(spr:DisplayObject)
	{
		spr.x = 0;
		spr.y = __lastAddedSprite != null ? (__lastAddedSprite.y + __lastAddedSprite.height) : 4;
		// spr.y += offset.y;
		__lastAddedSprite = spr;
		addChild(spr);
	}

	var debugAlpha:Float = 0;

	public override function __enterFrame(t:Int)
	{
		alpha = Utils.fpsLerp(alpha, debugMode > 0 ? 1 : 0, 0.5);
		debugAlpha = Utils.fpsLerp(debugAlpha, debugMode > 1 ? 1 : 0, 0.5);

		if (alpha < 0.05)
			return;
		super.__enterFrame(t);
		bgSprite.alpha = alpha * 0.75;

		x = x + offset.x;
		y = x + offset.y;

		var width = Math.max(fpsCounter.width, memoryCounter.width) + (x * 2);
		var height = memoryCounter.y + memoryCounter.height + x;

		bgSprite.x = -x;
		bgSprite.y = fpsCounter.y - (x);
		bgSprite.scaleX = width;
		bgSprite.scaleY = height;

		var y:Float = height + x;

		for (c in categories)
		{
			c.alpha = debugAlpha;
			c.x = FlxMath.lerp(-c.width - offset.x, 0, debugAlpha);
			c.y = y;
			y = c.y + c.height + 4;
		}
	}
}
