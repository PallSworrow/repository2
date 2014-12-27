package PS.view.scroller 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import PS.controller.events.ControllerEvent;
	import PS.controller.events.SwipeEvent;
	import PS.controller.SimpleController;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.gallery.interfaces.IgalleryItem;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.scroller.events.ScrollerEvent;
	import PS.view.scroller.interfaces.Ipage;
	import PS.view.scroller.interfaces.IlistScroller;
	import PS.view.scroller.interfaces.Iscroller;
	import PS.view.scroller.pages.EmptyPage;
	import PS.view.scroller.pages.TestPage;
	import PS.view.textView.SimpleText;
	
	/**
	 * ...
	 * @author 
	 */
	internal class SimpleScroller extends BaseSprite implements Iscroller
	{
		//main vars:
		private var _layout:IlistLayout;
		private var msk:Sprite;
		//customize vars:
		private var _freeSpaceEndSize:int = 0;
		private var _autoUpdate:Boolean = true;
		private var _defaultSwipeForce:int=0.4;
		private var _scrollDuration:Number = 0.6;
		private var _swipeDuration:Number = 0.6;
		private var _draggable:Boolean = false;
		
		//engine vars:
		private var ctrl:SimpleController;
		private var tween:TweenMax;
		//status vars:
		private var _isMoving:Boolean = false;
		protected var isDragging:Boolean = false;
		private var previusOffset:int;
		private var _itemProvider:Function;
		public function SimpleScroller(w:int,h:int, vertical:Boolean=true) 
		{
			super();
			//mask:
			msk = new Sprite();
			msk.graphics.beginFill(0x000000);
			msk.graphics.drawRect(0, 0, w, h);
			msk.graphics.endFill();
			
			
			_layout = createLayout();
			
			addElement(_layout);
			addChild(msk);
			mask = msk;
			
			//controller:
			ctrl = new SimpleController(this);
			draggable = true;
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		}
		
		private function mouseWheel(e:MouseEvent):void 
		{
			//trace(this, 'WHEEL', e.delta);
			if (draggable && isVertical)
			{
				var newOffset:int = offset + e.delta * 2;
				if (newOffset > maxOffset) newOffset = maxOffset;
				if (newOffset < 0) newOffset = 0;
				innerScrollTo(newOffset, 0.3);
				e.preventDefault();
			}
		}
		override public function dispose():void 
		{
			if (_layout) _layout.dispose();
			_layout = null;
			
			draggable = false;
			super.dispose();
		}
		//==================================================== CUSTOMIZE: ====================================================
		/**
		 * Используется для создания элементов списка. должна иметь вид function(data:Object):Ipage
		 * data - это соотвествующая индексу дата, переданная через addItem()
		 */
		public function set itemProvider(value:Function):void
		{
			_itemProvider = value;
		}
		
		
		
		
		//OVERRIDES:
		override public function get width():Number 
		{
			return msk.width;
		}
		override public function get height():Number 
		{
			return msk.height;
		}
		
		override public function set width(value:Number):void 
		{
			msk.width = value;
			if (!isVertical && autoUpdate) update();
		}
		override public function set height(value:Number):void 
		{
			msk.height = value;
			if (isVertical && autoUpdate) update();
		}
		
		
		//FACTORIES:
		protected function createLayout():IlistLayout
		{
			return new SimpleListLayout();
		}
		protected function createPage(data:Object):Ipage
		{
			if (_itemProvider is Function) 
			{
				data = _itemProvider(data);
			}
			if (data is Ipage) return data as Ipage;
			
			var res:EmptyPage = new EmptyPage();
			if (data is IviewElement) res.addElement(data as IviewElement);
			else if (data is DisplayObject) res.addChild(data as DisplayObject);
			else if ( data is String) 
			{
				var tf:SimpleText = new SimpleText();
				tf.text = String(data);
				tf.border = true;
				res.addChild(tf);
			}
			else res.addChild(new PsImage(new ColorAsset(200, 80)));
			
			return res;
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//==============================================INNER:================================================================
		//controller events:
		private function ctrl_onPress(e:ControllerEvent):void 
		{
			isDragging = true;
			stopScrolling();
			onMoveBegin();
		}
		private function ctrl_onMove(e:ControllerEvent):void 
		{
			if (!isDragging) return;
			if (isVertical) innerOffset -= ctrl.lastPoint.y - ctrl.prevPoint.y
			else innerOffset -= ctrl.lastPoint.x - ctrl.prevPoint.x
		}
		private function ctrl_onRelease(e:ControllerEvent):void 
		{
			if (!isDragging) return;
			isDragging = false;
			if (ctrl.lastSwipeDirection) onSwipe(ctrl.lastSwipeDirection);
			else 
			{
				_isMoving = false;
				onMoveComplete();
			}
		}
		protected function onSwipe(swipeDirection:String):void 
		{
			if ((isVertical && swipeDirection == SwipeEvent.UP) || (!isVertical && swipeDirection == SwipeEvent.LEFT)) 
			innerScrollTo(innerOffset + maxOffset * defaultSwipeForce, swipeDuration);
			if ((isVertical && swipeDirection == SwipeEvent.DOWN) || (!isVertical && swipeDirection == SwipeEvent.RIGHT)) 
			innerScrollTo(innerOffset - maxOffset * defaultSwipeForce, swipeDuration);
			//onScrollComplete();
		}
		
		
		//engine:
		public final function set innerOffset(value:int):void
		{

			if (value > maxOffset) value = maxOffset;
			if (value < 0) value = 0;
			previusOffset = innerOffset;
			if (value == innerOffset) return;
			
			if (isVertical) 
			{
				layout.y = -value;
				layout.x = 0;
			}
			else
			{
				layout.y = 0;
				layout.x = -value;
			}
			onMoving(value-previusOffset);
		}
		public final function get innerOffset():int
		{
			if (isVertical) 
			{
				return -layout.y;
			}
			else
			{
				return -layout.x;
			}
		}
		protected final function innerScrollTo(targOffset:int, duration:Number):void
		{
			if (isDragging) return;
			if (!isMoving) onMoveBegin();
			_isMoving = true;
			
			if (targOffset > maxOffset) targOffset = maxOffset;
			if (targOffset < 0) targOffset = 0;
			if (targOffset == innerOffset)
			{
				_isMoving = false;
				onMoveComplete()
				return;
			}
			
			tween = TweenMax.to(this, duration, 
			{	
				innerOffset:targOffset, 
				//onUpdate:onScrolling, 
				onComplete:function():void
				{
					_isMoving = false;
					onMoveComplete();
				}
			});
		}
		protected function onMoveBegin():void
		{
			
		}
		protected function onMoving(step:int):void
		{
			dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL));
		}
		protected function onMoveComplete():void
		{
			if (!isDragging)
			{
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE));
				if(innerOffset == maxOffset) dispatchEvent(new ScrollerEvent(ScrollerEvent.MAX_OFFSET));
				if (innerOffset == 0) dispatchEvent(new ScrollerEvent(ScrollerEvent.MIN_OFFSET));
			}
		}
		protected final function stopDragging():void
		{
			isDragging = false;
		}
		protected final function stopScrolling():void
		{
			if (tween) tween.kill();
			tween = null;
		}
	
		protected final function get layout():IlistLayout 
		{
			return _layout;
		}	
		protected function get maxOffset():int
		{
			//layout.update();
			var res:int;
			if(isVertical) res =  layout.height + freeSpaceEndSize - height;
			else  res = layout.width + freeSpaceEndSize - width;
			if (res < 0) res = 0;
			return res;
		}
		protected function get maskSize():int
		{
			if (isVertical) return height
			else return width;
		}
		
		protected function get isMoving():Boolean 
		{
			
			return _isMoving;
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
	
	
			
		/*======================= INTERFACE PS.view.scroller.advanced.interfaces.Iscroller =================================*/
		//SCROLLING:-------------------------------------------
		public function scroll(percent:Number):void 
		{
			innerScrollTo(maxOffset * percent, _scrollDuration );
		}
		
		public function scroll2(offset:int):void 
		{
			innerScrollTo(offset,_scrollDuration);
		}
		
		public function get percent():Number 
		{
			return offset/maxOffset;
		}
		
		public function get offset():int 
		{
			return innerOffset;
		}
		
		public function set percent(value:Number):void 
		{
			innerOffset = value*maxOffset;
		}
		
		public function set offset(value:int):void 
		{
			trace(this+' set offset: '+value);
			innerScrollTo(value, 0);
		}
		
		//CONTENT:------------------------------------------------------------------
		public function addItem(data:Object):int 
		{
			clear();
			var page:Ipage = createPage(data);
			page.load();
			layout.addItem(page);
			if (autoUpdate) update();
			return layout.length - 1;
		}
		
		public function clear():void 
		{
			layout.clear();
			if (autoUpdate) update();
			
		}
		public function update():void
		{
			layout.update();
			dispatchEvent(new ScrollerEvent(ScrollerEvent.UPDATE));
		}
	
		//GETTERS:---------------------------------------------------------------------
		public function getProportion():Number 
		{
			if (isVertical)	return height/layout.height
			else 	return width/layout.width
		}
		
		
		public function getMaxOffset():int 
		{
			return maxOffset;
		}
		//FLAGS:----------------------------------------------------------------------------
		public function get autoUpdate():Boolean 
		{
			return _autoUpdate;
		}
		
		public function set autoUpdate(value:Boolean):void 
		{
			_autoUpdate = value;
		}
		
		public function get isVertical():Boolean 
		{
			return layout.vertical;
		}
		
		public function set isVertical(value:Boolean):void 
		{
			if (layout.vertical == value) return;
			layout.vertical = value
			//isVertical = value;
		}
		public function get disposeItemsOnRemove():Boolean 
		{
			return layout.disposeChildrenOnRemove;
		}
		
		public function set disposeItemsOnRemove(value:Boolean):void 
		{
			layout.disposeChildrenOnRemove = value;
		}
		//CUSTOMIZE:-----------------------------------------------------------------------
		public function set defaultSwipeForce(value:int):void 
		{
			_defaultSwipeForce = value;
		}
		
		public function get defaultSwipeForce():int 
		{
			return _defaultSwipeForce;
		}
		
		public function get freeSpaceEndSize():int 
		{
			return _freeSpaceEndSize;
		}
		
		public function set freeSpaceEndSize(value:int):void 
		{
			_freeSpaceEndSize = value;
		}
		
		public function set scrollDuration(value:Number):void 
		{
			_scrollDuration = value;
		}
		
		public function set swipeDuration(value:Number):void 
		{
			_swipeDuration = value;
		}
		
		public function get scrollDuration():Number 
		{
			return _scrollDuration;
		}
		
		public function get swipeDuration():Number 
		{
			return _swipeDuration;
		}
		
		public function get draggable():Boolean 
		{
			return _draggable;
		}
		
		public function set draggable(value:Boolean):void 
		{
			if (value == _draggable) return;
			if(value)
			{
				ctrl.addEventListener(ControllerEvent.ON_PRESS, ctrl_onPress);
				ctrl.addEventListener(ControllerEvent.ON_RELEASE, ctrl_onRelease);
				ctrl.addEventListener(ControllerEvent.ON_MOVE, ctrl_onMove);
				
			}
			else
			{
				ctrl.removeEventListener(ControllerEvent.ON_PRESS, ctrl_onPress);
				ctrl.removeEventListener(ControllerEvent.ON_RELEASE, ctrl_onRelease);
				ctrl.removeEventListener(ControllerEvent.ON_MOVE, ctrl_onMove);
				isDragging = false;
			}
			_draggable = value;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}