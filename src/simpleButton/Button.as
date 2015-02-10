package simpleButton 
{
	import com.greensock.loading.data.ImageLoaderVars;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import layouts.glifs.CustomGlif;
	import layouts.GlifType;
	import simpleButton.events.BtnEvent;
	import simpleButton.interfaces.Ibtn;
	import simpleButton.interfaces.IbuttonController;
	import simpleButton.interfaces.IsingleButtonBehavior;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class Button extends CustomGlif implements Ibtn
	{
		private var _group:BtnGroup;
		private var controller:IbuttonController;
		private var _isActive:Boolean = false;
		private var viewHandlers:Dictionary;
		private var ctrl:Controller;
		private var _phaze:String = BtnPhaze.DEFAULT;
		private var _onPressEnabled:Boolean = false;
		public function Button() 
		{
			super(GlifType.NONE);//для совместимости с glifMaker
			ctrl = new Controller(this);
			ctrl.addEventListener(ControllerEvent.TAP, tap);
			controller = new ButtonController(this, _activate, _desactivate);
			viewelements = new Dictionary();
			viewHandlers = new Dictionary();
			
		}
		public function addHandledChild(child:DisplayObject, name:String):void
		{
			addChild(child);
			viewelements[name] = child;
		}
		public function setViewHandler(phaze:String, handler:Function):void
		{
			if (BtnPhaze.validate(phaze))
			viewHandlers[phaze] = handler;
		}
		
		/* INTERFACE simpleButton.interfaces.Ibtn */
		public function setHandler(handler:Function, params:Object = null):void
		{
			currentHandler = handler;
			handlerParams = params;
		}
		public function get behavior():IsingleButtonBehavior 
		{
			return controller.method;
		}
		
		public function set behavior(value:IsingleButtonBehavior):void 
		{
			controller.method = value;
		}
		
		
		public function get group():String 
		{
			if (!_group) return null;
			else
			return _group.name;
		}
		
		public function set group(value:String):void 
		{
			//if(_group)_group.//remove
			_group = BtnGroup._getGroup(value);
			if (_group)_group._addBtn(this, controller);
		}
		
		
		public function tap(e:Event=null):void 
		{
			if (group)
			{
				_group.tap(this);
			}
			else 
			{
				controller.tap();
			}
			dispatchEvent(new BtnEvent(BtnEvent.TAP));
		}
		public function activate():void 
		{
			if (!isActive) tap();
		}
		
		public function desactivate():void 
		{
			if (isActive) tap();
		}
		
	
		private function _activate():void
		{
			trace(this, 'activate', _phaze,phaze == BtnPhaze.DEFAULT);
			_isActive = true;
			//phaze
			if (phaze == BtnPhaze.DEFAULT)
			{
				setPhaze(BtnPhaze.ACTIVE);
			}
			//handler
			dispatchEvent(new BtnEvent(BtnEvent.ACTIVATED));
			callHandler();
		}
		private function _desactivate():void
		{
			_isActive = false;
			dispatchEvent(new BtnEvent(BtnEvent.DEACTIVATED));
			//phaze
			if (phaze == BtnPhaze.ACTIVE)
			setPhaze(BtnPhaze.DEFAULT);
		}
		
		public function get isActive():Boolean 
		{
			return _isActive;
		}
		
		public function get phaze():String 
		{
			return _phaze;
		}
		
		public function get onPressEnabled():Boolean 
		{
			return _onPressEnabled;
		}
		
		public function set onPressEnabled(value:Boolean):void 
		{
			if (_onPressEnabled == value) return;
			_onPressEnabled = value;
			if (value)
			{
				ctrl.addEventListener(ControllerEvent.GESSTURE_START, ctrl_gesstureStart);
			}
			else
			{
				ctrl.removeEventListener(ControllerEvent.GESSTURE_START, ctrl_gesstureStart);
			}
		}
		
		private function ctrl_gesstureStart(e:ControllerEvent):void 
		{
			ctrl.addEventListener(ControllerEvent.GESSTURE_COMPLETE, ctrl_gesstureComplete);
			setPhaze(BtnPhaze.PRESSED);
		}
		
		private function ctrl_gesstureComplete(e:ControllerEvent):void 
		{
			if (isActive) setPhaze(BtnPhaze.ACTIVE);
			else setPhaze(BtnPhaze.DEFAULT);
		}
		
		
	
		////PRIVATE:
		private var viewelements:Dictionary;
		private function setPhaze(value:String):void
		{
			_phaze = value;
			var handler:Function = viewHandlers[value];
			if (handler)
			{
				switch(handler.length)
				{
					case 0:
						handler();
						break;
					case 1:
						handler(viewelements);
						break;
					case 2:
						handler(viewelements, phaze);
						break;
				}
			}
			dispatchEvent(new BtnEvent(BtnEvent.PHAZE_CHANGED));
			
		}
		
		private var currentHandler:Function;
		private var handlerParams:Object;
		private function callHandler():void
		{
			if (!currentHandler) return;
			switch(currentHandler.length)
			{
				case 0:
					currentHandler();
					break;
				case 1:
					currentHandler(handlerParams);
					break;
				case 2:
					currentHandler(handlerParams, this);
					break;
				default:
					throw new Error('invalid handler params number');
					break;
			}
		}
	}

}