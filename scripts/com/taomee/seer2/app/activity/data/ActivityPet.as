package com.taomee.seer2.app.activity.data
{
   import com.taomee.seer2.app.actor.bubble.Bubble;
   import com.taomee.seer2.app.actor.bubble.BubblePool;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.ActivityConfig;
   import com.taomee.seer2.app.pet.bubble.BubbleController;
   import com.taomee.seer2.app.pet.bubble.IBubbleHost;
   import com.taomee.seer2.app.pet.effect.SpawnedPetSupriseEffectPool;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.entity.constant.MoveStyle;
   import com.taomee.seer2.core.entity.events.ActionEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ActivityPet extends PathMobile implements IBubbleHost
   {
      
      protected static const MAX_IDEL_INTERVAL:int = 250;
      
      protected static const PERSONAL:String = "personal";
      
      protected static const STAND_DOWN:String = "standDown";
       
      
      private var _activityPetDefinition:com.taomee.seer2.app.activity.data.ActivityPetDefinition;
      
      private var _maxIdelTime:int;
      
      private var _idleTime:int;
      
      private var _supriseEffect:MovieClip;
      
      private var _bubble:Bubble;
      
      private var _shadow:Sprite;
      
      public function ActivityPet(param1:uint)
      {
         super();
         this._activityPetDefinition = ActivityConfig.getActivityPetDefinition(param1);
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.setResource();
         this.showLabel();
         this.addClickEventListener();
         this.hideAimation();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      protected function setResource() : void
      {
         this.buttonMode = true;
         this.mouseChildren = false;
         this.resourceUrl = URLUtil.getActivityMonsterSwf(this._activityPetDefinition.resId);
      }
      
      private function hideAimation() : void
      {
         (this.animation as DisplayObject).visible = false;
      }
      
      protected function showAnimation() : void
      {
         (this.animation as DisplayObject).visible = true;
         BubbleController.getInstance().addBubbleHost(this);
         this.generateMaxIdelTime();
         this.addShadow();
      }
      
      private function addShadow() : void
      {
         this._shadow = UIManager.getSprite("UI_PetShadow");
         addChildAt(this._shadow,0);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.present();
      }
      
      private function showLabel() : void
      {
         setLabelStyle(13395456,16777215);
         this.label = this._activityPetDefinition.name;
      }
      
      protected function addClickEventListener() : void
      {
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.stopAction();
         FightManager.startFightWithActivityBoss(this._activityPetDefinition.resId);
         param1.stopImmediatePropagation();
      }
      
      private function stopAction() : void
      {
         this.stand();
         this.playSupriseEffect();
      }
      
      private function playSupriseEffect() : void
      {
         this._supriseEffect = SpawnedPetSupriseEffectPool.checkout();
         this._supriseEffect.y = 0 - this.height + 20;
         this._supriseEffect.addEventListener(Event.ENTER_FRAME,this.onSuprisePlay);
         addChild(this._supriseEffect);
      }
      
      private function onSuprisePlay(param1:Event) : void
      {
         if(this._supriseEffect.currentFrame == this._supriseEffect.totalFrames)
         {
            this.recycleSupriseEffect();
         }
      }
      
      private function recycleSupriseEffect() : void
      {
         if(this._supriseEffect != null)
         {
            this._supriseEffect.removeEventListener(Event.ENTER_FRAME,this.onSuprisePlay);
            this._supriseEffect.stop();
            removeChild(this._supriseEffect);
            SpawnedPetSupriseEffectPool.checkin(this._supriseEffect);
            this._supriseEffect = null;
         }
      }
      
      protected function present() : void
      {
         var _loc1_:Rectangle = new Rectangle(0,0,LayerManager.root.width,LayerManager.root.height - 80);
         var _loc2_:Point = this.generateWalkablePoint(_loc1_);
         this.x = _loc2_.x;
         this.y = _loc2_.y;
         this.action = STAND_DOWN;
         this.showAnimation();
      }
      
      protected function generateWalkablePoint(param1:Rectangle) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         do
         {
            _loc2_ = param1.x + Math.random() * param1.width;
            _loc3_ = param1.y + Math.random() * param1.height;
         }
         while(SceneManager.active.mapModel.canWalk(_loc2_,_loc3_) == false);
         
         return new Point(_loc2_,_loc3_);
      }
      
      override public function update() : void
      {
         this.checkIdleState();
         super.update();
      }
      
      private function checkIdleState() : void
      {
         if(this._maxIdelTime > 0 && this.moveStyle == MoveStyle.STAND)
         {
            ++this._idleTime;
            if(this._idleTime > MAX_IDEL_INTERVAL)
            {
               this.playIdelAnimation();
               this._idleTime = 0;
            }
            else if(this._idleTime > this._maxIdelTime)
            {
               this.randomWalk();
            }
         }
      }
      
      private function playIdelAnimation() : void
      {
         addActionEventListener(ActionEvent.FINISHED,this.onActionEnd);
         this.action = PERSONAL;
      }
      
      private function onActionEnd(param1:ActionEvent) : void
      {
         removeActionEventListener(ActionEvent.FINISHED,this.onActionEnd);
         this.randomWalk();
      }
      
      private function randomWalk() : void
      {
         var _loc1_:Rectangle = new Rectangle(0,0,LayerManager.root.width,LayerManager.root.height - 80);
         var _loc2_:Point = this.generateWalkablePoint(_loc1_);
         walkToLocation(_loc2_.x,_loc2_.y);
         this.generateMaxIdelTime();
      }
      
      private function generateMaxIdelTime() : void
      {
         this._maxIdelTime = (MAX_IDEL_INTERVAL >> 1) + (MAX_IDEL_INTERVAL >> 1) * Math.random();
         this._idleTime = 0;
      }
      
      public function showBubble() : void
      {
         this.checkInBubble();
         this._bubble = BubblePool.checkOut();
         this._bubble.show(this.getSlogan());
         this._bubble.addEventListener(Event.CLOSE,this.onBubbleDisappear);
         this._bubble.y = -this.height;
         addChild(this._bubble);
      }
      
      private function getSlogan() : String
      {
         var _loc1_:Vector.<String> = this._activityPetDefinition.sloganVec;
         var _loc2_:int = Math.random() * _loc1_.length;
         return _loc1_[_loc2_];
      }
      
      private function onBubbleDisappear(param1:Event) : void
      {
         this.checkInBubble();
      }
      
      private function checkInBubble() : void
      {
         if(this._bubble != null)
         {
            this._bubble.removeEventListener(Event.CLOSE,this.onBubbleDisappear);
            BubblePool.checkIn(this._bubble);
            removeChild(this._bubble);
            this._bubble = null;
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClick);
         BubbleController.getInstance().removeBubbleHost(this);
         this.recycleSupriseEffect();
         this.checkInBubble();
         super.dispose();
      }
   }
}
