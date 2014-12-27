package PS.model.requestSystem.apiInteraction.instagram 
{
	import PS.model.dataProcessing.profiles.imageProfile;
	import PS.model.dataProcessing.profiles.UserProfile;
	import model.instagramApi.constants.ApiMethod;
	import PS.constants.VarName;
	import PS.model.apiInteraction.ApiMethodResult;
	import PS.model.apiInteraction.ApiMethodVar;
	import PS.model.apiInteraction.IapiMethodDecoder;
	
	/**
	 * ...
	 * @author 
	 */
	public class ApiDecoder implements IapiMethodDecoder 
	{
		public function ApiDecoder() 
		{
			
		}
		
		/* INTERFACE PS.model.requestSystem.interfaces.IapiMethodDecoder */
		
		public function checkCallParams(params:Object, method:String):Object 
		{
			var res:Object = { };
			//три типа обработки параметров вызова:
			//1. Просмотреть метод на наличие Тэгов - и заменить но указанные в параметры.
			//Если указать ServerLoader-у в параметре вызова свойство LINK - он воспользуется ей вместо дефолтного домена(в данном случае вместо domain+method) 
			if (method.search('USER_ID') >= 0)
			{
				if (params[ApiMethodVar.USER_ID]) res[VarName.LINK] = Instagram.DOMAIN + method.replace('USER_ID', params[ApiMethodVar.USER_ID]);
				else throw new Error("Instagram api method "+method+" must receive user id [ApiMethodVar.USER_ID] as parameter");
			}
			if (method.search('TAG_NAME') >= 0)
			{
				if (params[ApiMethodVar.DATA_ID]) res[VarName.LINK] = Instagram.DOMAIN + method.replace('TAG_NAME', params[ApiMethodVar.DATA_ID]);
				else throw new Error("Instagram api method " + method + " must receive tag name[ApiMethodVar.DATA_ID] as parameter");
				trace(res[VarName.LINK]);
			}
			
			
			
			
			//2 добавить постоянные параметры
			res.client_id = Instagram.ClientID;
			//trace('DECODER call [' + method + ']' );
			//3 обработать и "перевести" на язык местного api входящие параметры
			if (method == ApiMethod.USERS_SEARCH ||method == ApiMethod.TAGS_SEARCH )
			{
				res.q = params[ApiMethodVar.SEARCH_REQ];
				
			}
			if (method == ApiMethod.GET_TAG_IMAGES || method == ApiMethod.GET_USER_IMAGES)
			{
				if (params[ApiMethodVar.COUNT]) res.count = params[ApiMethodVar.COUNT];
				if (params[ApiMethodVar.OFFSET]) res.max_id = params[ApiMethodVar.OFFSET];
		
			}
			return res;
		}
		
		
		public function checkLoadResult(params:Object, method:String):ApiMethodResult 
		{
			var res:Boolean;
			var data:Object = { };
			var list:Array;
			//trace(params);
			params = JSON.parse(String(params));
			if (params.meta.error_type == "OAuthException")
			{
				data[VarName.ERROR] = 'OAuthException';
				data[VarName.MESSAGE] = params.meta.message;
				res = false;
			}
			else 
			{
				//trace('DECODER answer [' + method + ']' );
				switch(method)
				{
					case ApiMethod.USERS_SEARCH:
						var prof:UserProfile;
						list = [];
						//trace('user list length: '+ (params.data as Array).length)
						for each( var prop:Object in params.data)
						{
							prof = new UserProfile(prop.id);
							
							for ( var a:String in prop)
							{
								//trace(a + '=' + prop[a]);
							}
							//trace('----------');
							prof.update(prop.full_name,  prop.profile_picture, prop.username);
							list.push(prof);
						}
						data[ApiMethodVar.USER_LIST] = list;
						data[ApiMethodVar.COUNT] = list.length;
						res = true;
						break;
					case ApiMethod.TAGS_SEARCH:
						list = [];
						var obj:Object;
						for each( var prop:Object in params.data)
						{
							obj = { };
							obj[ApiMethodVar.NAME] = prop.name;
							obj[ApiMethodVar.COUNT] = prop.media_count;
							list.push(obj);
						}
						data[ApiMethodVar.DATA_LIST] = list;
						data[ApiMethodVar.COUNT] = list.length;
						res = true;
						break
						
					case ApiMethod.GET_TAG_IMAGES:
					case ApiMethod.GET_USER_IMAGES:
						list = [];
						var img:InstagramImageProfile;
						//for (var pr:String in params.pagination);
						//{
							//trace(this, pr +': ' + params.pagination[pr]);
						//}
						if (params.pagination.next_max_id) data[ApiMethodVar.NEXT_ID] = params.pagination.next_max_id;
						for each (var item:Object in params.data) 
						{
							//trace('type: ' + item.type);
							//trace('link: ' + item.link);
							if (item.type == 'image')
							{
								img = new InstagramImageProfile(item.id)
								img.source = item.images.low_resolution.url;
								img.big = item.images.standard_resolution.url;
								if (item.caption) img.annotation = item.caption.text;
								
								img.location = item.location;
								img.date = item.created_time;
								list.push(img);
								
							}
		
						}
						data[ApiMethodVar.IMAGE_LIST] = list;
						data[ApiMethodVar.COUNT] = list.length;
						res = true;
						break;
						
					default:
						data[VarName.ERROR] = 'Не поддерживаемый метод api: ' + method;
						res = false;
						break;
				}
			}
			return new ApiMethodResult(res, data);
		}
		
		
		public function onError(params:Object, method:String):Object 
		{
			return params;
		}
		
	}

}