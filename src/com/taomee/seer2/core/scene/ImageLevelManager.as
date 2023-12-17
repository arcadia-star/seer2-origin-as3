package com.taomee.seer2.core.scene
{
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.ui.ImagePanel;
   import flash.display.Stage;
   import flash.net.SharedObject;
   
   public class ImageLevelManager
   {
      
      private static var _stage:Stage;
      
      public static var _isShow:Boolean = false;
       
      
      public function ImageLevelManager()
      {
         super();
      }
      
      public static function setStage(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public static function showImagePanel() : void
      {
         if(!_isShow)
         {
            ImagePanel.showImage(_stage);
            _isShow = true;
         }
      }
      
      public static function setFightImageLevel(param1:String) : void
      {
         if(_stage.quality == param1)
         {
            return;
         }
         setSo(SharedObjectManager.IMAGE_FIGHT_LEVEL_INDEX,"image_fight_level_index",param1);
         _stage.quality = param1;
      }
      
      public static function setImageLevel(param1:String) : void
      {
         if(_stage.quality == param1)
         {
            return;
         }
         setSo(SharedObjectManager.IMAGE_LEVEL_INDEX,"image_level_index",param1);
         _stage.quality = param1;
      }
      
      public static function getImageQuality() : String
      {
         return getImageSoLevel(SharedObjectManager.IMAGE_LEVEL_INDEX,"image_level_index");
      }
      
      public static function getFightImageQuality() : String
      {
         return getImageSoLevel(SharedObjectManager.IMAGE_FIGHT_LEVEL_INDEX,"image_fight_level_index");
      }
      
      private static function getImageSoLevel(param1:String, param2:String) : String
      {
         var _loc3_:SharedObject = null;
         var _loc4_:Object = null;
         if(isActivityAnimationPlayed(param1,param2))
         {
            _loc3_ = SharedObjectManager.getUserSharedObject(param1);
            return (_loc4_ = _loc3_.data[param2]).imageLevel;
         }
         return "";
      }
      
      private static function setSo(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:SharedObject;
         (_loc4_ = SharedObjectManager.getUserSharedObject(param1)).clear();
         param2 = param2;
         var _loc5_:Object = new Object();
         _loc4_.data[param2] = _loc5_;
         _loc5_.imageLevel = param3;
         SharedObjectManager.flush(_loc4_);
      }
      
      private static function isActivityAnimationPlayed(param1:String, param2:String) : Boolean
      {
         var _loc3_:SharedObject = SharedObjectManager.getUserSharedObject(param1);
         param2 = param2;
         if(_loc3_.data[param2] == null)
         {
            return false;
         }
         return true;
      }
   }
}
