package funkin.ui.atlas;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxStringUtil;

class AtlasFontData
{
	static public var upperChar = ~/^[A-Z]\d+$/;
	static public var lowerChar = ~/^[a-z]\d+$/;

	public var atlas:FlxAtlasFrames;
	public var maxHeight:Float = 0.0;
	public var caseAllowed:Case = Both;

	public function new(name:AtlasFont)
	{
		atlas = Paths.getSparrowAtlas("fonts/" + name.getName().toLowerCase());
		atlas.parent.destroyOnNoUse = false;
		atlas.parent.persist = true;

		var containsUpper = false;
		var containsLower = false;

		for (frame in atlas.frames)
		{
			maxHeight = Math.max(maxHeight, frame.frame.height);

			if (!containsUpper)
				containsUpper = upperChar.match(frame.name);

			if (!containsLower)
				containsLower = lowerChar.match(frame.name);
		}

		if (containsUpper != containsLower)
			caseAllowed = containsUpper ? Upper : Lower;
	}
}
