package com.taomee.seer2.core.scene
{
   import com.taomee.seer2.core.config.DreamConfig;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class MapLoader extends BaseMapLoader
   {
      
      public static var isDream:Boolean;
       
      
      public function MapLoader()
      {
         super();
      }
      
      override public function load(param1:int) : void
      {
         isDream = false;
         var _loc2_:uint = uint(param1);
         if(DreamConfig.isDream(param1))
         {
            isDream = true;
            _loc2_ = DreamConfig.getInfo(param1).prevMapId;
         }
         _xmlUrl = URLUtil.getMapConfig(_loc2_.toString());
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
         _swfUrl = URLUtil.getMapSwf(_loc2_);
         UILoader.load(_swfUrl,LoadType.SWF,this.onSwfLoaded,this.onLoadError);
      }
      
      private function onSwfLoaded(param1:ContentInfo) : void
      {
         _mapResource = param1.content;
         _libManager = new ResourceLibrary(param1.domain);
         dispatchEvent(new SceneEvent(SceneEvent.LOAD_COMPLETE));
      }
      
      private function onLoadError(param1:ContentInfo) : void
      {
         dispatchEvent(new SceneEvent(SceneEvent.LOAD_ERROR));
      }
      
      override public function dispose() : void
      {
         UILoader.cancel(_xmlUrl,this.onXmlLoaded);
         UILoader.cancel(_swfUrl,this.onSwfLoaded);
         super.dispose();
      }
   }
}
