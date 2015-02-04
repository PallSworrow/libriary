package scrollers.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerEvent extends Event 
	{
		//public static const SCROLL:String = 'scroll';
		public static const SCROLL_START:String = 'scrollstart';
		public static const SCROLL_COMPLETE:String = 'scrollcomplete';
		public static const PROPRION_CHANGE:String = 'proptionchange';
		private var _from:Number;
		private var _to:Number;
		private var _trigger:Object;
		private var _duration:Number;
		/**
		 * 
		 * @param	type
		 * @param	from - положение при начале прокуртки
		 * @param	to - конечное значение 
		 * @param	duration - время отведенное на анимацию
		 * @param	trigger - ссылка на инициатор прокрутки
		 */
		public function ScrollerEvent(type:String, from:Number, to:Number,duration:Number, trigger:Object='external') 
		{
			_from = from;
			_to = to;
			_duration = duration;
			_trigger = trigger;
			super(type);
			
		}
		
		public function get from():Number 
		{
			
			return _from;
		}
		
		public function get to():Number 
		{
			return _to;
		}
		
		public function get trigger():Object 
		{
			return _trigger;
		}
		
		public function get duration():Number 
		{
			return _duration;
		}
		override public function clone():Event 
		{
			return this;
		}
	}

}