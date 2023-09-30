package funkin.framerate;

import flixel.FlxG;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.text.TextField;

class FramerateCounter extends Sprite
{
	public var fpsNum:TextField;
	public var fpsLabel:TextField;
	public var lastFPS:Float = 0;

	public function new()
	{
		super();

		fpsNum = new TextField();
		fpsLabel = new TextField();

		for (label in [fpsNum, fpsLabel])
		{
			label.autoSize = LEFT;
			label.x = 0;
			label.y = 0;
			label.text = "FPS";
			label.multiline = label.wordWrap = false;
			label.defaultTextFormat = new TextFormat(Framerate.textFormat.font, label == fpsNum ? 18 : 13, -1);
			addChild(label);
		}
	}

	public override function __enterFrame(t:Int)
	{
		if (alpha <= 0.05)
			return;
		super.__enterFrame(t);

		lastFPS = Utils.fpsLerp(lastFPS, FlxG.elapsed == 0 ? 0 : (1 / FlxG.elapsed), 0.25);
		fpsNum.text = Std.string(Math.floor(lastFPS));

		fpsLabel.x = fpsNum.x + fpsNum.width;
		fpsLabel.y = (fpsNum.y + fpsNum.height) - fpsLabel.height;
	}
}
