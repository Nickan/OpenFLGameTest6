package fwork.tiledMap;
import haxe.Json;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Nickan
 */
class TiledMap extends Sprite
{
	public var cells(default, null) :Array<Cell>;
	
	var _jsonPath :String;
	var _cellsBitmapData :Array<BitmapData>;
	
	
	public function new(jsonPath :String) 
	{
		super();
		_jsonPath = jsonPath;
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		var levelData = Json.parse(Assets.getText(_jsonPath));
		setupCellsBitmapData(levelData);
		setupCellsBitmap(levelData);
	}
	
	function setupCellsBitmapData(levelData :Dynamic) 
	{
		var DEFAULT_DEST_POINT = new Point();
		_cellsBitmapData = [];
		var tiledBmpData = Assets.getBitmapData(levelData.tile_path);
		
		for (index in 0...levelData.cells.length) {
			var tmpCell = levelData.cells[index];
			var cellBmpData = new BitmapData(levelData.width, levelData.height, true, 0xFFFFFF);
			
			var point = new Point(tmpCell.point[0], tmpCell.point[1]);
			cellBmpData.copyPixels(tiledBmpData, new Rectangle(point.x, point.y, levelData.width, levelData.height), DEFAULT_DEST_POINT);
			_cellsBitmapData.push(cellBmpData);
		}
	}
	
	function setupCellsBitmap(levelData :Dynamic) 
	{
		cells = [];
		var index :Int = 0;
		for (x in 0...levelData.rows) {
			for (y in 0...levelData.columns) {
				var cellIndex = levelData.level_data[index++];
				if (cellIndex == -1)
					continue;
				
				var bmp = new Bitmap(_cellsBitmapData[cellIndex]);
				bmp.x = y * bmp.width;
				bmp.y = x * bmp.height;
				addChild(bmp);
				
				cells.push(new Cell(levelData.cells[cellIndex].type, bmp.getBounds(parent)));
			}
		}
	}
	
}