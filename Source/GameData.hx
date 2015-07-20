package;

enum GameState {
	MOVE_TO_NEXT_LEVEL;
	WIN;
}

/**
 * ...
 * @author Nickan
 */
class GameData
{
	static inline var MAX_STAGE :Int = 5;
	
	static var _instance :GameData;
	
	public var level(default, null) :Int;
	
	function new() 
	{
		level = 1;
	}
	
	public function moveToNextStage() :GameState {
		level++;
		if (level > MAX_STAGE)
			return GameState.WIN;
		return GameState.MOVE_TO_NEXT_LEVEL;
	}
	
	public function reset()
	{
		level = 1;
	}
	
	public static function getInstance() :GameData
	{
		if (_instance == null)
			_instance = new GameData();
		return _instance;
	}
	
}