package requestFlow.impts.fileManagment 
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import requestFlow.InnerRequest;
	import requestFlow.ReqsFlow;
	
	/**
	 * ...
	 * @author 
	 */
	public class DataSaver extends InnerRequest 
	{
		public static function save(data:Object, path:String, onComplete:Function=null):DataSaver
		{
			return new DataSaver(data, path, onComplete, null, ReqsFlow.FILE_SYSTEM);
		}
		
		private var _data:Object;
		private var location:String;
		private var fileStream:FileStream;
		public function DataSaver(data:Object,absolutePath:String, onComplete:Function=null, onError:Function=null,addToFlow:String=null) 
		{
			_data = data;
			location = absolutePath;
			super(onComplete, onError,addToFlow);
			
		}
		override protected function call():void 
		{
			saveData();
		}
		
		private function saveData():void 
		{
			var source:String;
			switch(true)
			{
				case _data is XML:
					source = _data.toXMLString();
					break;
				case _data is String:
					source  = String(_data);
				default:
					if (_data)
					source = JSON.stringify(_data);
					break;
			}
			var file:File = new File(location)
			fileStream = new FileStream();
			//FileMode.
			fileStream.addEventListener(Event.COMPLETE, fileStream_complete);
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(source);
			fileStream.close();
			
			triggerComplete();
			//fileStream.openAsync(file, FileMode.UPDATE);
			//fileStream.close();
			
		}
		
		private function fileStream_complete(e:Event):void 
		{
			//trace(this,'COMPLETE');
			//fileStream.close();
			//triggerComplete();
		}
		
	}

}