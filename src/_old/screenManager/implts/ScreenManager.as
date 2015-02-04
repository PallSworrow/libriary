package Swarrow.models.screenManager.implts 
{
	import Swarrow.tools.dataObservers.RectangleObserver;
	import Swarrow.models.screenManager.interfaces.IscreenManager;
	import Swarrow.models.screenManager.interfaces.IscreenHierarchy;
	import Swarrow.models.screenManager.interfaces.Iscreen;
	import Swarrow.models.screenManager.interfaces.InavigationFilter;
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import Swarrow.models.screenManager.stuff.NavigatorCommand;
	/**
	 * ...
	 * @author pall
	 */
	public class ScreenManager extends EventDispatcher implements IscreenManager
	{
		
		public function ScreenManager() 
		{
			
		}
		//params:
		public var historySize:int = 1;
		
		//main vars:
		private var hr:IscreenHierarchy;
		private var cnt:DisplayObjectContainer;
		private var rect:RectangleObserver;
		private var filters:Vector.<InavigationFilter>;
		//current stat:
		private var currentScreen:Iscreen;
		private var currentCommand:NavigatorCommand;
		private var history:Vector.<NavigatorCommand> = new Vector.<NavigatorCommand>;
		//engine^
		private function filter(command:NavigatorCommand):NavigatorCommand
		{
			if (!filters) return command;
			for (var i:int = 0; i < filters.length; i++) 
			{
				if(filters[i].enabled)
				command = filters[i].navigate(command);
			}
			return command;
		}
		private function navigate(command:NavigatorCommand):void
		{
			var sc:Iscreen = hr.getScreen(command.destination);
			if (sc)
			{
				//display:
				if (sc != currentScreen)
				{
					if(currentScreen) currentScreen.hide();
					sc.show(cnt, command.displayParams,this);
				}
				//load:
				if (command.loadData)
				{
					sc.load(command.loadData);
				}
			}
			else if (currentScreen) currentScreen.hide();
			
			currentScreen = sc;
			currentCommand = command;
		}
			
		
		
		/* INTERFACE PS.models.screenManager.interfaces.IscreenManager */
		
		public function init(contaimer:DisplayObjectContainer, hierarchy:IscreenHierarchy, rectangle:RectangleObserver):void 
		{
			if (cnt) throw new Error(this + ' can not be inited more than once');
			
			cnt = contaimer;
			hr = hierarchy;
			trace(this, 'init', rectangle.currentValue);
			rect = rectangle;
		}
	
		
		public function set navigationFilters(value:Vector.<InavigationFilter>):void 
		{
			filters = value;
		}
		
		public function get navigationFilters():Vector.<InavigationFilter> 
		{
			return filters;
		}
		
		public function loadScreen(location:Object, data:Object=null):void 
		{
			var currLoc:Object;
			var command:NavigatorCommand;
			//write history:
			if (historySize > 0)
			{
				if (currentCommand) history.unshift(currentCommand);
				if (history.length > historySize) history.pop();
			}
			//update current date
			if (currentCommand) currLoc = currentCommand.destination;
			command = filter(new NavigatorCommand(currLoc, location, { }, data));
			navigate(command);
			
		}
		public function back(steps:int = 1):void
		{
			var res:NavigatorCommand;
			for (var i:int = 0; i < steps; i++)
			{
				if (history.length <= i) break;
				res = history.shift();
				
			}
			if(res)
			navigate(res);
		}
		public function get rectangle():RectangleObserver
		{
			return rect;
		}
		
		
		
	}

}