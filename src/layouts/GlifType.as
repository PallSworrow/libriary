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
		
		public static function validate(value:String):Boolean
		{
			if (value == VERTICAL || value == HORIZONTAL || value == STATIC || value == DYNAMIC)
			return true;
			else
			return false;
		}
		
	}

}