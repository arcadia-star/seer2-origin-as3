package com.taomee.seer2.app.entity.handler
{
   import com.taomee.seer2.core.scene.SceneManager;
   
   public class HandlerChangeScene extends HandlerEntityClick
   {
       
      
      private var _sceneType:int;
      
      private var _mapId:int;
      
      public function HandlerChangeScene()
      {
         super();
      }
      
      override public function initData(param1:XML) : void
      {
         var _loc2_:String = param1.toString();
         var _loc3_:Array = _loc2_.split(",");
         this._sceneType = int(_loc3_[0]);
         this._mapId = int(_loc3_[1]);
      }
      
      override protected function action() : void
      {
         SceneManager.changeScene(this._sceneType,this._mapId);
      }
   }
}
