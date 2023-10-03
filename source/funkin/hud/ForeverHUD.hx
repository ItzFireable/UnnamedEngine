package funkin.hud;

import flixel.math.FlxMath;
import flixel.FlxCamera;

class ForeverHUD extends BaseHUD
{
	function generateRating()
	{
		Judgements.updateFCDisplay();
		Judgements.updateScoreRating();
	}

	override public function noteHit()
	{
		generateRating();
		scoreTxt.text = "Score: " + PlayState.score + " - Accuracy: " + FlxMath.roundDecimal(PlayState.accuracy * 100, 2) + "% [" + Judgements.FCLabel
			+ "] - Combo Breaks: " + PlayState.judgements.get("Miss") + " - Rank: " + Judgements.ScoreRating;
		scoreTxt.screenCenter(X);
	}
}
