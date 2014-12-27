package PS.tools 
{
	import air.update.net.FileDownloader;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import model.Data;
	import PS.tools.PNGencoder;
	/**
	 * ...
	 * @author 
	 */
	public class FileManager 
	{
		private static const quality:int = 1;
		public static function savePicture(source:DisplayObject, absoluteName:String):void
		{
			trace(source, source.width,source.height);
			
			var pngSource:BitmapData = new BitmapData (source.width*quality, source.height*quality);
			var matrix:Matrix = new Matrix();
			matrix.scale(source.scaleX * quality, source.scaleY * quality);
			pngSource.draw(source,matrix);
			var ba:ByteArray = PNGencoder.encode(pngSource);
			var file:File = new File(/*Data.FILE.nativePath + "\\"+*/absoluteName)
			var fileStream:FileStream = new FileStream();
			
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(ba);
			fileStream.close();
		}
		public static function saveXML(source:XML, absoluteName:String):void
		{
			var file:File = new File(absoluteName)
			var fileStream:FileStream = new FileStream();
			
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(source.toXMLString());
			fileStream.close();
		}
		
		
		public static function deletePicture(absoluteDirectory:String):void
		{
			trace('[FileManager]', 'remove: ' + absoluteDirectory);
			var file:File = new File(/*Data.FILE.nativePath + "\\"+*/absoluteDirectory)
			file.deleteFile();
		}
		public static function moveAndRename(file:File, newDirectory:String, name:String):void
		{
			trace(newDirectory);
			var targ:File = new File(newDirectory + '\\' + name);
			var fileStream:FileStream = new FileStream();
			
			fileStream.open(targ, FileMode.WRITE);
			fileStream.close();

			file.copyTo(targ, true);
		}
		
		
		public static function clear(absoluteDirectory:String):void
		{
			//trace('FileManager', 'CLEAR');
			var folder:File = new File(/*Data.FILE.nativePath + "\\" + */absoluteDirectory);
			var getfiles:Array = folder.getDirectoryListing();
 
			//Push all thi values to the Arraycollection to be diaplayed in the list//
			for (var i:int = 0; i < getfiles.length; i++) 
			{ 			
				try
				{
					(getfiles[i] as File).deleteFile();
				}
				catch (e:Error) { }
			}
		}
		
		
	}

}