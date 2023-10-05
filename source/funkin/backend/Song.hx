package funkin.backend;

import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

class Song
{
	public var song:String;
	public var notes:Array<SectionData>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}
}
