package view.elements.pageModules {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import model.profiles.Skill;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	import Swarrow.view.layouts.LayoutBase;
	import Swarrow.view.layouts.LineLayout;
	import Swarrow.view.layouts.ListLayout;
	import view.factories.btns.HardCodeBtnFactory;
	import view.factories.btns.TagFactory;
	import view.factories.InstrumentIconFactory;
	import view.factories.tags.TestTagFactory;
	
	/**
	 * ...
	 * @author pall
	 */
	public class SkillView extends LayoutBase 
	{
		private var skill:Skill;
		private var icon:DisplayObject;
		private var tags:TagsModule;
		private var level:DisplayObject;
		private var videoLayout:ListLayout;
		private var audioLayout:ListLayout;
		private var video:Dictionary;
		private var audio:Dictionary;
		private var editable:Boolean;
		public function SkillView(data:Skill,allowEdit:Boolean) 
		{
			super();
			trueHeight = true;
			skill = data;
			editable = allowEdit;
			//create glifs
			
			icon = InstrumentIconFactory.createIcon(skill.type);
			tags = new TagsModule('Тэги:',data.tags,new TagFactory(),DefaultButtonFactory.inst,editable)
			videoLayout = new ListLayout();
			audioLayout = new ListLayout();
			videoLayout.ignorNonGlifs = false;
			
			//fill data
			updateVideo();
			updateAudio();
			//display
			addChild(icon);
			addChild(tags);
			addChild(videoLayout);
			addChild(audioLayout);
			//skill.addListener(placeMethod);
			callUpdate();
			
		}
		private function updateVideo(e:ArrayObserverEvent=null):void
		{
			var element:IviewElement;
			var val:String;
			if (!e)//full update
			{
				video = new Dictionary();
				videoLayout.clear();
				for (var k:int = 0; k < skill.videos.length; k++) 
				{
					val = String(skill.videos.getItem(k));
					element = createNewVideo(val);
					video[val]=element;
					videoLayout.addElement(element);
				}
				return;
			}
			for (var i:int = 0; i < e.newElenents.length; i++) //add
			{
				val = String(e.newElenents[i]);
				element = createNewVideo(val);
				video[val] = element;
				videoLayout.addElement(element);
				
			}
			for (var j:int = 0; j < e.removedElements.length; j++) //remove
			{
				val = String(e.removedElements[j]);
				element = video[val];
				videoLayout.removeElement(element);
				delete video[val];
			}
			
		}
		private function updateAudio(e:ArrayObserverEvent=null):void
		{
			var element:IviewElement;
			var val:String;
			if (!e)//full update
			{
				audio = new Dictionary();
				audioLayout.clear();
				for (var k:int = 0; k < skill.audios.length; k++) 
				{
					val = String(skill.audios.getItem(k));
					element = createNewAudio(val);
					audio[val]=element;
					audioLayout.addElement(element);
				}
				return;
			}
			for (var i:int = 0; i < e.newElenents.length; i++) //add
			{
				val = String(e.newElenents[i]);
				element = createNewAudio(val);
				audio[val] = element;
				audioLayout.addElement(element);
				
			}
			for (var j:int = 0; j < e.removedElements.length; j++) //remove
			{
				val = String(e.removedElements[j]);
				element = audio[val];
				audioLayout.removeElement(element);
				delete audio[val];
			}
			//placeMethod();
		}
		private function createNewVideo(data:String):IviewElement
		{
			var res:SimpleText = new SimpleText();
			res.text = data;
			return res;
		}
		private function createNewAudio(data:String):IviewElement
		{
			var res:SimpleText = new SimpleText();
			res.text = data;
			return res;
		}
		
		override protected function onWidthSet():void 
		{
			callUpdate();
		}
		private var flag:Boolean = true;
		override protected function callUpdate(index:int=0):void 
		{
			flag = false;
			tags.x = videoLayout.x = audioLayout.x = icon.width;
			//level.y = icon.height + 10;
			tags.width = videoLayout.width = audioLayout.width = _width - tags.x;
			videoLayout.y = tags.y + tags.height;
			audioLayout.y = videoLayout.y + videoLayout.height;
			
			flag = true;
			dispatchHeightChange();
		}
		override protected function onGlifHeightChange(e:GlifEvent):void 
		{
			if (flag)
			callUpdate();
		}
		
		
	}

}