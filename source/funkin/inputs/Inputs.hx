package funkin.inputs;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;

class Inputs {
    static var controlList = Control.createAll();
    static var cachedBinds = null;
    public static var keys:Array<Bool> = [false,false,false,false];

    private static function getBinds():Array<Array<String>>
    {
        var binds:Array<Array<String>> = [];

        var c = -1;
        var prevControl = "";

        for (i in 0...controlList.length)
        {
            var control = controlList[i];
            var name = control.getName();

            if (name.indexOf("NOTE_") == 0)
            {
                if (prevControl != name)
                {
                    prevControl = name;
                    
                    c++;
                    binds[c] = [];
                }

                for (index in 0...2)
                {
                    var list = PlayerSettings.player1.controls.getInputsFor(control, Keys);
                    var bind:Int = -1;

                    if (list.length > index)
                    {
                        if (list[index] != FlxKey.ENTER || list[index] != FlxKey.ESCAPE || list[index] != FlxGamepadInputID.BACK)
                            bind = list[index];
                    }

                    if (bind > -1)
                        binds[c].push(InputFormatter.format(bind, Keys));
                }
            }
        }

        return binds;
    }

    private static function getKeycode(keycode)
    {
        @:privateAccess
		return FlxKey.toStringMap.get(keycode);
    }

    public static function handleInput(event:KeyboardEvent) {
        if (PlayState.paused) return;
        var key = getKeycode(event.keyCode);
        var binds:Array<Array<String>> = getBinds();

        var press = -1;

        for (i in 0...binds.length)
            for (o in 0...binds[i].length)
                if (binds[i][o].toLowerCase() == key.toLowerCase())
                    press = i;

        if (press == -1)
            return; // Not part of keybinds

        if (keys[press] == true)
            return; // Already holding key

        keys[press] = true; 
        var closest:Note = null;

        PlayState.strumlines.members[PlayState.currentStrumline].notes.forEach(function(note:Note) {
            if (note.canBeHit && !note.wasHit && note.noteData == press && !note.isSustainNote)
                closest = note;
        });

        if (closest == null)
            return; // No valid notes for hitting

        PlayState.instance.goodNoteHit(closest);
    };

    public static function releaseInput(event:KeyboardEvent) {
        if (PlayState.paused) return;
        var key = getKeycode(event.keyCode);

        var binds:Array<Array<String>> = getBinds();

        var press = -1;

        for (i in 0...binds.length)
            for (o in 0...binds[i].length)
                if (binds[i][o].toLowerCase() == key.toLowerCase())
                    press = i;

        if (press == -1)
            return; // Not part of keybinds

        keys[press] = false; 
    };
}