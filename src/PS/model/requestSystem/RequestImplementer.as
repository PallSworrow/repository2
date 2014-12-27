package PS.model.requestSystem 
{
	import PS.model.requestSystem.constants.RequestPhaze;
	/**
	 * Основа для выполнения запросов. 
	 * 
	 * DEFAULTS:
	 * Если не разширить методы - спустя 1 сек. возвращается случайным образом либо положительый, либо отрицательный ответ. 
	 * В параметрах ответа дублируется его тип: answerParams:{positive:boolean}
	 * @author 
	 */
	public class RequestImplementer
	{
		
		
		private var _id:String;
		private var _reqParams:Object
		private var handler0:Function
		private var handler1:Function
		
		private var _onComplete:Function;
		
		private var _phaze:String;
		private var _autoComplete:Boolean = true;
		public function RequestImplementer() 
		{
		
			_phaze = RequestPhaze.WAIT;
			
		}
		//ENGINE:
		//internal:
		internal function init(positive:Function, negatove:Function, params:Object, ID:String, completeHandler:Function):void
		{
			_id = ID;
			_onComplete = completeHandler;
			_reqParams = params;
			handler0 = positive;
			handler1 = negatove;
		}
		internal function start():void
		{
			_phaze = RequestPhaze.INPROGRESS;
			call(reqParams);
		}
		internal function pauseProgress():void
		{
			if (phaze == RequestPhaze.INPROGRESS)
			{
				_phaze = RequestPhaze.PAUSED;
				pause();
			}
		}
		internal function resumeProgress():void
		{
			if (phaze == RequestPhaze.INPROGRESS)
			{
				_phaze = RequestPhaze.PAUSED;
				pause();
			}
		}
		internal function cancel():void
		{
			abort();
			complete();
		}
		internal function forceAnswer(positive:Boolean, params:Object):void
		{
			if (positive) handler0(params);
			else handler1(params);
			
			if (autoComplete) complete();
			
		}
		protected final function complete():void
		{
			_phaze = RequestPhaze.SOLVED;
			_onComplete(this);
		}
		protected final function solve(positive:Boolean, params:Object):void
		{
			forceAnswer(positive, params);
		}
		//OVERRRIDE:
		//phazes:
		protected function call(params:Object):void
		{
			
		}
		
		protected function abort():void
		{
			
		}
		protected function pause():void
		{
			
		}
		protected function resume():void
		{
			
		}
		
		//public
		public function dispose():void
		{
			
		}
		
		//getters:
		public function get phaze():String 
		{
			return _phaze;
		}
		
		protected function get reqParams():Object 
		{
			return _reqParams;
		}
		
		public function get autoComplete():Boolean 
		{
			return _autoComplete;
		}
		
		public function set autoComplete(value:Boolean):void 
		{
			_autoComplete = value;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		
	}

}