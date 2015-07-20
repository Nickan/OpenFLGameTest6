package;
import fwork.tiledMap.Cell;
import openfl.display.DisplayObject;
import openfl.geom.Rectangle;
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
	
	public function new(player :Player, colliders :Array<Cell>, parent :DisplayObject) 
	{
		_player = player;
		_colliders = colliders;
		_parent = parent;
	}
	
	public function onUpdate(dt :Float)
	{
		moveVerticallyAndCheckForCollision(dt);
		moveHorizontallyAndCheckForCollision(dt);
	}

	function moveVerticallyAndCheckForCollision(dt :Float) 
	{
		_player.y += _player.velocity.y * dt;
		var playerBounds = _player.collisionBounds;
		
		for (tmpCell in _colliders) {
			if (playerBounds.intersects(tmpCell.bitmap.getBounds(_parent))) {
				//_player.y -= _player.velocity.y * dt;
				playerCollidesVerticallyWith(tmpCell);
				break;
			}
		}
	}
	
	function moveHorizontallyAndCheckForCollision(dt :Float) 
	{
		_player.x += _player.velocity.x * dt;
		var playerBounds = _player.collisionBounds;
		
		for (tmpCell in _colliders) {
			if (playerBounds.intersects(tmpCell.bitmap.getBounds(_parent))) {
				//_player.x -= _player.velocity.x * dt;
				playerCollidesHorizontallyWith(tmpCell);
				break;
			}
		}
		
		if (_player.readyToJump) {
			//if (!_player.movingHorizontally)
				//_player.velocity.x = 0;
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
		
		if (_jumpReset) {
			if (!_player.readyToJump)
				_player.readyToJump = true;
			_jumpReset = false;
		}

		if (!_player.readyToJump)
			_jumpReset = true;
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