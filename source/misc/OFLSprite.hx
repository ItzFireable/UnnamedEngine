// From: Kade Engine
package misc;

import flixel.util.FlxColor;
import openfl.display.Sprite;
import flixel.FlxSprite;

class OFLSprite extends FlxSprite
{
	public var flSprite:Sprite;

	public function new(x, y, width, height, Sprite:Sprite)
	{
		super(x, y);

		makeGraphic(width, height, FlxColor.TRANSPARENT);

		flSprite = Sprite;

		pixels.draw(flSprite);
	}

	private var _frameCount:Int = 0;

	override function update(elapsed:Float)
	{
		if (_frameCount != 2)
		{
			pixels.draw(flSprite);
			_frameCount++;
		}
	}

	public function updateDisplay()
	{
		pixels.draw(flSprite);
	}
}
