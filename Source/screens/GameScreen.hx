package screens;
import fwork.Screen;
import fwork.tiledMap.TiledMap;
import haxe.Json;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.Event;
import sprites.Player;

/**
 * ...
 * @author Nickan
 */
class GameScreen extends Screen
{
	var _player :Player;
	var _playerCollisionManager :PlayerCollisionManager;
	var _tiledMap :TiledMap;

	public function new() 
	{
		super();
	}
	
	override public function onAdded()
	{
		super.onAdded();
		setupBackground();
		setupTiledMap();
		setupPlayer();
		setupPlayerCollisionManager();
	}
	
	function setupBackground() 
	{
		var bg = new Bitmap(Assets.getBitmapData("assets/bg.png"));
		addChild(bg);
	}
	
	function setupTiledMap() 
	{
		_tiledMap = new TiledMap("assets/json/level_data_1.json");
		addChild(_tiledMap);
	}
	
	function setupPlayer() 
	{
		_player = new Player();
		addChild(_player);
		_player.x = stage.stageWidth * 0.5;
		_player.y = stage.stageHeight * 0.9;
	}
	
	function setupPlayerCollisionManager() 
	{
		_playerCollisionManager = new PlayerCollisionManager(_player, _tiledMap.cells, this);
	}
	
	
	override public function onUpdate(dt:Float)
	{
		super.onUpdate(dt);
		if (_playerCollisionManager != null)
			_playerCollisionManager.onUpdate(dt);
		
		if (_player != null)
			_player.onUpdate(dt);
		
	}
	
}