package funkin.hud;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.ui.FlxBar;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

class BaseHUD extends FlxSpriteGroup
{
	private var font:String = 'VCR';

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;

	private var scoreTxt:FlxText;

	private var SONG:SongData;
	private var targetCamera:FlxCamera;

	override function add(object:FlxSprite):FlxSprite
	{
		this.preAdd(object);
		object.cameras = [targetCamera];
		return this.group.add(object);
	}

	public function new(camera:FlxCamera)
	{
		super();

		targetCamera = camera;
		SONG = PlayState.SONG;

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8),
			PlayState, 'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);

		iconP1 = new HealthIcon(PlayState.characters.get('boyfriend').curIcon, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);

		iconP2 = new HealthIcon(PlayState.characters.get('dad').curIcon, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);

		scoreTxt = new FlxText(healthBarBG.x + healthBarBG.width - 190, healthBarBG.y + 30, 0, "", 20);
		scoreTxt.setFormat(Paths.font(font + ".ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		scoreTxt.screenCenter(X);
		scoreTxt.scrollFactor.set();

		this.noteHit();

		this.add(healthBarBG);
		this.add(healthBar);

		this.add(iconP1);
		this.add(iconP2);

		this.add(scoreTxt);
	}

	public function update_settings()
	{
		if (PreferencesMenu.getPref('downscroll'))
			healthBarBG.y = FlxG.height * 0.1;
		else
			healthBarBG.y = FlxG.height * 0.9;

		healthBar.x = healthBarBG.x + 4;
		healthBar.y = healthBarBG.y + 4;

		iconP1.y = healthBar.y - (iconP1.height / 2);
		iconP2.y = healthBar.y - (iconP2.height / 2);

		scoreTxt.y = healthBarBG.y + 30;
	}

	public function noteHit()
	{
		scoreTxt.text = 'Score: ' + PlayState.score;
	}

	public function onStart() {}

	public function beatHit(beat)
	{
		iconP1.scale.set(1.15, 1.15);
		iconP2.scale.set(1.15, 1.15);

		iconP1.updateHitbox();
		iconP2.updateHitbox();
	}

	public function stepHit(step) {}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var scale = FlxMath.lerp(1, iconP1.scale.x, FlxMath.bound(1 - (elapsed * 9), 0, 1));
		iconP1.scale.set(scale, scale);
		iconP1.updateHitbox();

		var scale = FlxMath.lerp(1, iconP2.scale.x, FlxMath.bound(1 - (elapsed * 9), 0, 1));
		iconP2.scale.set(scale, scale);
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;
	}
}
