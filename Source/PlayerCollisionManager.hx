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
	
	var _advancedPlayerBounds :Rectangle;
	
	public function new(player :Player, colliders :Array<Cell>, parent :DisplayObject) 
	{
		_player = player;
		_colliders = colliders;
		_parent = parent;
		
		_advancedPlayerBounds = _player.getBounds(parent).clone();
	}
	
	public function onUpdate(dt :Float)
	{
		var playerBounds = _player.getBounds(_player);
		_advancedPlayerBounds.x = playerBounds.x + _player.acceleration.x;
		_advancedPlayerBounds.y = playerBounds.y + _player.acceleration.y;
		
		for (tmpCell in _colliders) {
			if (_advancedPlayerBounds.intersects(tmpCell.bounds)) {
				playerCollidesWith(tmpCell);
			}
		}
		
	}
	
	function playerCollidesWith(cell :Cell) 
	{
		if (cell.type == "block") {
			//if (
		}
	}
	
}