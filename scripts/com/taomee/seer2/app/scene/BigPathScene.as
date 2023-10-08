package com.taomee.seer2.app.scene
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.actor.events.ActorEvent;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.gameRule.nono.Nono;
   import com.taomee.seer2.app.lobby.effect.StageClickEffectPool;
   import com.taomee.seer2.app.pet.FollowingPet;
   import com.taomee.seer2.app.robot.RobotActorManager;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.scene.BaseScene;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.EventManager;
   
   public class BigPathScene extends BaseScene
   {
       
      
      public function BigPathScene(param1:int)
      {
         super(param1);
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
         mapModel.gameMap.sortDepth(this.getActors());
      }
      
      override protected function updateScene() : void
      {
         super.updateScene();
         ActorManager.enterMap();
         this.addGroundMouseEventListener();
      }
      
      override protected function syncToServer() : void
      {
         ActorManager.syncToServer();
         completeMap();
      }
      
      private function getActors() : Array
      {
         var _loc2_:FollowingPet = null;
         var _loc3_:Nono = null;
         var _loc5_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc4_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         while(_loc5_ < _loc4_.length)
         {
            _loc1_.push(_loc4_[_loc5_]);
            _loc2_ = _loc4_[_loc5_].getFollowingPet();
            if(Boolean(_loc2_) && Boolean(_loc2_.visible))
            {
               _loc1_.push(_loc2_);
            }
            _loc3_ = _loc4_[_loc5_].getNono();
            if(Boolean(_loc3_) && _loc3_.isFollowing)
            {
               _loc1_.push(_loc3_);
            }
            _loc5_++;
         }
         _loc1_.push(ActorManager.getActor());
         _loc2_ = ActorManager.getActor().getFollowingPet();
         if(Boolean(_loc2_) && Boolean(_loc2_.visible))
         {
            _loc1_.push(_loc2_);
         }
         _loc3_ = ActorManager.getActor().getNono();
         if(Boolean(_loc3_) && _loc3_.isFollowing)
         {
            _loc1_.push(_loc3_);
         }
         return _loc1_;
      }
      
      private function addGroundMouseEventListener() : void
      {
         mapModel.ground.addEventListener(MouseEvent.CLICK,this.onGroundClick);
         ActorManager.getActor().addEventListener(MoveEvent.MOVE,this.onMove);
      }
      
      private function removeGroundMouseEventListener() : void
      {
         mapModel.ground.removeEventListener(MouseEvent.CLICK,this.onGroundClick);
         ActorManager.getActor().removeEventListener(MoveEvent.MOVE,this.onMove);
      }
      
      private function onMove(param1:MoveEvent) : void
      {
         var _loc2_:Point = param1.param;
         if(_loc2_)
         {
            this.moveScreen(_loc2_);
         }
      }
      
      private function moveScreen(param1:Point) : void
      {
         var _loc2_:Actor = ActorManager.getActor();
         var _loc3_:int = int(_loc2_.speed);
         var _loc4_:Number = -_loc3_ * param1.x;
         var _loc5_:Number = -_loc3_ * param1.y;
         var _loc6_:Sprite = mapModel.ground;
         var _loc7_:Sprite = mapModel.content;
         var _loc8_:Number = _loc6_.x - _loc4_;
         var _loc9_:Number = _loc6_.y - _loc5_;
         var _loc10_:Number = 960;
         var _loc11_:Number = 560;
         if(_loc8_ < 0 && _loc8_ > -(_loc6_.width - _loc10_) && _loc2_.x >= _loc10_ / 2 && _loc2_.x <= _loc6_.width - _loc10_ / 2)
         {
            _loc6_.x -= _loc4_;
            _loc7_.x -= _loc4_;
         }
         if(_loc9_ < 0 && _loc9_ > -(_loc6_.height - _loc11_) && _loc2_.y >= _loc11_ / 2 && _loc2_.y <= _loc6_.height - _loc11_ / 2)
         {
            _loc6_.y -= _loc5_;
            _loc7_.y -= _loc5_;
         }
         mapModel.gameMap.mapLayer.checkLoad(new Point(_loc2_.x,_loc2_.y));
      }
      
      private function onGroundClick(param1:MouseEvent) : void
      {
         var _loc2_:int = param1.localX;
         var _loc3_:int = param1.localY;
         if(!ActorManager.getActor().isStop)
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
