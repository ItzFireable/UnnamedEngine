package funkin.gameplay;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

class Note extends FlxSprite
{
	public var strum:Int = 0;
	public var strumline:Int = 0;
	public var strumTime:Float = 0;

	public var prevNote:Note;
	public var noteData:Int = 0;

	public var wasHit:Bool = false;
	public var tooLate:Bool = false;
	public var canBeHit:Bool = false;

	public var noteType:String = "";
	public var hitHealth:Float = 0.025;
	public var missHealth:Float = 0.05;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public static var swagWidth:Float = 112;

	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public static var arrowColors:Array<Float> = [1, 1, 1, 1];

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		scrollFactor.set(0, 0);

		y -= 2000;

		this.strumTime = strumTime;
		this.noteData = noteData;

		frames = Paths.getSparrowAtlas('NOTE_assets');

		animation.addByPrefix('greenScroll', 'green note');
		animation.addByPrefix('redScroll', 'red note');
		animation.addByPrefix('blueScroll', 'blue note');
		animation.addByPrefix('purpleScroll', 'purple note');

		animation.addByPrefix('purpleholdend', 'purple hold end');
		animation.addByPrefix('greenholdend', 'green hold end');
		animation.addByPrefix('redholdend', 'red hold end');
		animation.addByPrefix('blueholdend', 'blue hold end');

		animation.addByPrefix('purplehold', 'purple hold piece');
		animation.addByPrefix('greenhold', 'green hold piece');
		animation.addByPrefix('redhold', 'red hold piece');
		animation.addByPrefix('bluehold', 'blue hold piece');

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		antialiasing = true;

		switch (noteData)
		{
			case 0:
				animation.play('purpleScroll');
			case 1:
				animation.play('blueScroll');
			case 2:
				animation.play('greenScroll');
			case 3:
				animation.play('redScroll');
		}

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;

			if (PreferencesMenu.getPref('downscroll'))
				angle = 180;

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
