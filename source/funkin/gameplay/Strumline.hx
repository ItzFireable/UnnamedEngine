package funkin.gameplay;

import flixel.util.FlxSort;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.ui.FlxBar;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

class Strumline extends FlxSpriteGroup
{
	private var targetCamera:FlxCamera;

	public var notes:FlxTypedGroup<Note>;
	public var character:Character;

	public function new(y:Float, camera:FlxCamera)
	{
		super();
		targetCamera = camera;

		notes = new FlxTypedGroup<Note>();
		notes.cameras = [targetCamera];

		for (i in 0...4)
		{
			var babyArrow:FlxSprite = new FlxSprite(0, y);

			babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');

			babyArrow.animation.addByPrefix('green', 'arrowUP');
			babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
			babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
			babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

			babyArrow.antialiasing = true;
			babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

			switch (Math.abs(i))
			{
				case 0:
					babyArrow.x += Note.swagWidth * 0;
					babyArrow.animation.addByPrefix('static', 'arrow static left');
					babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
				case 1:
					babyArrow.x += Note.swagWidth * 1;
					babyArrow.animation.addByPrefix('static', 'arrow static down');
					babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 2:
					babyArrow.x += Note.swagWidth * 2;
					babyArrow.animation.addByPrefix('static', 'arrow static up');
					babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 3:
					babyArrow.x += Note.swagWidth * 3;
					babyArrow.animation.addByPrefix('static', 'arrow static right');
					babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
					babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			babyArrow.y -= 10;
			babyArrow.alpha = 0;
			FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});

			babyArrow.ID = i;

			babyArrow.animation.play('static');
			this.add(babyArrow);
		}

		for (object in this)
			object.cameras = [targetCamera];
	}

	public function addNote(newNote:Note)
	{
		notes.add(newNote);
		notes.sort(Utils.sortNotes, FlxSort.DESCENDING);
	}

	public function killNote(note:Note)
	{
		note.active = false;
		note.visible = false;

		notes.remove(note, true);

		note.kill();
		note.destroy();
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		var strumOffset = (this.width / 4);

		notes.forEach(function(note:Note)
		{
			note.x = this.x + (strumOffset * note.strum);
			if (note.isSustainNote)
				note.x += (strumOffset / 2) - (note.width / 2);
		});

		if ((ID == PlayState.currentStrumline && !Inputs.keys.contains(true)) || ID != PlayState.currentStrumline)
			if (character.holdTimer > Conductor.stepCrochet * 4 * 0.001)
				if (character.animation.curAnim.name.startsWith('sing') && !character.animation.curAnim.name.endsWith('miss'))
					character.playAnim('idle');
	}
}
