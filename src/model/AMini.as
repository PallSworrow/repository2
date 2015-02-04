package model 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import model.constants.AMDMpopup;
	import model.constants.PopupConstants;
	import model.loadedData.SearchData;
	import model.profiles.MusicianProfile;
	import popupManager.PopupEngine;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.popupSystem.factories.CustomPopupFactory;
	import PS.model.popupSystem.Ipopup;
	//import PS.model.popupSystem.PopupEngine;
	import PS.model.popupSystem.PopupManager;
	import PS.model.PsImage;
	import requestFlow.ReqsFlow;
	import Swarrow.models.Globals;
	import Swarrow.models.Initialiser;
	import view.popups.AddInstrumentPopup;
	import vk.APIConnection;
	
	/**
	 * ...
	 * @author 
	 */
	public class AMini extends Initialiser 
	{
		private var onComplete:Function;
		public function AMini(width:int, height:int, stage:Stage) 
		{
			super(width, height, stage);
			//PopupEngine.container = stage;//kill this shit
			
			PopupEngine.init(width, height, stage);
			
			ReqsFlow.getFlow(PopupConstants.FLOW_MAIN).flowSize = 1;//stack
			ReqsFlow.getFlow(PopupConstants.FLOW_PUBLIC).flowSize = -1;//infinit
			
			PopupEngine.createStage(PopupConstants.STAGE_MAIN, { stage:stage } );
			
		}
		override public function init( completeHandler:Function,config:String = null):void 
		{
			onComplete = completeHandler;
			
			PopupManager.setPopupFactory(AMDMpopup.ADD_INSTRUMENT_TYPE,
			new CustomPopupFactory(function():Ipopup { return new AddInstrumentPopup(); } ));
			super.init(onSuperInited,config);
		}
		override protected function readConfig(data:Object):void 
		{
			//trace(data);
			//Globals.stage.addChild(new PsImage(new ColorAsset(100, 100)));
			var res:Object = JSON.parse(String(data));
			SearchData.init(res.cities, res.goals,res.instruments, res.instTags,res.styles);
		}
		private function onSuperInited():void
		{
			var local:Boolean=false;
			//load environment:
			var flashVars: Object = Globals.stage.loaderInfo.parameters as Object; 
			if (!flashVars.api_id) 
			{ 
				local = true;
			  // -- For local testing enter you test-code here: 
			  flashVars['api_id'] = 1888171; 
			  flashVars['viewer_id'] = 66748; 
			  flashVars['sid'] = "7e22c25d7fece88f2316553937ff24f43e1073ca28e8b4302e65db35fa"; 
			  flashVars['secret'] = "6113n3e4g3"; 
			  // -- // 
			}
			Data._viewerId = flashVars.viewer_id;
			var VK:APIConnection = new APIConnection(flashVars);
			
			//
			if (local)
			{
				onEnviromentLoaded('tester','testerville','http://icons.iconarchive.com/icons/iconshock/real-vista-project-managment/256/tester-icon.png');
			}
			else 
			{
				VK.api('users.get', { user_ids:Data._viewerId, fields:'photo_400_orig, city' }, onProfLoaded, onApiError);
			}
			function onProfLoaded(data:Object):void
			{
				//*
				var tf:TextField  = new TextField();
				tf.width = 500;
				tf.autoSize = 'center';
				tf.wordWrap = true;
				tf.multiline = true;
				//tf.text = JSON.stringify(data);
				//Globals.stage.addChild(tf);
				//return;*/
				var name:String = data[0].first_name+' '+data[0].last_name;
				var city:String = 'SPB'//data[0].city.title;
				var photo:String = data[0].photo_400_orig;
				tf.text = name+', ' + city + ', ' + photo;
				onEnviromentLoaded(name,city,photo);
			}
			function onApiError(data:Object):void
			{
				var tf:TextField  = new TextField();
				tf.width = 500;
				tf.autoSize = 'center';
				tf.text = JSON.stringify(data);
				Globals.stage.addChild(tf);
				//onEnviromentLoaded();
			}
			
		}
		private function onEnviromentLoaded(name:String,city:String, photo:String):void
		{
			//log in:
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onLogged);
			var req:URLRequest = new URLRequest('http://allmusiciants.freevar.com/login.php');
			var vars:URLVariables = new URLVariables();
			vars['user_id'] = Data.viewerId;
			vars['name'] = name;
			vars['photo'] = photo;
			vars['city'] = city;
			
			req.data = vars;
			req.method = URLRequestMethod.POST;
			loader.load(req);
		}
		private function onLogged(e:Event):void
		{
			trace(e.target.data);
			var ld_res:Array = String(e.target.data).split('&');
			var isNew:Boolean = !Boolean(ld_res[0]);
			trace(this, 'login', ld_res[1]);
			Data._viewerProfile = new MusicianProfile(String(ld_res[1]));
			onComplete();
		}
	}

}