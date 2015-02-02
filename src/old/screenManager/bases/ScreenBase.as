package Swarrow.models.screenManager.bases 
{
	import Swarrow.models.screenManager.interfaces.Iscreen;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import Swarrow.models.screenManager.interfaces.IscreenManager;
	import Swarrow.tools.dataObservers.RectangleObserver;
	
	/**
	 * ...
	 * @author pall
	 */
	public class ScreenBase extends Sprite implements Iscreen 
	{
		protected var currentManager:IscreenManager
		public function ScreenBase() 
		{
			super();
			
		}
		
		/* INTERFACE PS.models.screenManager.interfaces.Iscreen */
		
		public function show(container:DisplayObjectContainer,  params:Object, manager:IscreenManager):void 
		{
			container.addChild(this);
			currentManager = manager;
			currentManager.rectangle.addEventListener(Event.CHANGE, rectangle_change);
			rectangleChange();
		}
		
		private function rectangle_change(e:Event):void 
		{
			rectangleChange();
		}
		
		protected function rectangleChange():void 
		{
			
		}
		protected function get rect():RectangleObserver
		{
			return currentManager.rectangle;
		}
		public function hide():void 
		{
			if (parent) parent.removeChild(this);
			currentManager.rectangle.removeEventListener(Event.CHANGE, rectangle_change);
			currentManager = null;
		}
		
		public function load(data:Object = null):void 
		{
			
		}
		
		public function clear():void 
		{
			
		}
		
	}

}