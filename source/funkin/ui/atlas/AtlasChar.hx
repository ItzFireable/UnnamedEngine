package funkin.ui.atlas;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxStringUtil;

class AtlasChar extends FlxSprite
{
	public var char(default, set):String;

	public function new(x = 0.0, y = 0.0, atlas:FlxAtlasFrames, char:String)
	{
		super(x, y);
		frames = atlas;
		this.char = char;
		antialiasing = true;
	}

	function set_char(value:String)
	{
		if (this.char != value)
		{
			var prefix = getAnimPrefix(value);
			animation.addByPrefix("anim", prefix, 24);
			animation.play("anim");
			updateHitbox();
		}

		return this.char = value;
	}

	function getAnimPrefix(char:String)
	{
		return switch (char)
		{
			case '-': '-dash-';
			case '.': '-period-';
			case ",": '-comma-';
			case "'": '-apostraphie-';
			case "?": '-question mark-';
			case "!": '-exclamation point-';
			case "\\": '-back slash-';
			case "/": '-forward slash-';
			case "*": '-multiply x-';
			case "“": '-start quote-';
			case "”": '-end quote-';
			default: char;
		}
	}
}
