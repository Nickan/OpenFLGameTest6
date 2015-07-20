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

	static var HORIZONTAL_SPEED :Float;
	static var MAX_HORIZONTAL_SPEED :Float;
	public var velocity(default, null) :Point;
	public var accel(default, null) :Point;
	public var collisionScaleX(default, null) :Float = 0.5;
	public var collisionScaleY(default, null) :Float = 0.9;
	public var collisionBounds(get, null) :Rectangle;
	
	public var readyToJump(default, default) :Bool = true;
	
	var _aniSprite :AnimatedSprite;
	var _gravity :Float;
	var _horizontalSpeed :Float;
	var _verticalSpeed :Float;
	
	var _brakingForce :Float;
	
	var _leftColliderOffset :Float = 0.2;
	var _rightColliderOffset :Float = 0;
	
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
		
		setupSprite();
		initializeVariables();
		
	}
	
	function initializeVariables() 
	{
		velocity = new Point();
		_horizontalSpeed = 0;
		_gravity = height * 12.5;
		HORIZONTAL_SPEED = width * 40;
		_brakingForce = width * 20;
		MAX_HORIZONTAL_SPEED = width * 5;
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
	private function onKeyDown(e :KeyboardEvent):Void 
	{
		//velocity.x = 0;
		
		if (e.keyCode == Keyboard.LEFT) {
			//velocity.x = -_horizontalSpeed;
			_horizontalSpeed = -HORIZONTAL_SPEED;
			_aniSprite.scaleX = -1;
			_aniSprite.x = _aniSprite.width;
		} else if (e.keyCode == Keyboard.RIGHT) {
			//velocity.x = _horizontalSpeed;
			_horizontalSpeed = HORIZONTAL_SPEED;
			_aniSprite.scaleX = 1;
			_aniSprite.x = 0;
		}
		
		if (e.keyCode == Keyboard.UP) {
			if (readyToJump) {
				readyToJump = false;
				velocity.y = height * -7.5;
			}

		}
		
		//if (e.keyCode
	}
	
	private function onKeyUp(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.LEFT) {
			if (_horizontalSpeed < 0)
				_horizontalSpeed = 0;
		} else if (e.keyCode == Keyboard.RIGHT) {
			if (_horizontalSpeed > 0)
				_horizontalSpeed = 0;
		}
	}
	
	
	public function onUpdate(dt :Float) 
	{
		updateVelocity(dt);
		
		if (_aniSprite != null)
			_aniSprite.update(Std.int(dt * 1000));
			
		//this.x += (velocity.x * dt);
		//this.y += (velocity.y * dt);
	}
	
	function updateVelocity(dt:Float) 
	{
		var interpHoriSpeed = _horizontalSpeed * dt;
		velocity.x += interpHoriSpeed;
		
		if (velocity.x != 0) {
			if (velocity.x > MAX_HORIZONTAL_SPEED)
				velocity.x = MAX_HORIZONTAL_SPEED;
			else if (velocity.x < -MAX_HORIZONTAL_SPEED)
				velocity.x = -MAX_HORIZONTAL_SPEED;
		}
		
			
		velocity.y += _gravity * dt;
		
		if (velocity.x != 0) {
			var interpBrakingForce = _brakingForce * dt;
			if (velocity.x > 0) 
				velocity.x -= interpBrakingForce
			else
				velocity.x += interpBrakingForce;
				
			if (Math.abs(velocity.x) < interpBrakingForce)
				velocity.x = 0;
		}
	}
	
	function applyGravity(dt :Float) 
	{
		
	}
	
	
	function get_collisionBounds() :Rectangle
	{
		var bounds = getBounds(parent);
		
		var scaledWidth = bounds.width * collisionScaleX;
		var scaledHeight = bounds.height * collisionScaleY;
		
		var offsetX = (bounds.width - scaledWidth) * 0.5;
		var offsetY = (bounds.height - scaledHeight) * 0.5;
		bounds.setTo(bounds.x + offsetX, bounds.y + offsetY, scaledWidth, scaledHeight);
		return bounds;
	}
	
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
}