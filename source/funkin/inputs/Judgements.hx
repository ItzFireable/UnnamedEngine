package funkin.inputs;

class Judgements {
    public static var judgementData:Array<Dynamic> = [
        {
            name: 'Sick',
            score: 350,
            accuracy: 1,
            hitbox: 45,
        },
        {
            name: 'Good',
            score: 350,
            accuracy: 1,
            hitbox: 90,
        },
        {
            name: 'Bad',
            score: 350,
            accuracy: 1,
            hitbox: 135,
        },
        {
            name: 'Shit',
            score: 350,
            accuracy: 1,
            hitbox: 180,
        },
        {
            name: 'Miss',
            score: 350,
            accuracy: 1,
            hitbox: 210,
        },
    ];

    public static function getJudgement(ms:Float)
    {
        var curJudgement = judgementData[judgementData.length - 1];
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