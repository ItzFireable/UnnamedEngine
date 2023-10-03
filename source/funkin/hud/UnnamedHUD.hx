package funkin.hud;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxStringUtil;
import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.FlxCamera;

class UnnamedHUD extends BaseHUD
{
	private var timeBar:FlxBar;
	private var timeTxt:FlxText;
	private var songTitle:FlxText;

	private var judgementCounter:FlxText;

	override public function new(camera:FlxCamera)
	{
		super(camera);

		judgementCounter = new FlxText(4,0);
		judgementCounter.setFormat(Paths.font(font + ".ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		
		judgementCounter.screenCenter(Y);
		judgementCounter.scrollFactor.set();

		timeBar = new FlxBar(0, 0, LEFT_TO_RIGHT, FlxG.width, 16, PlayState, 'songPercent', 0, 1);
		timeBar.scrollFactor.set();
		timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
		timeBar.alpha = 0.5;

		timeTxt = new FlxText(8, 8 + timeBar.height, FlxG.width - 16, "", 16);
		timeTxt.setFormat(Paths.font(super.font + ".ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt.scrollFactor.set();
		timeTxt.alpha = 0;
		timeTxt.borderSize = 1;

		songTitle = new FlxText(8, 8 + timeBar.height, FlxG.width - 16, PlayState.SONG.song + " [" + Utils.difficultyString().toUpperCase() + "]", 16);
		songTitle.setFormat(Paths.font(super.font + ".ttf"), 18, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		super.add(timeBar);
		super.add(timeTxt);
		super.add(songTitle);
		super.add(judgementCounter);

		this.noteHit();
	}

	override public function update_settings()
	{
		super.update_settings();

		if (PreferencesMenu.getPref('downscroll'))
		{
			timeBar.y = FlxG.height - timeBar.height;
			timeTxt.y = timeTxt.y = timeBar.y - timeTxt.height - 4;
			songTitle.y = songTitle.y = timeBar.y - songTitle.height - 4;
		}
		else
		{
			timeBar.y = 0;
			timeTxt.y = 8 + timeBar.height;
			songTitle.y = 8 + timeBar.height;
		}
	}

	function generateRating()
	{
		Judgements.updateFCDisplay();
		Judgements.updateScoreRating();
	}

	override public function onStart() {
		timeBar.numDivisions = Math.ceil(PlayState.songLength / 1000) * 4;

		FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.backIn});
		FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.backIn});
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		timeTxt.text = FlxStringUtil.formatTime(PlayState.secondsTotal, false) + ' / ' + FlxStringUtil.formatTime(Math.floor((PlayState.songLength < 0 ? 0 : PlayState.songLength) / 1000), false);
	}

	override public function noteHit()
	{
		generateRating();
		scoreTxt.text = "Score: " + PlayState.score + " // Misses: " + PlayState.judgements.get("Miss") + " // Accuracy: " + FlxMath.roundDecimal(PlayState.accuracy, 2) + "% [" + Judgements.FCLabel
			+ "] // Rank: " + Judgements.ScoreRating + " // Combo: " + PlayState.combo;
		scoreTxt.screenCenter(X);

		if (judgementCounter != null)
		{
			judgementCounter.text = "";
			for (judgement in Judgements.judgementData)
				judgementCounter.text += judgement.name + ": " + PlayState.judgements.get(judgement.name) + "\n";
			
			var len = judgementCounter.text.length;
			judgementCounter.text = judgementCounter.text.substring(0,len-1);

			judgementCounter.screenCenter(Y);
		}
	}
}
