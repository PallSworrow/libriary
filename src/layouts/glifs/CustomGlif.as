package layouts.glifs 
{
	/**
	 * ...
	 * @author 
	 */
	public class CustomGlif extends Glif 
	{
		private var _method:Function;
		public function CustomGlif(type:String=null) 
		{
			super(type);
			
		}
		public function setGlifType(value:String):void
		{
			glifType = value;
		}
		public function get resizeMethod():Function
		{
			return _method;
		}
		public function set resizeMethod(value:Function):void
		{
			_method = value;
			if (_method)
			{
				if (_method.length > 2) throw new Error('resize method must have 0-2 params');
			}
		}
		override protected function updateMethod():void 
		{
			if (!_method) return;
			
			switch(_method.length)
			{
				case 0:
					_method();
					break;
				case 1:
					_method(this);
					break;
				case 2:
					_method(this, glifType);
					break;
				
			}
		}
		
	}

}