package funkin.ui.text;

class TextMenuItem extends TextTypedMenuItem<AtlasText>
{
	public function new(x = 0.0, y = 0.0, name:String, font:AtlasFont = Bold, callback)
	{
		super(x, y, new AtlasText(0, 0, name, font), name, callback);
		setEmptyBackground();
	}
}
