package PS.view.valueInput.defaults 
{
	import flash.geom.Rectangle;
	import PS.constants.Direction;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.textView.SimpleText;
	import PS.view.valueInput.numbeTyped.NumberInput;
	
	/**
	 * ...
	 * @author 
	 */
	public class DefaultNumberInput extends NumberInput 
	{
		
		public function DefaultNumberInput(min:int = 0,max:int=100 ) 
		{
			super(new Rectangle(0,0,300,100));
			addDecBtn(DefaultButtonFactory.createBtn(Direction.DOWN));
			addIncBtn(DefaultButtonFactory.createBtn(Direction.UP));
			addDisplay(new SimpleText());
			addTitle(new SimpleText());
			minValue = min;
			maxValue = max;
			
		}
		
	}

}