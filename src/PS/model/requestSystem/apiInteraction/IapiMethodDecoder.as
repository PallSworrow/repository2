package PS.model.apiInteraction 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IapiMethodDecoder 
	{
		function checkCallParams(params:Object, method:String):Object
		function checkLoadResult(params:Object, method:String):ApiMethodResult
		function onError(params:Object, method:String):Object
		
	}
	
}