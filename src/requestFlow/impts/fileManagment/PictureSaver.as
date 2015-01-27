package requestFlow.impts.fileManagment 
{
	import simpleTools.PNGEncoderAsync;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import requestFlow.InnerRequest;
	import requestFlow.ReqsFlow;
	
	/**
	 * ...
	 * @author 
	 */
	public class PictureSaver extends InnerRequest 
	{
		
		
		public static function quickSave(image:DisplayObject, absoluteName:String, onComplete:Function=null):PictureSaver
		{
			var res:PictureSaver = new PictureSaver(image, absoluteName, onComplete,null,ReqsFlow.FILE_SYSTEM);
			return res;
		}
		
		private var pictureScale:int = 1;
		//private var _prePath:String='';
		
		private var img:DisplayObject;
		private var location:String;
		private var encoder:PNGEncoderAsync;
		private var fileStream:FileStream
		public function PictureSaver(picture:DisplayObject, absoluteName:String, onComplete:Function=null, onError:Function=null,addToFlow:String=null) 
		{
			trace('NEW', this);
			img = picture;
			
			location = absoluteName;
			encoder = new PNGEncoderAsync(8);
			super(onComplete, onError,addToFlow);
			
		}
		private var flag:Boolean = false;
		override protected function call():void 
		{
			trace(this, 'CALL');
			if (flag) throw new Error('invalid call, status: ' + status);
			//trace(this, 'CALL');
			flag = true;
			savePicture();
		}
		
		private function savePicture():void
		{
			//encode
			trace(this,'ENCODE: ' + img);
			var source:DisplayObject = img;
			var pngSource:BitmapData = new BitmapData (source.width*pictureScale, source.height*pictureScale,true,0);
			var matrix:Matrix = new Matrix();
			matrix.scale(source.scaleX * pictureScale, source.scaleY * pictureScale);
			pngSource.draw(source, matrix);
			
			encoder.addEventListener(Event.COMPLETE, encoder_complete);
			encoder.encode(pngSource);
			
		}
		
		private function encoder_complete(e:Event):void 
		{
			//write
			trace(this,'WRITE: '+location );
			var file:File = new File(location);
			fileStream = new FileStream();
			
			fileStream.openAsync(file, FileMode.UPDATE);
			fileStream.addEventListener(Event.COMPLETE, fileStream_complete);
			fileStream.writeBytes(encoder.png);
		}
		
		private function fileStream_complete(e:Event):void 
		{
			trace(this,'SAVING COMPLETE');
			fileStream.close();
			triggerComplete();
		}
		
		
		
		/*public function get prePath():String 
		{
			return _prePath;
		}
		
		public function set prePath(value:String):void 
		{
			if (!value) value = '';
			_prePath = value;
		}
		
		public function get pictureScale():int 
		{
			return _pictureScale;
		}
		
		public function set pictureScale(value:int):void 
		{
			if (value < 1) value = 1;
			_pictureScale = value;
		}
		*/
	}

}