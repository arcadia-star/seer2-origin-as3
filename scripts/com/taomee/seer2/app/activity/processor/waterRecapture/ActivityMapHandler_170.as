package com.taomee.seer2.app.activity.processor.waterRecapture
{
   import com.taomee.seer2.app.activity.data.ActivityPet;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ActivityMapHandler_170 extends WaterRecaptureMapHandler
   {
      
      private static const GUARD_ID:uint = 4;
       
      
      private var _isActivityInitialized:Boolean;
      
      private var _activityMonsterVec:Vector.<ActivityPet>;
      
      private var _teleport:Teleport;
      
      private var _teleportAniamtion:MovieClip;
      
      private var _massStone:Bitmap;
      
      public function ActivityMapHandler_170(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override public function process() : void
      {
         super.process();
         if(_isTimeOut)
         {
            return;
         }
         if(this._isActivityInitialized == false)
         {
            this._isActivityInitialized = true;
            this.processActivityMonster();
            this.processLayout();
         }
         this.refreshActivity();
      }
      
      private function processActivityMonster() : void
      {
         var _loc2_:ActivityPet = null;
         this.removeMapActivityMonster();
         this._activityMonsterVec = new Vector.<ActivityPet>();
         var _loc1_:uint = 0;
         while(_loc1_ < ACTIVITY_MONSTER_NUM)
         {
            _loc2_ = new ActivityPet(GUARD_ID);
            this._activityMonsterVec.push(_loc2_);
            MobileManager.addMobile(_loc2_,MobileType.ACTIVITY_MONSTER);
            _loc1_++;
         }
      }
      
      private function removeMapActivityMonster() : void
      {
         if(this._activityMonsterVec == null)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._activityMonsterVec.length)
         {
            MobileManager.removeMobileById(this._activityMonsterVec[_loc1_].id,MobileType.ACTIVITY_MONSTER);
            this._activityMonsterVec[_loc1_] = null;
            _loc1_++;
         }
         this._activityMonsterVec = null;
      }
      
      private function processLayout() : void
      {
         this.createTeleport();
         if(this._massStone == null)
         {
            this._massStone = new Bitmap();
         }
         this._massStone.bitmapData = SceneManager.active.mapModel.libManager.getBitmapData("massStones");
         this._massStone.x = 146;
         this._massStone.y = -2;
         SceneManager.active.mapModel.ground.addChild(this._massStone);
         this._teleportAniamtion = SceneManager.active.mapModel.libManager.getMovieClip("massStoneMC");
         this._teleportAniamtion.mouseChildren = false;
         this._teleportAniamtion.mouseEnabled = false;
         this._teleportAniamtion.x = 426.75;
         this._teleportAniamtion.y = 25.75;
         SceneManager.active.mapModel.content.addChild(this._teleportAniamtion);
      }
      
      private function createTeleport() : void
      {
         var _loc1_:XML = <teleport name="水源之心" pos="648,323" targetMapId="171"/>;
         this._teleport = new Teleport();
         this._teleport.setData(_loc1_);
         SceneManager.active.mapModel.content.addChild(this._teleport);
         this._teleport.addEventListener(MouseEvent.CLICK,this.onActivityTeleportClick,false,1);
      }
      
      private function onActivityTeleportClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(ActorManager.actorInfo.highestPetLevel < 6)
         {
            AlertManager.showAlert("你目前精灵等级太低");
            return;
         }
         (param1.target as Teleport).onMouseClick(param1);
      }
      
      private function removeMapLayout() : void
      {
         DisplayObjectUtil.removeFromParent(this._massStone);
         DisplayObjectUtil.removeFromParent(this._teleport);
         DisplayObjectUtil.removeFromParent(this._teleportAniamtion);
         this._massStone = null;
         this._teleport = null;
         this._teleportAniamtion = null;
      }
      
      private function refreshActivity() : void
      {
         this.showMapActivityAnimation();
      }
      
      private function showMapActivityAnimation() : void
      {
         var _loc1_:* = _activityProcessor.getActivityID() + "/1";
         playActivityAnimation(_loc1_);
      }
      
      override public function dispose() : void
      {
         this.removeMapLayout();
         this.removeMapActivityMonster();
         super.dispose();
      }
   }
}
