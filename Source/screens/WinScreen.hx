package screens;
import fwork.Screen;
import fwork.ScreenManager;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Nickan
 */
class WinScreen extends Screen
{

	public function new() 
	{
		super();
	}
	
	override public function onAdded()
	{
		super.onAdded();
		setupBackground();
		setupControls();
	}

	function setupBackground() 
	{
		var bg = new Bitmap(Assets.getBitmapData("assets/youwin.png"));
		bg.x = stage.stageWidth * 0.5 - bg.width * 0.5;
		bg.y = stage.stageHeight * 0.5 - bg.height * 0.5;
		addChild(bg);
	}
	
	function setupControls() 
	{
		stage.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		stage.removeEventListener(MouseEvent.CLICK, onClick);
		ScreenManager.getInstance().showOnScreen(new TitleScreen());
	}
	
}