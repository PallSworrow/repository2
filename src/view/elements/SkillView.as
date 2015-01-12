package view.elements 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import model.profiles.Skill;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import view.factories.btns.HardCodeBtnFactory;
	import view.factories.InstrumentIconFactory;
	import view.factories.tags.TestTagFactory;
	
	/**
	 * ...
	 * @author pall
	 */
	public class SkillView extends SimpleTagLayout 
	{
		private var skill:Skill;
		private var icon:DisplayObject;
		private var tags:TagsModule;
		private var level:DisplayObject;
		private var video:DisplayObject;
		private var audio:DisplayObject;
		public function SkillView(data:Skill,rectangle:Rectangle=null) 
		{
			super(rectangle);
			skill = data;
			
			icon = InstrumentIconFactory.createIcon(skill.type);
			tags = new TagsModule('Тэги:',data.tags,TestTagFactory.inst,DefaultButtonFactory.inst,false)
			
			show();
			autoUpdate = false;
			skill.addListener(update);
			placeMethod = method;
			
		}
		private function method()
		{
			tags.x = video.x = audio.x = icon.width + 10;
			level.y = icon.height + 10;
			video.y = tags.y + tags.height;
			audio.y = video.y + video.height;
		}
		private function testFactory(w:int, h:int):DisplayObject
		{
			return new PsImage(new ColorAsset(w, h));
		}
		private function show()
		{
			icon = InstrumentIconFactory.createIcon(skill.type);
			video = testFactory(300, 100);
			audio = testFactory(300, 100);
			level = testFactory(150, 50);
			addItem(icon as IviewElement, 'icon');
			addItem(tags, 'tags');
			addItem(video as IviewElement, 'video');
			addItem(audio as IviewElement, 'audio');
			addItem(level as IviewElement, 'level');
			update();
			
		}
	}

}