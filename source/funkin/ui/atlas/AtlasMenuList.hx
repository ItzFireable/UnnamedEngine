package funkin.ui.atlas;
import flixel.graphics.frames.FlxAtlasFrames;

class AtlasMenuList extends MenuTypedList<AtlasMenuItem>
{
	public var atlas:FlxAtlasFrames;

	public function new(atlas, navControls:NavControls = Vertical, ?wrapMode)
	{
		super(navControls, wrapMode);

		if (Std.is(atlas, String))
			this.atlas = Paths.getSparrowAtlas(cast atlas);
		else
			this.atlas = cast atlas;
	}

	public function createItem(x = 0.0, y = 0.0, name, callback, fireInstantly = false)
	{
		var item = new AtlasMenuItem(x, y, name, atlas, callback);
		item.fireInstantly = fireInstantly;
		return addItem(name, item);
	}

	override function destroy()
	{
		super.destroy();
		atlas = null;
	}
}