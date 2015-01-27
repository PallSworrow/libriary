package requestFlow 
{
	import requestFlow.constants.RequestEvent;
	import adobe.utils.CustomActions;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class InnerRequest extends EventDispatcher
	{
		
		private var flow:ReqsFlow;
		private var _completeHandler:Function;
		private var _errorHandler:Function;
		
		private var _status:String = 'wait'; //-> process->complete|error
		public function InnerRequest( onComplete:Function=null, onError:Function=null,addToFlow:String=null) 
		{
			super(this);
			completeHandler = onComplete;
			errorHandler = onError;
			if (addToFlow)
			{
				flow = ReqsFlow.getFlow(addToFlow);
				
				flow.addRequest(this);
			}
		}
		
		//internal:
		internal function start():void
		{
			_status = 'process';
			call();
		}
		protected function call():void
		{
			
		}
		protected final function triggerComplete(params:Object=null):void
		{
			if (status != 'process') throw new Error('Request can not be completed before flow starts it');
			_status = 'complete';
			dispatchEvent(new RequestEvent(RequestEvent.COMPLETE));
			if (completeHandler is Function) 
			{
				if (completeHandler.length == 1) 
				completeHandler(params);
				else 
				completeHandler();
			}
		}
		protected final function triggerError(params:Object=null):void
		{
			if (status != 'process') throw new Error('Request can not be completed before flow starts it');
			_status = 'error';
			dispatchEvent(new RequestEvent(RequestEvent.ERROR));
			if (errorHandler is Function) 
			{
				if (errorHandler.length == 1 ) 
				errorHandler(params);
				else 
				errorHandler();
			}
		}
		protected final function triggerAbort(params:Object=null):void
		{
			
			_status = 'aborted';
			dispatchEvent(new RequestEvent(RequestEvent.ABORT));
			
		}
		
		
		public function get completeHandler():Function 
		{
			return _completeHandler;
		}
		
		public function set completeHandler(value:Function):void 
		{
			_completeHandler = value;
		}
		
		public function get errorHandler():Function 
		{
			return _errorHandler;
		}
		
		public function set errorHandler(value:Function):void 
		{
			_errorHandler = value;
		}
		
		public function get status():String 
		{
			return _status;
		}
	
		
		
	}

}