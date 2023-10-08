package com.taomee.seer2.core.ui
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import org.taomee.utils.DisplayUtil;
   
   public class ScreenCover
   {
      
      private static var _cover:Sprite;
       
      
      public function ScreenCover()
      {
         super();
      }
      
      public static function show(param1:DisplayObjectContainer) : void
      {
         param1.addChild(getCover());
      }
      
      public static function hide() : void
      {
         DisplayUtil.removeForParent(_cover,false);
      }
      
      private static function getCover() : Sprite
      {
         if(_cover == null)
         {
            _cover = new UI_ScreenCover();
         }
         return _cover;
      }
   }
}
