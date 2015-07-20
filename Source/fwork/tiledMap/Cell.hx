package fwork.tiledMap;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Nickan
 */
class Cell
{
	public var type(default, null) :String;
	public var bitmap(default, null) :Bitmap;

	public function new(type :String, bitmap :Bitmap) 
	{
		this.type = type;
		this.bitmap = bitmap;
	}
	
}