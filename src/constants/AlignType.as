package constants 
{
	/**
	 * ...
	 * @author 
	 */
	public class AlignType 
	{
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		public static const CENTER:String = 'center';
		public static const TOP:String = 'top';
		public static const MIDDLE:String = 'middle';
		public static const BOTTOM:String = 'bottom';
		
		public static function validate(value:String):Boolean
		{
			var res:Boolean = 
			(  value == LEFT
			|| value == RIGHT
			|| value == CENTER
			|| value == TOP
			|| value == MIDDLE
			|| value == BOTTOM
			);
			return res;
		}
		public static function validateHorizontal(value:String):Boolean
		{
			var res:Boolean = 
			(  value == LEFT
			|| value == RIGHT
			|| value == CENTER
			);
			return res;
		}
		public static function validateVertical(value:String):Boolean
		{
			var res:Boolean = 
			(  value == TOP
			|| value == MIDDLE
			|| value == BOTTOM
			);
			return res;
		}
	}

}