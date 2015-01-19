package PS.view.previewer.bases {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import PS.constants.VarName;
	import PS.model.BaseSprite;
	import PS.model.requestSystem.constants.RequestType;
	import PS.model.requestSystem.RequestManager;
	import PS.view.previewer.FitTheSize;
	import PS.view.previewer.interfaces.Ipreviewer;
	
	/**
	 * ...
	 * @author p.swarrow
	 */
	public class SimplePreview extends BaseSprite implements Ipreviewer 
	{
		//main vars:
		private var _ftsType:String = FitTheSize.FILL;
		private var content:DisplayObject;
		private var msk:Sprite;
		
		//Customization:
		private var _centering:Boolean = true;
		
		
		//loader vars:
		private var loadId:String;
		private var currentSource:String;
		private var reqType:String;
		private var _cloneItem:Boolean=false;
		
		public function SimplePreview(w:int=100,h:int = 100, loader_requestType:String=null,customMask:Sprite=null) 
		{
			super();
			if (customMask)
			{
				msk = customMask;
				msk.width = w;
				msk.height = h;
			}
			else
			{
				msk = new Sprite();
				msk.graphics.beginFill(0x000000, 1);
				msk.graphics.drawRect(0, 0, w,h);
				msk.graphics.endFill();
			}
			addChild(msk);
			mask = msk;
			
			reqType = loader_requestType;
			if (!reqType) reqType = RequestType.GET_PICTURE;
		}
		
		
		//private:
		private function update():void
		{
			if (_ftsType && content) 
			{
				
				FitTheSize.fts(_ftsType, content, width, height);
				trace(this, 'update');
				trace(content.width, content.height);
				
			}
			else
			{
				//?
			}
			if (centering && content)
			{
				content.x = (width - content.width) / 2;
				content.y = (height - content.height) / 2;
			}
		/*	graphics.clear();
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, 0, width,height);
			graphics.endFill();*/
		}
		//override:
		override public function get width():Number 
		{
			return msk.width;
		}
		override public function get height():Number 
		{
			return msk.height;
		}
		
		override public function set height(value:Number):void 
		{
			//
			msk.height = value;
			update();
		}
		override public function set width(value:Number):void 
		{
			if(value == 0) throw new Error('value == 0')
			msk.width = value;
			update();
		}
		
		/* INTERFACE PS.elements.previewer.interfaces.Ipreviewer */
		
		public function show(item:DisplayObject):void 
		{
			currentSource = null;
			displayItem(item);
		}
		
		public function load(link:String):void 
		{
			//trace(this + ' load: ' + link);
			if (currentSource == link) return;
			clear();
			if (link == null || link == '' || reqType == null || reqType == '') return;
			
			currentSource = link;
			loadId = RequestManager.ask(reqType, { link:link }, onLoad_Complete, onLoad_Failed);
			
		}
		private function onLoad_Complete(param:Object):void
		{
			displayItem(param[VarName.DATA] as DisplayObject);
		}
		private function onLoad_Failed(param:Object):void
		{
			clear();
			//trace(this + ' load fail: ' + param[VarName.ERROR]);
		}
		
		public function clear():void 
		{
			if (canvas)
			{
				parent.removeChild(canvas);
				canvas = null;
			}
			if (content)
			{
				content.parent.removeChild(content);
				content = null;
			}
			if (loadId)
			{
				RequestManager.abort(reqType, loadId);
				loadId = null;
			}
		}
		
		/* INTERFACE PS.view.previewer.interfaces.Ipreviewer */
		
		public function get cloneItem():Boolean 
		{
			return _cloneItem;
		}
		
		public function set cloneItem(value:Boolean):void 
		{
			_cloneItem = value;
		}
		
		public function set ftsType(value:String):void 
		{
			//trace('set fts type: ' + value);
			_ftsType = value;
		}
		
		public function get ftsType():String 
		{
			return _ftsType;
		}
		
		public function get centering():Boolean 
		{
			return _centering;
		}
		
		public function set centering(value:Boolean):void 
		{
			_centering = value;
		}
		
		
		//Engine:
		private var canvas:Bitmap;
		protected function displayItem(item:DisplayObject):void
		{
			clear();
			var bd:BitmapData
			if (cloneItem)
			{
				bd = new BitmapData(item.width, item.height, false, 0x00ff00);
				var m:Matrix = new Matrix();
				m.scale(item.scaleX, item.scaleY);
				bd.draw(item,m);
				content = new Bitmap((bd));
			}
			else content = item;
			update();
			bd = new BitmapData(width, height, true, 0);
			
			var m:Matrix = new Matrix();
			m.scale(content.scaleX,content.scaleY);
			m.translate(content.x, content.y);
			//bd.drawWithQuality(content,m,null,null,null,null,StageQuality.HIGH_16X16 );
			bd.draw(content,m,null,null,null,false);
			canvas = new Bitmap(bd);
			addChild(canvas);
		}
		public function getSource():String
		{
			return currentSource;
		}
		
	}

}