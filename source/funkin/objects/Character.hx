package funkin.objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxDirectionFlags;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxSort;
import haxe.io.Path;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var initFacing:Int = FlxDirectionFlags.RIGHT;
	public var initWidth:Float;

	public var isPlayer:Bool = false;
	public var isGirlfriend:Bool = false;

	public var curIcon:String = 'face';
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	public var animationNotes:Array<Dynamic> = [];

	public var camOffset:Float = 16;
	public var bopSpeed:Int = 2;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);
		var tex:FlxAtlasFrames;

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		antialiasing = true;

		this.isPlayer = isPlayer;

		/*switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, true);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24, true);

				loadOffsetFile(curCharacter);
				bopSpeed = 1;

				playAnim('danceRight');
			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24, true);

				loadOffsetFile(curCharacter);
				bopSpeed = 1;

				playAnim('danceRight');
			case 'gf-tankmen':
				frames = Paths.getSparrowAtlas('characters/gfTankmen');
				animation.addByIndices('sad', 'GF Crying at Gunpoint', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, true);
				animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile('gf');
				bopSpeed = 1;

				playAnim('danceRight');
			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('idleHair', 'GF Dancing Beat Hair blowing CAR', [10, 11, 12, 25, 26, 27], "", 24, true);

				loadOffsetFile(curCharacter);
				bopSpeed = 1;

				playAnim('danceRight');
			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile(curCharacter);
				bopSpeed = 1;

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;
			case 'pico-speaker':
				frames = Paths.getSparrowAtlas('characters/picoSpeaker');

				quickAnimAdd('idle', "Pico idle", true);

				quickAnimAdd('singLEFT', "Pico shoot 4");
				quickAnimAdd('singDOWN', "Pico shoot 3");
				quickAnimAdd('singUP', "Pico shoot 2");
				quickAnimAdd('singRIGHT', "Pico shoot 1");

				// here for now, will be replaced later for less copypaste
				loadOffsetFile(curCharacter);
				bopSpeed = 1;

				playAnim('idle');

				loadMappedAnims();
			// Opponents
			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
				frames = tex;
				quickAnimAdd('idle', 'Dad idle dance');
				quickAnimAdd('singUP', 'Dad Sing Note UP');
				quickAnimAdd('singRIGHT', 'Dad Sing Note RIGHT');
				quickAnimAdd('singDOWN', 'Dad Sing Note DOWN');
				quickAnimAdd('singLEFT', 'Dad Sing Note LEFT');

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				quickAnimAdd('singUP', 'spooky UP NOTE');
				quickAnimAdd('singDOWN', 'spooky DOWN note');
				quickAnimAdd('singLEFT', 'note sing left');
				quickAnimAdd('singRIGHT', 'spooky sing right');
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				loadOffsetFile(curCharacter);
				bopSpeed = 1;

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');
				animation.addByIndices('idleHair', "Mom Idle", [10, 11, 12, 13], "", 24, true);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				quickAnimAdd('idle', "Pico Idle Dance");
				quickAnimAdd('singUP', 'pico Up note0');
				quickAnimAdd('singDOWN', 'Pico Down Note0');
				if (isPlayer)
				{
					quickAnimAdd('singLEFT', 'Pico NOTE LEFT0');
					quickAnimAdd('singRIGHT', 'Pico Note Right0');
					quickAnimAdd('singRIGHTmiss', 'Pico Note Right Miss');
					quickAnimAdd('singLEFTmiss', 'Pico NOTE LEFT miss');
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					quickAnimAdd('singLEFT', 'Pico Note Right0');
					quickAnimAdd('singRIGHT', 'Pico NOTE LEFT0');
					quickAnimAdd('singRIGHTmiss', 'Pico NOTE LEFT miss');
					quickAnimAdd('singLEFTmiss', 'Pico Note Right Miss');
				}

				quickAnimAdd('singUPmiss', 'pico Up note miss');
				quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS');

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				quickAnimAdd('idle', 'Senpai Idle');

				quickAnimAdd('singUP', 'SENPAI UP NOTE');
				quickAnimAdd('singLEFT', 'SENPAI LEFT NOTE');
				quickAnimAdd('singRIGHT', 'SENPAI RIGHT NOTE');
				quickAnimAdd('singDOWN', 'SENPAI DOWN NOTE');

				loadOffsetFile(curCharacter);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				quickAnimAdd('idle', 'Angry Senpai Idle');
				quickAnimAdd('singUP', 'Angry Senpai UP NOTE');
				quickAnimAdd('singLEFT', 'Angry Senpai LEFT NOTE');
				quickAnimAdd('singRIGHT', 'Angry Senpai RIGHT NOTE');
				quickAnimAdd('singDOWN', 'Angry Senpai DOWN NOTE');

				loadOffsetFile(curCharacter);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				quickAnimAdd('idle', "idle spirit_");
				quickAnimAdd('singUP', "up_");
				quickAnimAdd('singRIGHT', "right_");
				quickAnimAdd('singLEFT', "left_");
				quickAnimAdd('singDOWN', "spirit down_");

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				quickAnimAdd('idle', 'Parent Christmas Idle');
				quickAnimAdd('singUP', 'Parent Up Note Dad');
				quickAnimAdd('singDOWN', 'Parent Down Note Dad');
				quickAnimAdd('singLEFT', 'Parent Left Note Dad');
				quickAnimAdd('singRIGHT', 'Parent Right Note Dad');

				quickAnimAdd('singUP-alt', 'Parent Up Note Mom');

				quickAnimAdd('singDOWN-alt', 'Parent Down Note Mom');
				quickAnimAdd('singLEFT-alt', 'Parent Left Note Mom');
				quickAnimAdd('singRIGHT-alt', 'Parent Right Note Mom');

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'tankman':
				frames = Paths.getSparrowAtlas('characters/tankmanCaptain');

				quickAnimAdd('idle', "Tankman Idle Dance");

				if (isPlayer)
				{
					quickAnimAdd('singLEFT', 'Tankman Note Left ');
					quickAnimAdd('singRIGHT', 'Tankman Right Note ');
					quickAnimAdd('singLEFTmiss', 'Tankman Note Left MISS');
					quickAnimAdd('singRIGHTmiss', 'Tankman Right Note MISS');
				}
				else
				{
					quickAnimAdd('singLEFT', 'Tankman Right Note ');
					quickAnimAdd('singRIGHT', 'Tankman Note Left ');
					quickAnimAdd('singLEFTmiss', 'Tankman Right Note MISS');
					quickAnimAdd('singRIGHTmiss', 'Tankman Note Left MISS');
				}

				quickAnimAdd('singUP', 'Tankman UP note ');
				quickAnimAdd('singDOWN', 'Tankman DOWN note ');
				quickAnimAdd('singUPmiss', 'Tankman UP note MISS');
				quickAnimAdd('singDOWNmiss', 'Tankman DOWN note MISS');
				quickAnimAdd('singDOWN-alt', 'PRETTY GOOD');
				quickAnimAdd('singUP-alt', 'TANKMAN UGH');

				loadOffsetFile(curCharacter);
				playAnim('idle');

				flipX = true;
			// Player characters
			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				animation.addByIndices('idleHair', 'BF idle dance', [10, 11, 12, 13], "", 24, true);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				quickAnimAdd('idle', 'BF IDLE');
				quickAnimAdd('singUP', 'BF UP NOTE');
				quickAnimAdd('singLEFT', 'BF LEFT NOTE');
				quickAnimAdd('singRIGHT', 'BF RIGHT NOTE');
				quickAnimAdd('singDOWN', 'BF DOWN NOTE');
				quickAnimAdd('singUPmiss', 'BF UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF DOWN MISS');

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				quickAnimAdd('singUP', "BF Dies pixel");
				quickAnimAdd('firstDeath', "BF Dies pixel");
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				quickAnimAdd('deathConfirm', "RETRY CONFIRM");
				animation.play('firstDeath');

				loadOffsetFile(curCharacter);

				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;
			case 'bf-holding-gf':
				frames = Paths.getSparrowAtlas('characters/bfAndGF');
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singUP', 'BF NOTE UP0');

				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('bfCatch', 'BF catches GF');

				loadOffsetFile(curCharacter);

				playAnim('idle');
				flipX = true;
			case 'bf-holding-gf-dead':
				frames = Paths.getSparrowAtlas('characters/bfHoldingGF-DEAD');
				quickAnimAdd('singUP', 'BF Dead with GF Loop');
				quickAnimAdd('firstDeath', 'BF Dies with GF');
				animation.addByPrefix('deathLoop', 'BF Dead with GF Loop', 24, true);
				quickAnimAdd('deathConfirm', 'RETRY confirm holding gf');

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
				flipX = true;
			default:
				loadCharacter(curCharacter);
		}*/

		loadCharacter(curCharacter);

		dance();
		animation.finish();
	}
	public function loadCharacter(char:String)
	{
		var json = Utils.getCharacterData(char);
		if (json.texture == null) return;

		var tex = Paths.getSparrowAtlas('characters/' + json.texture);
		frames = tex;

		curIcon = json.icon;
		if (json.bopSpeed > 0)
			bopSpeed = json.bopSpeed;

		initFacing = json.facing == "left" ? FlxDirectionFlags.LEFT : FlxDirectionFlags.RIGHT;
		initWidth = frameWidth;

		setFacingFlip((initFacing == FlxDirectionFlags.LEFT ? FlxDirectionFlags.RIGHT : FlxDirectionFlags.LEFT), true, false);
		facing = (isPlayer ? FlxDirectionFlags.LEFT : FlxDirectionFlags.RIGHT);

		if (json.animations != null)
			for (anim in json.animations)
			{
				var prefix = anim[0];
				var name = anim[1];
				var offsetX = anim[2];
				var offsetY = anim[3];
				var fps = anim[4];
				var loop = anim[5];

				quickAnimAdd(prefix, name, fps != null ? Std.parseInt(fps) : 24, loop || false);
				addOffset(prefix, Std.parseInt(offsetX), Std.parseInt(offsetY));
			}

		if (json.indices != null)
			for (anim in json.indices)
			{
				var prefix = anim[0];
				var name = anim[1];
				var indices = anim[2];

				var offsetX = anim[3];
				var offsetY = anim[4];
				var fps = anim[5];
				var loop = anim[6];

				quickIndiceAdd(prefix, name, indices, fps != null ? Std.parseInt(fps) : 24, loop || false);
				addOffset(prefix, Std.parseInt(offsetX), Std.parseInt(offsetY));
			}

		// Thanks Myth team <3
		if (facing != initFacing)
		{
			if (animation.getByName('singRIGHT') != null)
			{
				var oldRight = animation.getByName('singRIGHT').frames;
				var oldOffset = animOffsets['singRIGHT'];
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animOffsets['singRIGHT'] = animOffsets['singLEFT'];
				animation.getByName('singLEFT').frames = oldRight;
				animOffsets['singLEFT'] = oldOffset;
			}

			if (animation.getByName('singRIGHTmiss') != null)
			{
				var oldMiss = animation.getByName('singRIGHTmiss').frames;
				var oldOffset = animOffsets['singRIGHTmiss'];
				animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
				animOffsets['singRIGHTmiss'] = animOffsets['singLEFTmiss'];
				animation.getByName('singLEFTmiss').frames = oldMiss;
				animOffsets['singLEFTmiss'] = oldOffset;
			}

			if (animation.getByName('singRIGHT-alt') != null)
			{
				var oldRight = animation.getByName('singRIGHT-alt').frames;
				var oldOffset = animOffsets['singRIGHT-alt'];
				animation.getByName('singRIGHT-alt').frames = animation.getByName('singLEFT-alt').frames;
				animOffsets['singRIGHT-alt'] = animOffsets['singLEFT-alt'];
				animation.getByName('singLEFT-alt').frames = oldRight;
				animOffsets['singLEFT-alt'] = oldOffset;
			}
		}

		playAnim(json.defaultAnim != null ? json.defaultAnim : 'idle');

		if (json.additionalChart != null)
			loadMappedAnims(json.additionalChart);
	}

	public function loadMappedAnims(chart)
	{
		var chart = Utils.getSongData(chart, PlayState.SONG.song.toLowerCase());
		var notes = chart.notes;

		for (section in notes)
			for (idk in section.sectionNotes)
				animationNotes.push(idk);

		animationNotes.sort(sortAnims);
	}

	function sortAnims(val1:Array<Dynamic>, val2:Array<Dynamic>):Int
		return FlxSort.byValues(FlxSort.ASCENDING, val1[0], val2[0]);

	function quickAnimAdd(name:String, prefix:String, ?fps:Int = 24, ?looped:Bool = false)
		animation.addByPrefix(name, prefix, fps, looped);

	function quickIndiceAdd(name:String, prefix:String, indices:Array<Int>, ?fps:Int = 24, ?looped:Bool = false)
		animation.addByIndices(name, prefix, indices, "", fps, looped);

	private function loadOffsetFile(offsetCharacter:String)
	{
		var daFile:Array<String> = Utils.coolTextFile(Paths.file("images/characters/" + offsetCharacter + "Offsets.txt"));

		for (i in daFile)
		{
			var splitWords:Array<String> = i.split(" ");
			addOffset(splitWords[0], Std.parseInt(splitWords[1]), Std.parseInt(splitWords[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (animation.curAnim.name.startsWith('sing'))
			holdTimer += elapsed;

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (animation.getByName("danceLeft") != null && animation.getByName("danceRight") != null)
		{
			danced = !danced;

			if (danced)
				playAnim('danceRight');
			else
				playAnim('danceLeft');
		}
		else
		{
			playAnim('idle');
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
			offset.set((facing != initFacing ? -1 : 1) * daOffset[0] + (facing != initFacing ? frameWidth - initWidth : 0), daOffset[1]);
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
