package layouts.interfaces 
{
	import flash.display.DisplayObject;
	import layouts.glifs.Glif;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IglifFactory extends IviewFactory
	{
		function createGlif(data:Object=null):Glif
		
	}
	
}