package funkin.ui.text;

class TextTypedMenuItem<T:AtlasText> extends MenuTypedItem<T>
{
	public function new(x = 0.0, y = 0.0, label:T, name:String, callback)
	{
		super(x, y, label, name, callback);
	}

	override function setItem(name:String, ?callback:Void->Void)
	{
		if (label != null)
		{
			label.text = name;
			label.alpha = alpha;
			width = label.width;
			height = label.height;
		}

		super.setItem(name, callback);
	}

	override function set_label(value:T):T
	{
		super.set_label(value);
		setItem(name, callback);
		return value;
	}
}
