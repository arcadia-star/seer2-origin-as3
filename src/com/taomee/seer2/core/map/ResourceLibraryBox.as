package com.taomee.seer2.core.map
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.system.ApplicationDomain;
   
   public class ResourceLibraryBox extends ResourceLibrary
   {
       
      
      public function ResourceLibraryBox(param1:ApplicationDomain)
      {
         super(param1);
      }
      
      override public function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = super.getMovieClip(param1);
         _loc2_.x = 120 - (1200 - LayerManager.stage.stageWidth) / 240 * 120;
         _loc2_.y = 50 - (660 - LayerManager.stage.stageHeight) / 100 * 50;
         ResContentLibrary.setValue(_loc2_);
         return _loc2_;
      }
      
      override public function getSprite(param1:String) : Sprite
      {
         var _loc2_:Sprite = super.getSprite(param1);
         _loc2_.x = 120 - (1200 - LayerManager.stage.stageWidth) / 240 * 120;
         _loc2_.y = 50 - (660 - LayerManager.stage.stageHeight) / 100 * 50;
         ResContentLibrary.setValue(_loc2_);
         return _loc2_;
      }
   }
}
