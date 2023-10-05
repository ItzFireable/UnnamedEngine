package funkin.objects;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	var char:String = '';
	var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);
		antialiasing = true;
		scrollFactor.set();
	}

	public function changeIcon(newChar:String):Void
	{
		newChar = newChar.trim();

		if (newChar != char)
		{
			var name:String = 'icons/' + newChar;
			if(!Paths.fileExists(name + '.png', IMAGE)) name = 'icons/icon-face';

			loadGraphic(Paths.image('icons/icon-' + newChar), true, 150, 150);
			animation.add(newChar, [0, 1], 0, false, isPlayer);
			
			animation.play(newChar);
			char = newChar;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
