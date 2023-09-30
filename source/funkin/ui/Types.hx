package funkin.ui;

enum ButtonStyle
{
	Ok;
	Yes_No;
	Custom(yes:String, no:Null<String>); // Todo: more than 2
	None;
}