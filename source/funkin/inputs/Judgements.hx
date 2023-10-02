package funkin.inputs;

import flixel.math.FlxMath;

using extensions.ArrayExtensions;

class Judgements {
    public static var FCLabel:String = "";
    public static var ScoreRating:String = "";

    public static var judgementData = [
        {
            name: 'Sick',
            score: 350,
            accuracy: 1,
            hitbox: 45,
            labels: ['SFC','SDS']
        },
        {
            name: 'Good',
            score: 350,
            accuracy: 1,
            hitbox: 90,
            labels: ['GFC','SDG']
        },
        {
            name: 'Bad',
            score: 350,
            accuracy: 1,
            hitbox: 135,
            labels: ['BFC','SDB']
        },
        {
            name: 'Shit',
            score: 350,
            accuracy: 1,
            hitbox: 180,
            labels: ['FC']
        },
        {
            name: 'Miss',
            score: 350,
            accuracy: 1,
            hitbox: 210,
            labels: ['SDCB']
        },
    ];

    public static var scoreRating:Map<String, Int> = [
        "S+" => 100,
        "S" => 95,
        "A" => 90,
        "B" => 85,
        "C" => 80,
        "D" => 75,
        "E" => 70,
        "F" => 65,
    ];

    public static var fcLabels:Map<String, Array<Int>> = [
        // FC with different stats
        "SFC" => [0,0,0,0],
        "GFC" => [0,0,0],
        "BFC" => [0,0],
        "FC" => [0],

        "SDS" => [9,0,0,0,0],
        "SDG" => [9,0,0,0],
        "SDB" => [9,0,0],
        "SDCB" => [9]
    ];

    public static function updateFCDisplay()
    {
        var judgementCount = Lambda.count(PlayState.judgements);
        var foundJudgement = false;

        for (judgement in judgementData)
        {
            for (label in judgement.labels)
            {
                var values = fcLabels.get(label);
                var isJudgement = true;

                var offset:Int = Std.int(Math.abs(values.length - judgementCount));
                var i:Int = 0;

                for (value in values)
                {
                    var judgementStat = PlayState.judgements.get(judgementData[i+offset].name);
                    if (judgementStat > value)
                        isJudgement = false;

                    i++;
                }

                if (isJudgement)
                {
                    FCLabel = label;
                    foundJudgement = true;

                    return;
                }
            }
        }

        if (!foundJudgement)
            FCLabel = 'CLEAR';
    }

    public static function updateScoreRating()
    {
        var biggest:Int = 0;
        var accuracy:Float = FlxMath.roundDecimal(PlayState.accuracy * 100, 2);

		for (score in scoreRating.keys())
		{
            var val:Int = scoreRating.get(score);
			if (val >= biggest && val <= accuracy)
			{
				biggest = val;
				ScoreRating = score;
			}
		}
    }

    public static function getJudgement(ms:Float)
    {
        var curJudgement = judgementData.last();
        for (judgement in judgementData)
        {
            if (ms <= judgement.hitbox)
            {
                curJudgement = judgement;
                break;
            }
        }

        return curJudgement;
    }
}