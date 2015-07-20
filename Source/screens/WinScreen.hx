package screens;
import fwork.Screen;
import fwork.ScreenManager;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;

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
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
	}
	
	private function onKeydown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.SPACE) {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			ScreenManager.getInstance().showOnScreen(new TitleScreen());
		}
		
	}
	
}