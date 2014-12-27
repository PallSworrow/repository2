package view.factories.btns {
	import model.Embeds;
	import PS.model.dataProcessing.assetManager.EmbedAsset;
	import PS.model.PsImage;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class HardCodeBtnFactory implements IbuttonFactory 
	{
		public static const MAIL:String = 'mail';
		public static const S4BAND:String = 's4band';
		public static const S4MUS:String = 's4mus';
		
		private static const assets:Object = 
		{
			mail:{def:new EmbedAsset(Embeds.mailBtn)},
			s4band:{act:new EmbedAsset(Embeds.s4band_1),def:new EmbedAsset(Embeds.s4band_0)},
			s4mus:{act:new EmbedAsset(Embeds.s4mus_1),def:new EmbedAsset(Embeds.s4mus_0)}
		
		}
		public static const inst:IbuttonFactory = new HardCodeBtnFactory();
		public function HardCodeBtnFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			var img0:PsImage = new PsImage(assets[text].def);
			res.addViewElement(img0, 'img0');
			if (assets[text].act)
			{
				var img1:PsImage = new PsImage(assets[text].act);
				res.addViewElement(img1, 'img1');
				res.setViewHandler(ButtonPhaze.DEFAULT, onDefault);
				res.setViewHandler(ButtonPhaze.ACTIVE, onActive);
			}
			return res;
		}
		
		private function onDefault(params:Object):void
		{
			params.img0.alpha = 1;
			params.img1.alpha = 0;
		}
		private function onActive(params:Object):void
		{
			params.img0.alpha = 0;
			params.img1.alpha = 1;
		}
		
	}

}