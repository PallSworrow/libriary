package layouts.glifs 
{
	/**
	 * ...
	 * @author 
	 */
	public class LayoutMethodProps 
	{
		//main params:
		public var intervalX:int=0;
		public var intervalY:int=0;
		public var offsetX:int=0;
		public var offsetY:int = 0;
		
		//layout width|height modifying:
		//public var minLineHeight:int;
		//public var minColumnWidth:int;
		public var maxLineHeight:int=-1;
		public var maxColumnWidth:int=-1;
		public var overrideSizeGetters:Boolean = false;
		public var forceSize:Boolean=false;
		public var forceSizeIgnoreNonGlifs:Boolean = false;
		
		//tweenMax:
		//public var snapDuration:Number=0;
		//public var snapMethod:String;	//tween max ease function
		
		public function LayoutMethodProps() 
		{
			
		}
		
	}

}