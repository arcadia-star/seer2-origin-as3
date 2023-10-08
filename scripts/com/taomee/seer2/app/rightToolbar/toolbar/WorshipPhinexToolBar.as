package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   
   public class WorshipPhinexToolBar extends RightToolbar
   {
       
      
      private var maps:Array;
      
      private var map:Array;
      
      public function WorshipPhinexToolBar()
      {
         this.maps = [90,124,142,141,160,204,202,211,230,261,281,302];
         super();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         this.getMapId();
      }
      
      private function getMapId() : void
      {
         var _loc1_:int = int(SceneManager.active.mapID);
         this.map = this.maps.concat();
         var _loc2_:int = this.map.indexOf(_loc1_);
         if(_loc2_ != -1)
         {
            this.map.splice(_loc2_,1);
         }
         SceneManager.changeScene(SceneType.LOBBY,this.getRandomId());
      }
      
      private function getRandomId() : int
      {
         return int(this.map[int(Math.random() * this.map.length)]);
      }
   }
}
