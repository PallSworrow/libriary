package popupManager 
{
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import popupManager.interfaces.*;
	import requestFlow.*;
	/**
	 * ...
	 * @author 
	 */
	public class Popup extends InnerRequest implements Ipopup
	{
		private static var count:int = 0;
		//static:
		public static const DEFAULT_FLOW:String = 'defaultpopupflow';
		public static const DEFAULT_STAGE:String = 'defaultStage';
	
		
		private var id:int;
		internal var inst:DisplayObject;
		private var stageDef:Object;
		private var flow:String;
		private var _currentFlow:ReqsFlow;
		private var _isShown:Boolean = false;
		
		private var stage:PopupStage;
		private var _currentController:IpopupController;
		private var _currentBehavior:IpopupBehavior;
		//private var stage:Stage
		public function Popup(source:DisplayObject, stageSelector:Object=null,addToFlow:String = null) 
		{
			if(!PopupEngine.inited) throw new Error("Popup engine hasn't been inited yet");
			id = count; count++;
			
			inst = source;
			inst.addEventListener(Event.ADDED_TO_STAGE, inst_addedToStage);
			stageDef = stageSelector;
			flow = addToFlow;
		}
		
		
		//PUBLIC:
		public function show(inFlow:String=null):void
		{
			if (isShown) return;
			if (currentFlow)
			{
				throw new Error('popup is already in ' + currentFlow + ' reqsFlow');
				return;
			}
			//add to flow
			var flw:String = inFlow;
			if (!flw) flw = flow;
			if (!flw) flw = DEFAULT_FLOW;
			
			_currentFlow = ReqsFlow.getFlow(flw);
			_currentFlow.addRequest(this);
			dispatchPopupEvent(PopupEvent.ADDED_TO_FLOW);
		}
		public function hide():void
		{
			
			_isShown = false;
			_currentFlow = null;
			
			dispatchPopupEvent(PopupEvent.REMOVED_FROM_FLOW);
			
			if (stage)//started
			{
				
				dispatchPopupEvent(PopupEvent.HIDE);
				stage.removePopup(this);
				triggerComplete();
				
			//dispatchPopupEvent(PopupEvent.HIDE_COMPLETE);
			}
			else
			{
				triggerAbort();
			}
		}
		
		public function get isShown():Boolean 
		{
			return _isShown;
		}
		
		public function get source():DisplayObject
		{
			return inst;
		}
		public function get currentStage():PopupStage
		{
			return stage;
		}
		
		public function get currentFlow():ReqsFlow 
		{
			return _currentFlow;
		}
		
	/*	public function get currentController():IpopupController 
		{
			return _currentController;
		}*/
		
		public function set currentController(value:IpopupController):void 
		{
			if (_currentController) _currentController.dispose();
			
			_currentController = value;
			if (_currentController) _currentController.init(this);
		}
		
		/*public function get currentBehavior():IpopupBehavior 
		{
			return _currentBehavior;
		}*/
		
		public function set currentBehavior(value:IpopupBehavior):void 
		{
			if (_currentBehavior) _currentBehavior.dispose();
			
			_currentBehavior = value;
			if (_currentBehavior)_currentBehavior.init(this);
		}
		
		
		
		
		//INNER:
		//validate parent:
		private function dispatchPopupEvent(type:String):void
		{
			dispatchEvent(new PopupEvent(type));
		}
		private function inst_addedToStage(e:Event):void 
		{
			if (!stage)throw new Error(this, "popup source can not be added anywhere except it's PopupStage");
			else if (stage.stage != inst.parent) throw new Error(this, "popup source can not be added anywhere except it's PopupStage");
		}
		
		
		override protected function call():void 
		{
			_isShown = true;
			// define current stage:
			if (!stageDef) stageDef = DEFAULT_STAGE;
			switch(true)
			{
				case stageDef is PopupStage:
					stage = stageDef as PopupStage;
					break;
				case stageDef is String:
					stage = PopupEngine.getStage(String(stageDef));
					break;
				default:
					stage = PopupEngine.getStage('individualStage_' + id);
					if(!stage) stage = PopupEngine.createStage('individualStage_' + id, stageDef);
					break;
			}
			
			dispatchPopupEvent(PopupEvent.DISPLAY);
			stage.addPopup(this);
			
			//dispatchPopupEvent(PopupEvent.DISPLAY_COMPLETE);
			
		}
		
	
		
	}

}