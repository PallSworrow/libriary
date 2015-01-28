package requestFlow 
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import requestFlow.constants.RequestEvent;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class ReqsFlow 
	{
		public static const FILE_SYSTEM:String = 'fileSystem';
		private static const flowList:Dictionary = new Dictionary();
		
		
		public static function getFlow(name:String):ReqsFlow
		{
			var res:ReqsFlow;
			if (!flowList[name]) 
			{
				var fs:int=-1;
				//default flows:
				if (name == FILE_SYSTEM) fs = 1;//stack
				
				res = new ReqsFlow(name,fs);
				
			}
			else res = flowList[name] as ReqsFlow;
			
			return res;
		}
		
		
		private var order:String;
		private var _name:String;
		
		private var activeList:Vector.<InnerRequest>;
		private var waitList:Vector.<InnerRequest>;
		
		private var interval:int = 0;
		private var intervalTimer:uint;
		private var _flowSize:int;
		public function ReqsFlow(name:String, maxFlowSize:int=-1) 
		{
			_flowSize = maxFlowSize;
			if (flowList[name]) throw Error('name ' + name + 'is already used for some request flow');
			_name = name;
			//_order = order;
			flowList[name] = this;
			activeList = new Vector.<InnerRequest>;
			waitList = new Vector.<InnerRequest>;
			
			
			
		}
		public function addRequest(req:InnerRequest):void
		{
			waitList.push(req);
			update();
		}
		public function addStack(reqs:Vector.<InnerRequest>):void
		{
			waitList = waitList.concat(reqs);
			update();
		}
		public function set callInterval(value:int):void
		{
			if (value < 0) value = 0;
			interval = value
		}
		private function update():void
		{
			var req:InnerRequest;
			while(waitList.length>0 && (activeList.length < flowSize || flowSize == -1) && !intervalTimer)
			{
				req = waitList.shift();
				activeList.push(req);
				req.addEventListener(RequestEvent.COMPLETE, req_complete);
				req.addEventListener(RequestEvent.ERROR, req_complete);
				req.addEventListener(RequestEvent.ABORT, req_abort);
				
				req.start();
				if (interval > 0) intervalTimer = setTimeout(intervalDone, interval);
				
			}
			
		}
		private function intervalDone():void
		{
			clearTimeout(intervalTimer);
			intervalTimer = null;
			update();
		}
		
		private function req_abort(e:RequestEvent):void 
		{
			e.request.removeEventListener(RequestEvent.COMPLETE, req_complete);
			e.request.removeEventListener(RequestEvent.ERROR, req_complete);
			e.request.removeEventListener(RequestEvent.ABORT, req_abort);
			var index:int = 
			index = activeList.indexOf(e.request);
			if (index >= 0)
			{
				activeList.splice(index, 1);
				update();
			}
			index = waitList.indexOf(e.request);
			if (index >= 0)
			{
				waitList.splice(index, 1);
			}
		}
		
		
		private function req_complete(e:RequestEvent):void 
		{
			e.request.removeEventListener(RequestEvent.COMPLETE, req_complete);
			e.request.removeEventListener(RequestEvent.ERROR, req_complete);
			e.request.removeEventListener(RequestEvent.ABORT, req_abort);
			trace('req complete: ' + req_abort);
			
			var index:int = activeList.indexOf(e.request);
			if (index >= 0)
			{
				activeList.splice(index, 1);
				update();
			}
			else//error
			{
				index = waitList.indexOf(e.request);
				if (index >= 0) throw new Error('Request can not be completed while waiting');
				else throw new Error('Request is not a part of this flow');
			}
		}
		
		
		
		
		
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get flowSize():int 
		{
			return _flowSize;
		}
		
		public function set flowSize(value:int):void 
		{
			if (value < 1 && value != -1) value = 1;
			if (_flowSize == value) return;
			_flowSize = value;
			update();
		}
		
	
		
	}

}