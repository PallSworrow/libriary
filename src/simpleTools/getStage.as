package simpleTools 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public function getStage(of:DisplayObject):Stage
	{
		if (!of) return null;
		if (of.parent) return getStage(of.parent);
		else return of.stage;
	}
		
	
}