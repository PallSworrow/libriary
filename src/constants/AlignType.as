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
		public static const BEFORE:String = 'before';
		public static const AFTER:String = 'after';
		
		public static const TOP:String = 'top';
		public static const MIDDLE:String = 'middle';
		public static const BOTTOM:String = 'bottom';
		public static const ABOVE:String = 'above';
		public static const UNDER:String = 'under';
		
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
			|| value == AFTER
			|| value == BEFORE
			);
			return res;
		}
		public static function validateVertical(value:String):Boolean
		{
			var res:Boolean = 
			(  value == TOP
			|| value == MIDDLE
			|| value == BOTTOM
			|| value == ABOVE
			|| value == UNDER
			);
			return res;
		}
	}

}