package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dreamlandchest.DreamlandChestManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class TitleMapProcessor extends MapProcessor
   {
       
      
      private var _mapTitle:MovieClip;
      
      public function TitleMapProcessor(param1:MapModel)
      {
         super(param1);
         this.initMapTitle();
      }
      
      private function initMapTitle() : void
      {
         this._mapTitle = _map.front["title"];
         DisplayObjectUtil.disableSprite(this._mapTitle);
         if(this._mapTitle != null && SceneManager.prevSceneType == SceneType.ARENA)
         {
            this._mapTitle.gotoAndStop(this._mapTitle.totalFrames);
         }
         DreamlandChestManager.init(_map);
      }
      
      override public function dispose() : void
      {
         this._mapTitle = null;
         _map = null;
      }
   }
}
