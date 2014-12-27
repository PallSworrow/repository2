package PS.model.requestSystem 
{
	import mx.events.Request;
	import PS.model.requestSystem.constants.RequestPhaze;
	import PS.constants.OrderType;
	
	/**
	 * ...
	 * @author 
	 */
	public class RequestHandlerBase implements IrequestHandler 
	{
		
		private var idCount:int = 0;
		private var order:String = OrderType.STACK;
		private var stack:Vector.<RequestImplementer>;
		
		private var supportedOrders:Array = 
		[
			OrderType.OVERRIDE,
			OrderType.STACK,
			OrderType.PARALLEL
		];
		public function RequestHandlerBase() 
		{
			stack = new Vector.<RequestImplementer>;
		}
		protected function createRequest():RequestImplementer
		{
			return new RequestImplementer();
		}
		/**
		 * Брать значения из constants.OrderType
		 * @param	type
		 */
		public function setOrderType(type:String):void
		{
		
			if (supportedOrders.indexOf(type)<0) 
			{
				trace(supportedOrders);
				throw new Error('Wrong order type: ' + type + ', supproted types - constants.OrderType');
			}
			else
			{
				order = type;
			}
		}
		//ENGINE:===========================================
		private function onNewRequest(req:RequestImplementer):void
		{
			if (order == OrderType.OVERRIDE) clearStack();
			
			stack.push(req);
			
			
			switch(order)
			{
				case OrderType.OVERRIDE:
				case OrderType.PARALLEL:
					req.start();
					break;
					
				case OrderType.STACK:
					if (stack.length == 1)
					req.start();
					break;
			}
		}
		private function onRequestComplete(req:RequestImplementer):void
		{
			
			var index:int = stack.indexOf(req);
			if (index >= 0)
			{
				stack[index].dispose();
				stack.splice(index, 1);
			}
			if (order == OrderType.STACK && stack.length>0)
			{
				if (stack[0].phaze == RequestPhaze.WAIT) 
				stack[0].start();
			}
		}
		private function clearStack():void
		{
			for (var i:int = stack.length - 1; i >= 0; i--)
			{
				stack[i].dispose();
				stack.slice(i,1);
			}
			
		}
		private function getReq(id:String):RequestImplementer
		{
			var req:RequestImplementer;
			for (var i:int = stack.length - 1; i >= 0; i--)
			{
				req = stack[i];
				if (req.id == id)
				{
					
					return req;
				}
			}
			return null;
		}
		////////////////////////////////////////////////////
		
		
		
		/* INTERFACE PS.model.requestSystem.IrequestHandler */
		public function ask(params:Object, positiveAnswer:Function, negativeAnswer:Function):String 
		{
			trace(this + ': ASK');
			var req:RequestImplementer = createRequest();
			
			req.init(positiveAnswer, negativeAnswer, params, String(idCount),onRequestComplete);
			onNewRequest(req);
			idCount++;
			return req.id;
		}
		
		public function abort(id:String):void 
		{
			var req:RequestImplementer = getReq(id);
			if (req) req.cancel();
		}
		
		public function forceAnswer(positive:Boolean, id:String, answerParams:Object = null):void 
		{
			var req:RequestImplementer = getReq(id);
			if (req) req.forceAnswer(positive, answerParams);
		}
		
		public function getPhaze(id:String):String 
		{
			var req:RequestImplementer = getReq(id);
			if (req) return req.phaze;
			else return null;
		}
		
		/* INTERFACE PS.model.requestSystem.IrequestHandler */
		
		public function dispose():void 
		{
			if (stack)
			{
				for (var i:int = stack.length-1; i >= 0; i--)
				{
					stack[i].cancel();
				}
			}
			stack = null;
		}
		
		
		
		
	}

}