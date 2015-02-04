package Swarrow.models.screenManager.bases 
{
	import flash.events.Event;
	import PS.models.screenManager.interfaces.IscreenManager;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import PS.models.screenManager.interfaces.Iscreen;
	import PS.tools.RectangleDispatcher;
	/**
	 * ...
	 * @author pall
	 */
	public class ScreenDecorator implements Iscreen
	{
		protected var content:DisplayObject;
		protected var currentRect:RectangleDispatcher;
		protected var currentManager:IscreenManager
		public function ScreenDecorator(viewContent:DisplayObject) 
		{
			content = viewContent;
		}
		
		/* INTERFACE PS.models.screenManager.interfaces.Iscreen */
		
		public function show(container:DisplayObjectContainer, rectangle:RectangleDispatcher, params:Object, manager:IscreenManager):void 
		{
			container.addChild(content);
			currentRect = rectangle;
			currentManager = manager;
		}
		
		public function hide():void 
		{
			if (content.parent) content.parent.addChild(content);
		}
		
		public function load(data:Object = null):void 
		{
			
		}
		
		public function clear():void 
		{
			
		}
		
		/* INTERFACE PS.models.screenManager.interfaces.Iscreen */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			content.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			content.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return content.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return content.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return content.willTrigger(type);
		}
		
	}

}