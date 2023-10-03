package funkin.ui.atlas;

import flixel.graphics.frames.FlxAtlasFrames;

class AtlasMenuItem extends MenuItem
{
	var atlas:FlxAtlasFrames;

	public function new(x = 0.0, y = 0.0, name:String, atlas:FlxAtlasFrames, callback)
	{
		this.atlas = atlas;
		super(x, y, name, callback);
	}

	override function setData(name:String, ?callback:Void->Void)
	{
		frames = atlas;
		animation.addByPrefix('idle', '$name idle', 24);
		animation.addByPrefix('selected', '$name selected', 24);

		super.setData(name, callback);
	}

	function changeAnim(animName:String)
	{
		animation.play(animName);
		updateHitbox();
	}

	override function idle()
	{
		changeAnim('idle');
	}

	override function select()
	{
		changeAnim('selected');
	}

	override function get_selected()
	{
		return animation.curAnim != null && animation.curAnim.name == "selected";
	}

	override function destroy()
	{
		super.destroy();
		atlas = null;
	}
}
