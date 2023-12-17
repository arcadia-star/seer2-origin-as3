package com.taomee.seer2.app.lobby.shootReward
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   
   public class MapShootSwapProcessor
   {
       
      
      private var _map:MapModel;
      
      private var _shootArea:MovieClip;
      
      public function MapShootSwapProcessor(param1:MapModel)
      {
         super();
         this._map = param1;
         this.start();
      }
      
      private function start() : void
      {
         this._shootArea = this._map.content["shootArea"];
         this._shootArea.gotoAndStop(1);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootReward);
      }
      
      private function onShootReward(param1:ShootEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         if(param1.info.userID == ActorManager.actorInfo.id && this._shootArea.hitTestPoint(param1.info.endPos.x,param1.info.endPos.y))
         {
            _loc2_ = MapShootSwapConfig.getLabel(param1.info.id);
            _loc3_ = MapShootSwapConfig.getSwapId(this._map.id,param1.info.id);
            if(Boolean(_loc2_) && Boolean(_loc3_))
            {
               this._shootArea.gotoAndStop(_loc2_);
               if(SwapManager.isSwapNumberMax(_loc3_))
               {
                  SwapManager.entrySwap(_loc3_);
               }
            }
         }
      }
      
      public function dispose() : void
      {
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootReward);
         this._shootArea = null;
         this._map = null;
      }
   }
}
