package com.taomee.seer2.app.scene
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.events.ActorEvent;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.lobby.effect.StageClickEffectPool;
   import com.taomee.seer2.app.robot.RobotActorManager;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.utils.DepthUtil;
   import flash.events.MouseEvent;
   import org.taomee.algo.AStar;
   import org.taomee.manager.EventManager;
   
   public class PathScene extends BaseScene
   {
       
      
      public function PathScene(param1:int)
      {
         super(param1);
         AStar.instance.maxTry = 10000;
      }
      
      override public function init() : void
      {
         super.init();
         ActorManager.initialize(this);
      }
      
      override protected function clearScene() : void
      {
         ActorManager.leaveMap();
         RobotActorManager.removeAllRobotActor();
         this.removeGroundMouseEventListener();
         super.clearScene();
      }
      
      override protected function onTick(param1:int) : void
      {
         super.onTick(param1);
         ActorManager.update();
         RobotActorManager.update();
         DepthUtil.sort(mapModel.content);
      }
      
      override protected function updateScene() : void
      {
         super.updateScene();
         AStar.instance.init(mapModel);
         ActorManager.enterMap();
         this.addGroundMouseEventListener();
      }
      
      override protected function syncToServer() : void
      {
         ActorManager.syncToServer();
         completeMap();
      }
      
      private function addGroundMouseEventListener() : void
      {
         mapModel.ground.addEventListener(MouseEvent.CLICK,this.onGroundClick);
      }
      
      private function removeGroundMouseEventListener() : void
      {
         mapModel.ground.removeEventListener(MouseEvent.CLICK,this.onGroundClick);
      }
      
      private function onGroundClick(param1:MouseEvent) : void
      {
         var _loc2_:int = param1.localX;
         var _loc3_:int = param1.localY;
         if(!ActorManager.getActor().isStop && Boolean(mapModel.canWalk(_loc2_,_loc3_)))
         {
            EventManager.dispatchEvent(new ActorEvent(ActorEvent.ACTOR_ONHOOK_WALK));
            ActorManager.getActor().walk(_loc2_,_loc3_);
            mapModel.content.addChild(StageClickEffectPool.checkOut(_loc2_,_loc3_));
         }
         if(FightManager.autoFightFlag == true)
         {
            FightManager.autoFightFlag = false;
         }
      }
   }
}
