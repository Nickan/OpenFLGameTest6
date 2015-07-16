package sprites;
import haxe.xml.Fast;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.ui.Keyboard;
import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

/**
 * ...
 * @author Nickan
 */
class Player extends Sprite
{	
	public var acceleration(default, null) :Point;
	
	var _aniSprite :AnimatedSprite;
	var _gravity :Float;
	var _horizontalSpeed :Float;
	var _verticalSpeed :Float;
	
	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		
		initializeVariables();
		setupSprite();
	}
	
	function initializeVariables() 
	{
		acceleration = new Point();
		_horizontalSpeed = stage.stageWidth * 0.2;
		
		_gravity = stage.stageHeight * 0.2;
	}
	
	function setupSprite() 
	{
		var xml = Xml.parse(Assets.getText("assets/dash.xml"));
		var fast = new Fast(xml.firstElement());
		
		var width :Int;
		var height :Int;
		for (sub in fast.nodes.SubTexture) {
			width = Std.parseInt(sub.att.frameWidth);
			height = Std.parseInt(sub.att.frameHeight);
		}
		
		//var width = cast(fast.node.SubTexture.att.frameWidth, Int);
		//var height = cast(fast.node.SubTexture.att.frameHeight, Int);
		var spriteSheet :Spritesheet = BitmapImporter.create(Assets.getBitmapData("assets/" + fast.att.imagePath), 3, 2, width, height);
		spriteSheet.addBehavior(new BehaviorData("run", [0, 1, 2, 3, 4, 5], true, 15));
		spriteSheet.addBehavior(new BehaviorData("stand", [3]));
		
		_aniSprite = new AnimatedSprite(spriteSheet, true);
		addChild(_aniSprite);
		
		_aniSprite.showBehavior("run", true);
	}
	
	// ================================================ Control Event ================================================== // 
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		acceleration.x = 0;
		
		if (e.keyCode == Keyboard.LEFT) {
			acceleration.x = -_horizontalSpeed;
			_aniSprite.scaleX = -1;
			_aniSprite.x = _aniSprite.width;
		} else if (e.keyCode == Keyboard.RIGHT) {
			acceleration.x = _horizontalSpeed;
			_aniSprite.scaleX = 1;
			_aniSprite.x = 0;
		}
		
		//if (e.keyCode
	}
	
	private function onKeyUp(e:KeyboardEvent):Void 
	{
		acceleration.x = 0;
	}
	
	
	public function onUpdate(dt :Float) 
	{
		if (_aniSprite != null)
			_aniSprite.update(Std.int(dt * 1000));
			
		this.x += (acceleration.x * dt);
		this.y += (acceleration.y * dt) + (_gravity * dt);
	}
	
	function applyGravity(dt :Float) 
	{
		
	}
	
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
}