package com.taomee.seer2.core.map
{
   import com.taomee.seer2.core.map.grids.GameMap;
   import com.taomee.seer2.core.scene.BaseMapLoader;
   import com.taomee.seer2.core.scene.SwitchData;
   import flash.display.Sprite;
   
   public class BigMapModel extends MapModel
   {
       
      
      private var _front:Sprite;
      
      private var _far:Sprite;
      
      private var _ground:Sprite;
      
      public function BigMapModel(param1:SwitchData, param2:BaseMapLoader)
      {
         super(param1,param2);
         _gm = new GameMap(param2,_initPoint);
      }
      
      override public function init() : void
      {
         this.extract();
         this.config();
      }
      
      private function extract() : void
      {
         _gm.initMap();
         this._front = new Sprite();
         this._far = new Sprite();
         this._ground = new Sprite();
      }
      
      private function config() : void
      {
         _mapConfigurator.config();
      }
      
      override public function dispose() : void
      {
         _mapProcessor.dispose();
         _mapConfigurator.dispose();
         _gm.dispose();
         _gm = null;
         _isComplete = false;
      }
      
      override public function canWalk(param1:int, param2:int) : Boolean
      {
         return _gm.canWalk(param1,param2);
      }
      
      override public function get content() : Sprite
      {
         return _gm.buildLayer;
      }
      
      override public function get front() : Sprite
      {
         return this._front;
      }
      
      override public function get ground() : Sprite
      {
         return _gm.mapLayer;
      }
      
      override public function get far() : Sprite
      {
         return this._far;
      }
   }
}
