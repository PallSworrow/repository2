package PS.model.requestSystem {
	import PS.model.requestSystem.constants.RequestType;
	import PS.model.requestSystem.handlers.GetImageHandler;
	import PS.model.requestSystem.handlers.TestReqHandler;
	import PS.model.requestSystem.handlers.URLloaderHandler;
	/**
	 * ...
	 * @author 
	 */
	public class RequestManager
	{
		//PUBLIC:
		public static var missErrors:Boolean = true;
		
		/**
		 * Создает запрос с указанными параметрами.
		 * @param	request - тип запроса который будет отправлен
		 * @param	params - парметры запроса
		 * @param	positiveAnswer - фунция в которую, в случае положительного ответа, будет передан answer:object
		 * @param	negativeAnswer - фунция в которую, в случае отрицательного ответа, будет передан answer:object
		 * @return возвращает id запроса по которому можно будет к нему обратиться. для req.abort() например
		 */
		public static function ask(request:String, params:Object, positiveAnswer:Function, negativeAnswer:Function):String 
		{
			return getRequestHandler(request).ask(params, positiveAnswer, negativeAnswer);
		}
		
		public static function abort(request:String,id:String):void 
		{
			var handler:IrequestHandler = getRequestHandler(request);
			if (handler)handler.abort(id);
		}
		
		public static function forceAnswer(request:String, id:String,  positive:Boolean, answerParams:Object = null):void 
		{
			
			var handler:IrequestHandler = getRequestHandler(request);
			if (handler) handler.forceAnswer(positive,id,answerParams);
		}
		static public function setCurrentManager(value:RequestManager):void 
		{
			trace('--set requestManager--');
			trace('Все запросы текущего RequestManager будут отменены');
			if (_current) _current.dispose();
			_current = value;
		}
		
		//PRIVATE: ==================================================================================
		static private function getRequestHandler(type:String):IrequestHandler 
		{
			
			return currentManager.getHandler(type);
		}
		public static function setNewHandler(requestType:String, handler:IrequestHandler):void
		{
			currentManager.setHandler(requestType, handler);
		}
		
		private static var _current:RequestManager;
		static private function get currentManager():RequestManager
		{
			if (!_current) _current = new RequestManager();
			return _current;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		
		
		//INSTANCE:
		private var handlers:Object = { };
		public function RequestManager()
		{
			setHandler(RequestType.GET_PICTURE, new GetImageHandler());
			setHandler(RequestType.RANDOM, new TestReqHandler());
			setHandler(RequestType.GET_DATA, new URLloaderHandler());
		}
		/**
		 * Добавить поддержку нового запроса. запрос может быть обычным(не наследуя классы) - тогда вызов 
		 * @param	requestType - имя по которому божно будет его вызвать. Если оно совпадает с уже существующим - произойдет замена.
		 * @param	handler
		 */
		public function dispose():void
		{
			for each (var hndl:IrequestHandler in handlers) 
			{
				hndl.dispose();
			}
			handlers = null;
		}
		public function setHandler(requestType:String, handler:IrequestHandler):void
		{
			if (handlers[requestType]) (handlers[requestType] as IrequestHandler).dispose();
			handlers[requestType] = handler;
		}
		public function getHandler(request:String):IrequestHandler
		{
			if (!handlers[request])
			{
				throw new Error('Request ['+request+'] is not supported by ' + this);
			}
			return handlers[request];
		}
		
		
	}

}