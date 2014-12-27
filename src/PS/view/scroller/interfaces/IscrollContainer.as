package PS.view.scroller.interfaces 
{
	import flash.display.DisplayObject;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IscrollContainer extends Iscroller
	{
		function setContent(content:DisplayObject, triggerBackGround:Boolean = true ):void
		
	
		function clear():void
	
	
		/*function scrollTo(targ:Number):void
		
		
		function stepFor(step:int):void
		
	
		function scrollTo2(offset:int):void*/
		
		//function update():void
		
		
		//function get persent():Number 
		//function set persent(value:Number):void 
		
		//function get offset():int 
		//function set offset(value:int):void 
			
		//function get tweenDuration():Number 
		//function set tweenDuration(value:Number):void 
		
		//function get maxOffset():int 
	}
	
}