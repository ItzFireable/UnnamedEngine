package funkin.ui.text;

class TextMenuList extends MenuTypedList<TextMenuItem>
{
	public function new(navControls:NavControls = Vertical, ?wrapMode)
	{
		super(navControls, wrapMode);
	}

	public function createItem(x = 0.0, y = 0.0, name:String, font:AtlasFont = Bold, callback, fireInstantly = false)
	{
		var item = new TextMenuItem(x, y, name, font, callback);
		item.fireInstantly = fireInstantly;
		return addItem(name, item);
	}
}