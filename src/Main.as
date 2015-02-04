package 
{
	import _examples.ControllerExample;
	import _examples.PopupExample;
	import _examples.ScrollerExample;
	import antares.BasicFunctional;
	import constants.AlignType;
	import _examples.LayoutUsageExample;
	import flash.display.Stage;
	import flash.events.Event;
	import layouts.glifs.LayoutMethodBase;
	import layouts.glifs.LayoutMethodProps;
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setInterval;
	import layouts.glifs.Glif;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.GlifType;
	import layouts.interfaces.IlayoutMethod;
	import layouts.methods.HorizontalList;
	import layouts.methods.VerticalList;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	import simpleController.MultitouchController;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var example:Sprite;
		public function Main():void 
		{ 
			
			//addChild(new PopupExample);
			example = new PopupExample();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);/*
			BasicFunctional.init(stage,{multitouch:false});
			BasicFunctional.initDownTime(function():void { trace('DOWNTIME'); }, 4000);
			*/
			
			
			var subElement:Sprite = new Sprite();
			
			example.addChild(subElement);
			addChild(example);
			
			trace('main stage', stage);
			trace('main parent: ' + parent);
			
			trace(example, example.stage);
			trace(example, example.parent );
			trace('subelement stage', subElement.stage);
			trace('subelement parent', subElement.parent );
			trace('global stage: ' + globalStage(subElement));
		}
		function globalStage(item:DisplayObject):Stage
		{
			var res:Stage;
			while (item.parent)
			{
				res = item.stage;
				item = item.parent;
			}
			return res;
		}
		
	}
	
}