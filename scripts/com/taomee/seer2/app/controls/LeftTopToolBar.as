package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   
   public class LeftTopToolBar extends Sprite
   {
      
      private static var _instance:com.taomee.seer2.app.controls.LeftTopToolBar;
      
      public static var isHide:Boolean = true;
       
      
      public function LeftTopToolBar()
      {
         super();
      }
      
      public static function get instance() : com.taomee.seer2.app.controls.LeftTopToolBar
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.controls.LeftTopToolBar();
         }
         return _instance;
      }
      
      public static function show() : void
      {
         LayerManager.uiLayer.addChild(instance);
         isHide = true;
      }
      
      public static function hide() : void
      {
         if(instance)
         {
            DisplayObjectUtil.removeFromParent(instance);
         }
         isHide = false;
      }
      
      public static function addBtn(param1:InteractiveObject) : void
      {
         instance.addChild(param1);
      }
   }
}
