package layouts 
{
	/**
	 * ...
	 * @author 
	 */
	public class GlifType 
	{
		public static const VERTICAL:String = 'vertical';
		public static const HORIZONTAL:String = 'horizontal';
		public static const STATIC:String = 'static';//internal resize w and h
		public static const DYNAMIC:String = 'dynamic'; //only external resize
		public static const NONE:String = 'none';
		
		public static function validate(value:String):Boolean
		{
			if (value == VERTICAL || value == HORIZONTAL || value == STATIC || value == DYNAMIC || value == NONE)
			return true;
			else
			return false;
		}
		
	}

}