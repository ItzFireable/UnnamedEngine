package funkin.ui.objects;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.input.actions.FlxActionInput;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class InputItem extends TextMenuItem
{
	public var device(default, null):Device = Keys;
	public var control:Control;
	public var input:Int = -1;
	public var index:Int = -1;

	public function new(x = 0.0, y = 0.0, device, control, index, ?callback)
	{
		this.device = device;
		this.control = control;
		this.index = index;
		this.input = getInput();

		super(x, y, getLabel(input), Default, callback);
	}

	public function updateDevice(device:Device)
	{
		if (this.device != device)
		{
			this.device = device;
			input = getInput();
			label.text = getLabel(input);
		}
	}

	function getInput()
	{
		var list = PlayerSettings.player1.controls.getInputsFor(control, device);
		if (list.length > index)
		{
			if (list[index] != FlxKey.ESCAPE || list[index] != FlxGamepadInputID.BACK)
				return list[index];

			if (list.length > ControlsMenu.COLUMNS)
				// Escape isn't mappable, show a third option, instead.
				return list[ControlsMenu.COLUMNS];
		}

		return -1;
	}

	public function getLabel(input:Int)
	{
		return input == -1 ? "---" : InputFormatter.format(input, device);
	}
}
