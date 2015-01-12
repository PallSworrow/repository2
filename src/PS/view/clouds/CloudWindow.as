package PS.view.clouds 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.clouds.behaviorImplts.CloseBehavior_OnFocusLost;
	import PS.view.clouds.behaviorImplts.OpenBehavior_OnTap;
	import PS.view.clouds.interfaces.IcloudWindow;
	import PS.view.clouds.interfaces.ICWcloseBehavior;
	import PS.view.clouds.interfaces.ICWopenBehavior;
	
	/**
	 * ...
	 * @author 
	 */
	public class CloudWindow extends EventDispatcher implements IcloudWindow
	{
		
		
		private var _positionX:int=0;
		private var _positionY:int=0;
		private var _item:DisplayObject;
		private var _followAnchor:Boolean;
		private var _showBehavior:ICWopenBehavior = new OpenBehavior_OnTap();
		private var _hideBehavior:ICWcloseBehavior = new CloseBehavior_OnFocusLost();
		//props:
		
		public function CloudWindow(graphics:DisplayObject) 
		{
			super(this);
			_item = graphics;
		}
		public function dispose():void
		{
			kill();
			_item = null;
		}
		
		
		//////////////////////////////////////////////////////////////////////////////
		private var targStage:Stage;
		private var trig:InteractiveObject;
		private var _isShown:Boolean = false;
		private var anchorVal:Object;
		public function init( trigger:InteractiveObject,toStage:Object=null, anchor:Object=null):void
		{
			trace(this, 'init');
			if(toStage is Stage)targStage = toStage as Stage;
			else if (toStage is String) targStage  = CloudWindowLayers.getLayer(String(toStage));
			else targStage = CloudWindowLayers.defaultCloudsStage;
			if (!targStage) throw new Error('incorrect stage initialization: ' + targStage);
			
			if (anchor is Boolean)
			{
				followAnchor = Boolean(anchor);
				if (anchor) anchor = trigger;
			}
			else anchorVal = anchor;
			
			
			//throw 'must be overrided';
			showBehavior.init(this,targStage, trigger);
			hideBehavior.init(this,targStage, trigger);
			
			showBehavior.enabled = true;
			hideBehavior.enabled = false;
			
			
			
		}
		public function kill():void
		{
			//throw 'must be overrided';
			hide();
			
			showBehavior.dispose();
			hideBehavior.dispose();
			
			targStage = null;
			
		}
		//interface implementation:
		public function show():void 
		{
			if (isShown) return;
			if (!isInited) throw new Error("this cloud haven't been inited yet :(");
			trace(this, 'show');
			targStage.addChild(item);
			updatePos();
			
			
			
			_isShown = true;
			showBehavior.enabled = false;
			hideBehavior.enabled = true;
			
			
			
			item.addEventListener(Event.ENTER_FRAME, item_enterFrame);
		
		}
		
		private function item_enterFrame(e:Event):void 
		{
			if(followAnchor)
			updatePos();
		}
		
		public function hide():void 
		{
			if (!isShown) return;
			trace(this, 'hide');
			item.removeEventListener(Event.ENTER_FRAME, item_enterFrame);
			targStage.removeChild(item);
			_isShown = false;
			showBehavior.enabled = true;
			hideBehavior.enabled = false;
			
			
		}
		
		//events:
		private function item_focusOut(e:FocusEvent):void 
		{
			hide();
		}
		protected function updatePos():void 
		{
			updateAnchPosition();
			item.x = anch.x + _positionX;
			item.y = anch.y + _positionY;
			
		}
		private var anch:Point;
		private function updateAnchPosition():void
		{
			if (!anch) anch = new Point();
			
			if (anchorVal is DisplayObject)
			{
				var rect:Rectangle = anchorVal.getRect(targStage);
				anch.x = rect.x;
				anch.y = rect.y;
			}
			else if(anchorVal == 'Mouse')
			{
				anch.x = targStage.mouseX;
				anch.y = targStage.mouseY;
			}
			else
			{
				anch.x = 0;
				anch.y = 0;
				//throw new Error("follow method is called but no anchor-item've been defined");
			}
		}
		//GETTERS:
		public function get item():DisplayObject
		{
			return _item;
		}
		public function get isShown():Boolean 
		{
			return _isShown;
		}
		public function get isInited():Boolean
		{
			if (targStage) return true;
			else return false;
		}
		
		//setters & getters
		
		public function get offsetX():int 
		{
			return _positionX;
		}
		
		public function set offsetX(value:int):void 
		{
			_positionX = value;
		}
		
		public function get offsetY():int 
		{
			return _positionY;
		}
		
		public function set offsetY(value:int):void 
		{
			_positionY = value;
		}
		
		public function get followAnchor():Boolean 
		{
			return _followAnchor;
		}
		
		public function set followAnchor(value:Boolean):void 
		{
			_followAnchor = value;
		}
		
		public function get showBehavior():ICWopenBehavior 
		{
			return _showBehavior;
		}
		
		public function set showBehavior(value:ICWopenBehavior):void 
		{
			if(isShown) throw Error('switching behaviors after initialization - is not supported in the moment')
			_showBehavior = value;
		}
		
		public function get hideBehavior():ICWcloseBehavior 
		{
			return _hideBehavior;
		}
		
		public function set hideBehavior(value:ICWcloseBehavior):void 
		{
			if(isShown) throw Error('switching behaviors after initialization- is not supported in the moment')
			_hideBehavior = value;
		}
		
		
		
		
		
	}

}