package funkin.ui.menu;

enum NavControls
{
	Horizontal;
	Vertical;
	Both;
	Columns(num:Int);
	Rows(num:Int);
}

enum WrapMode
{
	Horizontal;
	Vertical;
	Both;
	None;
}