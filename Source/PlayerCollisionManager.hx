package;
import fwork.ScreenManager;
import fwork.tiledMap.Cell;
import openfl.display.DisplayObject;
import openfl.geom.Rectangle;
import screens.GameOverScreen;
import sprites.Player;

/**
 * ...
 * @author Nickan
 */
class PlayerCollisionManager
{
	var _player :Player;
	var _colliders :Array<Cell>;
	var _parent :DisplayObject;
	var _jumpReset :Bool = true;
	var _gameOver :Bool = false;
	
	public function new(player :Player, colliders :Array<Cell>, parent :DisplayObject) 
	{
		_player = player;
		_colliders = colliders;
		_parent = parent;
	}
	
	public function onUpdate(dt :Float)
	{
		if (_gameOver)
			return;
			
		var playerBounds = _player.collisionBounds;
		
		for (tmpCell in _colliders) {
			if (tmpCell.type == "door_open") {
				if (tmpCell.bitmap.getBounds(_parent).intersects(playerBounds)) {
					_player.readyToNextLevel = true;
					break;
				} else {
					_player.readyToNextLevel = false;
				}
			}
		}
		
		moveVerticallyAndCheckForCollision(dt);
		moveHorizontallyAndCheckForCollision(dt);
	}

	function moveVerticallyAndCheckForCollision(dt :Float) 
	{
		_player.y += _player.velocity.y * dt;
		var playerBounds = _player.collisionBounds;
		
		_player.readyToJump = false;
		for (tmpCell in _colliders) {
			
			if (tmpCell.type == "block") {
				if (playerBounds.intersects(tmpCell.bitmap.getBounds(_parent))) {
					playerCollidesVerticallyWith(tmpCell);
					break;
				}
			} else if (tmpCell.type == "spike_1") {
				var spikeBounds = tmpCell.bitmap.getBounds(_parent);
				var scaledWidth = (spikeBounds.width * 0.45);
				var scaledHeight = spikeBounds.height * 0.25;
				var offsetX = (spikeBounds.width - scaledWidth) * 0.5;
				var offsetY = (spikeBounds.height - scaledHeight) * 0.5;
				spikeBounds.setTo(spikeBounds.x + offsetX, spikeBounds.y + offsetY, scaledWidth, scaledHeight);
				if (playerBounds.intersects(spikeBounds)) {
					onGameOver();
					break;
				}
			} else if (tmpCell.type == "spike_2") {
				var spikeBounds = tmpCell.bitmap.getBounds(_parent);
				var scaledWidth = (spikeBounds.width * 0.45);
				var scaledHeight = spikeBounds.height * 0.25;
				var offsetX = (spikeBounds.width - scaledWidth) * 0.5;
				var offsetY = (spikeBounds.height - scaledHeight) * 0.5;
				spikeBounds.setTo(spikeBounds.x + offsetX, spikeBounds.y + offsetY, scaledWidth, scaledHeight);
				if (playerBounds.intersects(spikeBounds)) {
					onGameOver();
					break;
				}
			}
				
			
		}
	}
	
	function moveHorizontallyAndCheckForCollision(dt :Float) 
	{
		_player.x += _player.velocity.x * dt;
		var playerBounds = _player.collisionBounds;
		
		for (tmpCell in _colliders) {
			if (tmpCell.type == "block") {
				if (playerBounds.intersects(tmpCell.bitmap.getBounds(_parent))) {
					playerCollidesHorizontallyWith(tmpCell);
					break;
				}
			} else if (tmpCell.type == "spike_1") {
				var spikeBounds = tmpCell.bitmap.getBounds(_parent);
				var scaledWidth = (spikeBounds.width * 0.45);
				var scaledHeight = spikeBounds.height * 0.25;
				var offsetX = (spikeBounds.width - scaledWidth) * 0.5;
				var offsetY = (spikeBounds.height - scaledHeight) * 0.5;
				spikeBounds.setTo(spikeBounds.x + offsetX, spikeBounds.y + offsetY, scaledWidth, scaledHeight);
				if (playerBounds.intersects(spikeBounds)) {
					onGameOver();
					break;
				}
			} else if (tmpCell.type == "spike_2") {
				var spikeBounds = tmpCell.bitmap.getBounds(_parent);
				var scaledWidth = (spikeBounds.width * 0.45);
				var scaledHeight = spikeBounds.height * 0.25;
				var offsetX = (spikeBounds.width - scaledWidth) * 0.5;
				var offsetY = (spikeBounds.height - scaledHeight) * 0.5;
				spikeBounds.setTo(spikeBounds.x + offsetX, spikeBounds.y + offsetY, scaledWidth, scaledHeight);
				if (playerBounds.intersects(spikeBounds)) {
					onGameOver();
					break;
				}
			}
		}
		
		if (_player.readyToJump) {
			//if (!_player.movingHorizontally)
				//_player.velocity.x = 0;
		}
	}
	
	function onGameOver() 
	{
		
		if (_gameOver == false) {
			_gameOver = true;
			ScreenManager.getInstance().showOnScreen(new GameOverScreen());
		}
	}
	
	function playerCollidesHorizontallyWith(cell :Cell) 
	{
		if (cell.type == "block") {
			if (_player.velocity.x > 0)
				playerCollidesOnRight(cell);
			else
				playerCollidesOnLeft(cell);
		}
	}
	
	function playerCollidesVerticallyWith(cell :Cell) 
	{
		if (cell.type == "block") {
			if (_player.velocity.y > 0)
				playerCollidesOnGround(cell);
			else
				playerCollidesOnCeiling(cell);
		}
		
	}
	
	function playerCollidesOnGround(cell :Cell) 
	{
		_player.velocity.y = 0;
		_player.y = cell.bitmap.y - (_player.collisionBounds.height + 2);
		
		_player.readyToJump = true;
		//if (_jumpReset) {
			//if (!_player.readyToJump)
				//_player.readyToJump = true;
			//_jumpReset = false;
		//}
//
		//if (!_player.readyToJump)
			//_jumpReset = true;
	}
	
	function playerCollidesOnCeiling(cell:Cell) 
	{
		_player.velocity.y = 0;
		_player.y = cell.bitmap.y + (cell.bitmap.height + 1);
	}
	
	
	function playerCollidesOnRight(cell :Cell) 
	{
		_player.velocity.x = 0;
		var offsetX = (_player.width - (_player.width * _player.collisionScaleX)) * 0.5;
		_player.x = cell.bitmap.x - (_player.width - (offsetX) );
	}
	
	function playerCollidesOnLeft(cell :Cell) 
	{
		_player.velocity.x = 0;
		var offsetX = (_player.width - (_player.width * _player.collisionScaleX)) * 0.5;
		_player.x = (cell.bitmap.x + cell.bitmap.width) - offsetX;
	}
	
}