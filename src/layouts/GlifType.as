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
		public static const STATIC:String = 'static';
		
		public static function validate(value:String):Boolean
		{
			if (value == VERTICAL || value == HORIZONTAL || value == STATIC)
			return true;
			else
			return false;
		}
		
	}

}