package popupManager 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 
	 */
	public class PopupStage extends EventDispatcher
	{
		//main:
		private var _width:int;
		private var _height:int;
		private var _stage:DisplayObjectContainer;
		private static const stageEvents:Vector.<String> = Vector.<String>([MouseEvent.CLICK, MouseEvent.MOUSE_DOWN]);
		
		
		//params:
		private var _fogColor:uint = 0x000000;
		private var _fogAlpha:Number = 0.7;
		private var _fogging:Boolean = true;
		private var _fogSource:DisplayObject;
		private var _transparentFog:Boolean = false;
		private var _foggingDuration:Number = 0;
		
		//graphics:
		private var fog:DisplayObject;
		private var list:Array;
		public function PopupStage(stage:DisplayObjectContainer, w:int,h:int) 
		{
			if(!PopupEngine.inited) throw new Error("Popup engine hasn't been inited yet");
			_stage = stage;
			for (var i:int = 0; i < stageEvents.length; i++) 
			{
				_stage.addEventListener(stageEvents[i], onStageEvent);
			}
			_width = w;
			_height = h;
			list = [];
		}
		
		public function addPopup(popup:Popup):void
		{
			
			var inst:DisplayObject = popup.inst;
			//check fog:
			if (fogging)
			{
				if(transparentFog)
				fog = new Shape();
				else 
				fog = new Sprite();
				
				
				updateFog();
				
				if(foggingDuration ==0)
				fog.alpha = 1;
				else 
				{
					fog.alpha = 0;
					TweenMax.to(fog, foggingDuration, { alpha:1 } );
				}
				
				
				stage.addChild(fog);
			}
			//add:
			stage.addChild(inst);
			list.push(popup);
		
		}
		public function removePopup(popup:Popup):void
		{
			var inst:DisplayObject = popup.inst;
			
			//remove:
			var index:int = list.indexOf(popup);
			if (index < 0) throw Error('popup is not a child of this stage');
			list.splice(index, 1);
			stage.removeChild(inst);
			
			
			//remove fog:
			if (fog && list.length==0)
			{
				if(foggingDuration ==0)
				stage.removeChild(fog);
				else 
				TweenMax.to(fog, foggingDuration, 
				{
					alpha:0, 
					onComplete:function():void
					{
						stage.removeChild(fog);
					} 
				} );
			}
		}
		
		
		public function updateSizes():void
		{
			dispatchEvent(new Event(Event.CHANGE));
			updateFog();
		}
		public function updateFog():void
		{
			if (!fog) return;
			if (fogSource)
			{
				if (fogSource.parent != stage)
				stage.addChild(fogSource);
				
				fog.width = width;
				fog.height = height;
			}
			else
			{
				trace(this, 'draw fog', 'alpha: ' + fogAlpha);
				var canvas:Graphics 
				if(fog is Sprite) canvas = (fog as Sprite).graphics;
				if(fog is Shape) canvas = (fog as Shape).graphics;
				canvas.clear();
				canvas.beginFill(fogColor, fogAlpha);
				canvas.drawRect(0, 0, width, height);
				canvas.endFill();
			}
		}
		//EVENTS:
		private function eventPreventer(e:Event):void
		{
			e.stopPropagation();
			//e.preventDefault()
		}
		private function onStageEvent(e:Event):void 
		{
			dispatchEvent(e);
		}
		//setters:
		public function set width(value:int):void 
		{
			if (_width == value) return;
			_width = value;
			updateSizes()
		}
		public function set height(value:int):void 
		{
			if (_height == value) return;
			_height = value;
			updateSizes()
		}
		public function set fogColor(value:uint):void 
		{
			_fogColor = value;
			updateFog();
		}
		public function set fogAlpha(value:Number):void 
		{
			_fogAlpha = value;
			updateFog();
		}
		public function set fogging(value:Boolean):void 
		{
			_fogging = value;
			updateFog();
		}
		public function set fogSource(value:DisplayObject):void 
		{
			if (_fogSource)
			{
				if (_fogSource.parent == stage)
				stage.removeChild(_fogSource);
			}
			_fogSource = value;
			updateFog();
		}
		public function set transparentFog(value:Boolean):void 
		{
			_transparentFog = value;
			updateFog();
		}
		public function set foggingDuration(value:Number):void 
		{
			_foggingDuration = value;
		}
		
		//getters:
		public function get width():int 			{return _width;}
		public function get height():int			{return _height;}
		public function get fogColor():uint			{return _fogColor;}
		public function get fogAlpha():Number 		{return _fogAlpha;}
		public function get fogging():Boolean 		{return _fogging;}
		public function get fogSource():DisplayObject{return _fogSource;}
		public function get transparentFog():Boolean {return _transparentFog;}
		public function get foggingDuration():Number {return _foggingDuration;}
		
		//main Getters:
		public function get stage():DisplayObjectContainer {	return _stage;}
		
		
		
		
	}

}