package view.elements 
{
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
	import Swarrow.view.layouts.LineLayout;
	import view.factories.btns.HardCodeBtnFactory;
	import view.factories.InstrumentIconFactory;
	import view.factories.tags.TestTagFactory;
	
	/**
	 * ...
	 * @author pall
	 */
	public class SkillView extends BaseSprite 
	{
		private var skill:Skill;
		private var icon:DisplayObject;
		private var tags:TagsModule;
		private var level:DisplayObject;
		private var videoLayout:LineLayout;
		private var audioLayout:LineLayout;
		private var video:Dictionary;
		private var audio:Dictionary;
		public function SkillView(data:Skill,rectangle:Rectangle=null) 
		{
			super();
			skill = data;
			//create glifs
			
			icon = InstrumentIconFactory.createIcon(skill.type);
			tags = new TagsModule('Тэги:',data.tags,TestTagFactory.inst,DefaultButtonFactory.inst,false)
			videoLayout = new LineLayout();
			videoLayout.widthObserver = 0;
			audioLayout = new LineLayout();
			audioLayout.widthObserver = 0;
			
			//fill data
			updateVideo();
			updateAudio();
			//display
			addChild(icon);
			addChild(tags);
			addChild(videoLayout);
			addChild(audioLayout);
			
			skill.addListener(placeMethod);
			placeMethod();
			
		}
		private function updateVideo(e:ArrayObserverEvent=null):void
		{
			var element:IviewElement;
			var val:String;
			if (!e)//full update
			{
				video = new Dictionary();
				videoLayout.clear();
				for (var k:int = 0; k < skill.video.length; k++) 
				{
					val = String(skill.video.getItem(k));
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
				for (var k:int = 0; k < skill.audio.length; k++) 
				{
					val = String(skill.audio.getItem(k));
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
		
		
		private function placeMethod(e:Event=null):void
		{
			tags.x = icon.width;
			//level.y = icon.height + 10;
			videoLayout.y = tags.y + tags.height;
			audioLayout.y = videoLayout.y + videoLayout.height;
		}
		private function testFactory(w:int, h:int):DisplayObject
		{
			return new PsImage(new ColorAsset(w, h));
		}
		
	}

}