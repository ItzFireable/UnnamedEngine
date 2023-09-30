// From: Codename Engine
package misc;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;

class GraphicCacheSprite extends FlxSprite
{
	public var cachedGraphics:Array<FlxGraphic> = [];
	public var nonRenderedCachedGraphics:Array<FlxGraphic> = [];

	public override function new()
	{
		super();
		alpha = 0.00001;
	}

	public function cache(path:String)
	{
		var graphic = FlxG.bitmap.add(path);
		if (graphic != null)
		{
			graphic.useCount++;
			graphic.destroyOnNoUse = false;

			cachedGraphics.push(graphic);
			nonRenderedCachedGraphics.push(graphic);
		}
	}

	public override function destroy()
	{
		for (g in cachedGraphics)
		{
			g.destroyOnNoUse = true;
			g.useCount--;
		}
		graphic = null;
		super.destroy();
	}

	public override function draw()
	{
		while (nonRenderedCachedGraphics.length > 0)
		{
			loadGraphic(nonRenderedCachedGraphics.shift());
			drawComplex(FlxG.camera);
		}
	}
}
