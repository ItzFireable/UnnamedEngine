package funkin.ui.menu;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup;
import flixel.util.FlxSignal;

class MenuTypedItem<T:FlxSprite> extends MenuItem
{
	public var label(default, set):T;

	public function new(x = 0.0, y = 0.0, label:T, name:String, callback)
	{
		super(x, y, name, callback);
		// set label after super otherwise setters fuck up
		this.label = label;
	}

	/**
	 * Use this when you only want to show the label
	 */
	function setEmptyBackground()
	{
		var oldWidth = width;
		var oldHeight = height;
		makeGraphic(1, 1, 0x0);
		width = oldWidth;
		height = oldHeight;
	}

	function set_label(value:T)
	{
		if (value != null)
		{
			value.x = x;
			value.y = y;
			value.alpha = alpha;
		}
		return this.label = value;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (label != null)
			label.update(elapsed);
	}

	override function draw()
	{
		super.draw();
		if (label != null)
		{
			label.cameras = cameras;
			label.scrollFactor.copyFrom(scrollFactor);
			label.draw();
		}
	}

	override function set_alpha(value:Float):Float
	{
		super.set_alpha(value);

		if (label != null)
			label.alpha = alpha;

		return alpha;
	}

	override function set_x(value:Float):Float
	{
		super.set_x(value);

		if (label != null)
			label.x = x;

		return x;
	}

	override function set_y(Value:Float):Float
	{
		super.set_y(Value);

		if (label != null)
			label.y = y;

		return y;
	}
}