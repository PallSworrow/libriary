package requestFlow.impts.fileManagment 
{
	import adobe.utils.CustomActions;
	import air.update.net.FileDownloader;
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
	public class FileCopier extends InnerRequest 
	{
		public static function copy(source:String, destination:String, onComplete:Function=null):FileCopier
		{
			return new FileCopier(source, destination, onComplete, null, ReqsFlow.FILE_SYSTEM);
		}
		private var file:File;
		private var targLocation:String;
		public function FileCopier(from:Object, to:String, onComplete:Function=null, onError:Function=null,addToFlow:String=null) 
		{
			trace(this, 'COPY: ' + from, to);
			file = from as File;
			if (!file)
			{
				file = new File(String(from));
			}
			targLocation = to;
			super(onComplete, onError,addToFlow);
			
		}
		override protected function call():void 
		{
			//trace('COPY:', file.url, targLocation);
			var targ:File = new File(targLocation);
			var fileStream:FileStream = new FileStream();
			
			fileStream.open(targ, FileMode.WRITE);
			fileStream.close();

			file.copyToAsync(targ, true);
			file.addEventListener(Event.COMPLETE, file_complete);
		}
		
		private function file_complete(e:Event):void 
		{
			triggerComplete();
		}
	}

}