package fwork.tiledMap;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Nickan
 */
class Cell
{
	public var type(default, null) :String;
	public var bounds(default, null) :Rectangle;

	public function new(type :String, bounds :Rectangle) 
	{
		this.type = type;
		this.bounds = bounds;
	}
	
}