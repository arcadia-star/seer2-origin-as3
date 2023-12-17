package com.taomee.seer2.core.map
{
   import flash.display.Sprite;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor
   {
      
      public static var CLASS_PATH:String = "com.taomee.seer2.app.processor.map.MapProcessor_";
       
      
      protected var _map:MapModel;
      
      public function MapProcessor(param1:MapModel)
      {
         super();
         this._map = param1;
      }
      
      public static function createMapProcessor(param1:MapModel) : MapProcessor
      {
         var _loc2_:Class = DomainUtil.getCurrentDomainClass(CLASS_PATH + param1.resourceId);
         if(_loc2_ == null)
         {
            _loc2_ = MapProcessor;
         }
         return new _loc2_(param1) as MapProcessor;
      }
      
      public function init() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      protected function closeInteractor(param1:Sprite) : void
      {
         param1.mouseEnabled = false;
         param1.buttonMode = false;
      }
      
      protected function initInteractor(param1:Sprite) : void
      {
         if(param1)
         {
            param1.mouseChildren = false;
            param1.mouseEnabled = true;
            param1.buttonMode = true;
         }
      }
      
      public function checkChangeable() : Boolean
      {
         return true;
      }
   }
}
