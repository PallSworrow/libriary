package simpleButton 
{
	/**
	 * ...
	 * @author 
	 */
	public class BtnPhaze 
	{
		public static const ACTIVE:String = 'active';
		public static const DEFAULT:String = 'default';
		public static const PRESSED:String = 'pressed';
		public static const OVER:String = 'over';
		public static function validate(value:String):Boolean
		{
			if (value == ACTIVE
			|| value == DEFAULT
			|| value == PRESSED
			|| value == OVER)
			return true;
			else return false;
		}
		
	}

}