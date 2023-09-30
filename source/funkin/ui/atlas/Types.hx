package funkin.ui.atlas;

enum Case
{
	Both;
	Upper;
	Lower;
}

enum AtlasFont
{
	Default;
	Bold;
}

@:forward
abstract BoldText(AtlasText) from AtlasText to AtlasText
{
	inline public function new(x = 0.0, y = 0.0, text:String)
	{
		this = new AtlasText(x, y, text, Bold);
	}
}