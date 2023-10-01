package funkin.hud;

import flixel.FlxCamera;

class ForeverHUD extends BaseHUD {
    override public function noteHit()
    {
        scoreTxt.text = "Score: " + PlayState.songScore + " - Accuracy: {accuracy} [{rating}] - Combo Breaks: {combobreaks} - Rank: {ranking}";
    }
}