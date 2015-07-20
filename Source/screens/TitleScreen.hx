package screens;
import fwork.Screen;
import fwork.ScreenManager;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Nickan
 */
class TitleScreen extends Screen
{
	var _pressSpace :Bitmap;

	public function new() 
	{
		super();
		GameData.getInstance().reset();
	}
	
	override public function onAdded():Void 
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		
		setupBackground();
		setupPressSpaceToContinue();
	}
	
	function setupBackground() 
	{
		var bg = new Bitmap(Assets.getBitmapData("assets/title.png"));
		addChild(bg);
		bg.x = stage.stageWidth * 0.5 - bg.width * 0.5;
		bg.y = stage.stageHeight * 0.2;
	}
	
	function setupPressSpaceToContinue() 
	{
		_pressSpace = new Bitmap(Assets.getBitmapData("assets/info1.png"));
		addChild(_pressSpace);
		_pressSpace.x = stage.stageWidth * 0.5 - _pressSpace.width * 0.5;
		_pressSpace.y = stage.stageHeight * 0.75;
		
		onTransparent();
	}
	
	// ================================================ Control Event ================================================== // 
	private function onKeyboardDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.SPACE) {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			ScreenManager.getInstance().showOnScreen(new GameScreen(GameData.getInstance().level));
		}
	}
	
	
	function onOpaque()
	{
		Actuate.tween(_pressSpace, 0.3, { alpha :1 }, false).onComplete(onTransparent);
	}
	
	function onTransparent() 
	{
		Actuate.tween(_pressSpace, 0.3, { alpha :0 }, false).onComplete(onOpaque);
	}
	
}