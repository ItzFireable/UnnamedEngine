package funkin.framerate;

class SystemInfo extends FramerateCategory
{
	public static var osInfo:String = "Unknown";
	public static var gpuName:String = "Unknown";
	public static var vRAM:String = "Unknown";
	public static var cpuName:String = "Unknown";
	public static var totalMem:String = "Unknown";
	public static var memType:String = "Unknown";

	static var __formattedSysText:String = "";

	public static inline function init()
	{
		if (lime.system.System.platformLabel != null
			&& lime.system.System.platformLabel != ""
			&& lime.system.System.platformVersion != null
			&& lime.system.System.platformVersion != "")
			osInfo = '${lime.system.System.platformLabel.replace(lime.system.System.platformVersion, "").trim()} ${lime.system.System.platformVersion}';
		else
			trace('Unable to grab OS Label');

		try
		{
			#if windows
			var process = new HiddenProcess("wmic", ["cpu", "get", "name"]);
			if (process.exitCode() == 0)
				cpuName = process.stdout.readAll().toString().trim().split("\n")[1].trim();
			#elseif mac
			var process = new HiddenProcess("sysctl -a | grep brand_string");
			if (process.exitCode() == 0)
				cpuName = process.stdout.readAll().toString().trim().split(":")[1].trim();
			#elseif linux
			var process = new HiddenProcess("cat", ["/proc/cpuinfo"]);
			if (process.exitCode() != 0)
				throw 'Could not fetch CPU information';

			for (line in process.stdout.readAll().toString().split("\n"))
			{
				if (line.indexOf("model name") == 0)
				{
					cpuName = line.substring(line.indexOf(":") + 2);
					break;
				}
			}
			#end
		}
		catch (e)
		{
			trace('Unable to grab CPU Name: $e');
		}

		@:privateAccess {
			if (flixel.FlxG.stage.context3D != null && flixel.FlxG.stage.context3D.gl != null)
			{
				gpuName = Std.string(flixel.FlxG.stage.context3D.gl.getParameter(flixel.FlxG.stage.context3D.gl.RENDERER)).split("/")[0].trim();

				var vRAMBytes:UInt = cast(flixel.FlxG.stage.context3D.gl.getParameter(openfl.display3D.Context3D.__glMemoryTotalAvailable), UInt);

				// This needs to be delayed somehow, vRAMBytes fucks itself if it goes too fast on Linux (maybe even other OSes, can't confirm).
				// Trace works but is not preferred. Need to find an alternative.

				// Also, Linux returns VRAM incorrectly. Might be OpenFL, who knows. Need to check this again later.
				#if linux
				trace("VRAM: " + Utils.getSizeString(vRAMBytes * 1000));
				#end

				if (vRAMBytes == 1000 || vRAMBytes <= 0)
				{
					trace('Unable to grab GPU VRAM');
					vRAM = "Unknown";
				}
				else
				{
					vRAM = Utils.getSizeString(vRAMBytes * 1000);
				}
			}
			else
				trace('Unable to grab GPU Info');
		}

		#if cpp
		// Rounding to 2 decimals, looks a lot nicer
		totalMem = Std.string(Math.round((MemoryUtil.getTotalMem() / 1024) * 100) / 100) + " GB";
		#else
		trace('Unable to grab RAM Amount');
		#end

		try
		{
			memType = MemoryUtil.getMemType();
		}
		catch (e)
		{
			trace('Unable to grab RAM Type: $e');
		}
		formatSysInfo();
	}

	static function formatSysInfo()
	{
		if (osInfo != "Unknowvn")
			__formattedSysText = 'System: $osInfo';
		if (cpuName != "Unknown")
			__formattedSysText += '\nCPU: ${cpuName} ${openfl.system.Capabilities.cpuArchitecture} ${(openfl.system.Capabilities.supports64BitProcesses ? '64-Bit' : '32-Bit')}';
		if (gpuName != cpuName && (gpuName != "Unknown" && vRAM != "Unknown"))
			__formattedSysText += '\nGPU: ${gpuName} | VRAM: ${vRAM}'; // 1000 bytes of vram (apus)

		// Don't show memory type if it is unknown (probably should just show unknown? idk tho)
		if (totalMem != "Unknown" /*&& memType != "Unknown"*/)
			__formattedSysText += '\nTotal MEM: ${totalMem} ${memType != "Unknown" ? memType : ""}';
	}

	public function new()
	{
		super("System Info");
	}

	public override function __enterFrame(t:Int)
	{
		if (alpha <= 0.05)
			return;

		_text = __formattedSysText;
		_text += '${__formattedSysText == "" ? "" : "\n"}Garbage Collector: ${MemoryUtil.disableCount > 0 ? "OFF" : "ON"} (${MemoryUtil.disableCount})';

		this.text.text = _text;
		super.__enterFrame(t);
	}
}
