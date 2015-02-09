package scrollers.bases 
{
	import flash.display.Sprite;
	import scrollers.interfaces.Ipage;
	
	/**
	 * ...
	 * @author 
	 */
	public class EmptyPage extends Sprite implements Ipage
	{
		private var _isLoaded:Boolean=false;
		private var _isEnabled:Boolean=false;
		
		public function EmptyPage() 
		{
			super();
			
		}
		
		/* INTERFACE scrollers.interfaces.Ipage */
		
		public function load():void 
		{
			_isLoaded = true;
		}
		
		public function unload():void 
		{
			_isLoaded = false;
		}
		
		public function enable():void 
		{
			_isEnabled = true;
		}
		
		public function disable():void 
		{
			_isEnabled = false;
		}
		
		public function get isLoaded():Boolean 
		{
			return _isLoaded;
		}
		
		public function get isEnabled():Boolean 
		{
			return _isEnabled;
		}
		
	}

}