package funkin.ui.menu;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup;
import flixel.util.FlxSignal;

class MenuItem extends FlxSprite
{
	public var callback:Void->Void;
	public var name:String;

	/**
	 * Set to true for things like opening URLs otherwise, it may it get blocked.
	 */
	public var fireInstantly = false;

	public var selected(get, never):Bool;

	function get_selected()
		return alpha == 1.0;

	public function new(x = 0.0, y = 0.0, name:String, callback)
	{
		super(x, y);

		antialiasing = true;
		setData(name, callback);
		idle();
	}

	function setData(name:String, ?callback:Void->Void)
	{
		this.name = name;

		if (callback != null)
			this.callback = callback;
	}

	/**
	 * Calls setData and resets/redraws the state of the item
	 * @param name      the label.
	 * @param callback  Unchanged if null.
	 */
	public function setItem(name:String, ?callback:Void->Void)
	{
		setData(name, callback);

		if (selected)
			select();
		else
			idle();
	}

	public function idle()
	{
		alpha = 0.6;
	}

	public function select()
	{
		alpha = 1.0;
	}
}