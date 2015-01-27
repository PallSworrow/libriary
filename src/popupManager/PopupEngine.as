package popupManager 
{
	import requestFlow.ReqsFlow;
	import flash.automation.StageCapture;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class PopupEngine 
	{
		internal static var inited:Boolean = false;
		
		private static var defaultWidth:int;
		private static var defaultHeight:int;
		private static var defaultStage:DisplayObjectContainer;
	
		public static function init(width:int, height:int, stage:DisplayObjectContainer):void
		{
			if (inited) throw new Error('double init!');
			inited = true;
			defaultWidth = width;
			defaultHeight = height;
			defaultStage = stage;
			var defStage:PopupStage = createStage(Popup.DEFAULT_STAGE, stage);
			new ReqsFlow(Popup.DEFAULT_FLOW, 1);
			
		}
		private static const list:Dictionary = new Dictionary();//[PopupStage]
		public static function createStage(name:String, stage:Object):PopupStage
		{
			if (list[name]) throw new Error('this name is already used: ',name);
			if(!inited) throw new Error("Popup engine hasn't been inited yet");
			if (!stage) throw new Error('stage param must be not null');
			var res:PopupStage;
			var w:int;
			var h:int;
			var st:DisplayObjectContainer;
			switch(true)
			{
				case stage is PopupStage:
					res = stage as PopupStage;
					break;
				case stage is DisplayObjectContainer:
					res = new PopupStage(stage as DisplayObjectContainer, defaultWidth, defaultHeight);
					break;
				default:
					
					if (stage.width is Number) w = stage.width;
					else w = defaultWidth;
					if (stage.height is Number) h = stage.height;
					else h = defaultHeight;
					
					if (stage.stage is DisplayObjectContainer) st = stage.stage;
					else st = defaultStage;
					res = new PopupStage(st, w, h);
					//fog params:
					res.fogSource = stage.fogImg as DisplayObject;
					if(stage.fogAlpha is Number) res.fogAlpha = stage.fogAlpha;
					if(stage.fogcolor is uint)res.fogColor = stage.fogColor;
					if(stage.foggingDuration is Number) res.foggingDuration = stage.foggingDuration;
					
					if (stage.transparent is Boolean) res.transparentFog = Boolean(stage.transparent);
					break;
			}
			
			
			list[name] = res;
			return res;
			
		}
		public static function getStage(name:String):PopupStage
		{
			if(!inited) throw new Error("Popup engine hasn't been inited yet");
			return list[name];
		}
		
		
		
		
	}

}