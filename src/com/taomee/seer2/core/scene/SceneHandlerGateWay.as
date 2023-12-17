package com.taomee.seer2.core.scene
{
   public class SceneHandlerGateWay
   {
       
      
      private var _scene:BaseScene;
      
      private var _handlerVec:Vector.<ISceneHandler>;
      
      public function SceneHandlerGateWay(param1:BaseScene)
      {
         var _loc2_:ISceneHandler = null;
         super();
         this._scene = param1;
         this.initSceneHandler();
         for each(_loc2_ in this._handlerVec)
         {
            _loc2_.init(param1);
         }
      }
      
      protected function initSceneHandler() : void
      {
         this._handlerVec = new Vector.<ISceneHandler>();
      }
      
      public function addSceneHandler(param1:ISceneHandler) : void
      {
         if(this._scene)
         {
            param1.init(this._scene);
         }
         if(Boolean(this._scene.mapModel) && this._scene.mapModel.isComplete)
         {
            param1.onMapStart();
         }
         this._handlerVec.push(param1);
      }
      
      public function onMapStart() : void
      {
         var _loc1_:ISceneHandler = null;
         for each(_loc1_ in this._handlerVec)
         {
            _loc1_.onMapStart();
         }
      }
      
      public function onTick(param1:int) : void
      {
      }
      
      public function onMapEnd() : void
      {
         var _loc1_:ISceneHandler = null;
         for each(_loc1_ in this._handlerVec)
         {
            _loc1_.onMapEnd();
         }
      }
      
      public function disopse() : void
      {
         var _loc1_:ISceneHandler = null;
         for each(_loc1_ in this._handlerVec)
         {
            _loc1_.disopse();
         }
         this._handlerVec = null;
      }
   }
}
