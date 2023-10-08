package com.taomee.seer2.core.scene
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.BitmapData;
   
   public class BigMapLoader extends BaseMapLoader
   {
       
      
      public function BigMapLoader()
      {
         super();
      }
      
      override public function load(param1:int) : void
      {
         _resourceId = param1;
         _xmlUrl = URLUtil.getMapConfig(param1.toString());
         UILoader.load(_xmlUrl,LoadType.TEXT,this.onXmlLoaded,this.onLoadError);
      }
      
      private function onXmlLoaded(param1:ContentInfo) : void
      {
         _configXml = XML(param1.content);
         this.parseConfigXml();
      }
      
      private function parseConfigXml() : void
      {
         var _loc1_:XML = _configXml.elements("resource")[0];
         var _loc2_:String = _loc1_.attribute("url").toString();
         _dataUrl = URLUtil.getMapData(_resourceId.toString());
         UILoader.load(_dataUrl,LoadType.TEXT,this.onDataLoaded,this.onLoadError);
      }
      
      private function onDataLoaded(param1:ContentInfo) : void
      {
         _dataXml = XML(param1.content);
         _imgUrl = URLUtil.getMapImage(_resourceId.toString() + "/map_s");
         UILoader.load(_imgUrl,LoadType.IMAGE,this.onIamgeLoaded,this.onLoadError);
      }
      
      private function onIamgeLoaded(param1:ContentInfo) : void
      {
         _mapBitmapData = BitmapData(param1.content);
         dispatchEvent(new SceneEvent(SceneEvent.LOAD_COMPLETE));
      }
      
      private function onLoadError(param1:ContentInfo) : void
      {
         dispatchEvent(new SceneEvent(SceneEvent.LOAD_ERROR));
      }
      
      override public function dispose() : void
      {
         UILoader.cancel(_xmlUrl,this.onXmlLoaded);
         UILoader.cancel(_dataUrl,this.onDataLoaded);
         super.dispose();
      }
   }
}
