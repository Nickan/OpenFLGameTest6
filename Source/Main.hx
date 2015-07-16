package;


import fwork.ScreenManager;
import openfl.display.Sprite;
import screens.TitleScreen;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		addChild(ScreenManager.getInstance());
		ScreenManager.getInstance().showOnScreen(new TitleScreen());
	}
	
	
}