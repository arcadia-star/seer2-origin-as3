package com.taomee.seer2.app.pet
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.bubble.Bubble;
   import com.taomee.seer2.app.actor.bubble.BubblePool;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.app.home.data.TrainingPetInfo;
   import com.taomee.seer2.app.pet.bubble.BubbleController;
   import com.taomee.seer2.app.pet.bubble.IBubbleHost;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.entity.events.ActionEvent;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.taomee.utils.DisplayUtil;
   
   public class TrainingPet extends PathMobile implements IBubbleHost
   {
      
      private static const MAX_IDEL_INTERVAL:int = 250;
      
      private static const PERSONAL:String = "personal";
      
      private static const STAND_DOWN:String = "standDown";
      
      private static const PLAY_PERSONAL_INTERVAL:int = 800;
      
      private static const ACTOR_CLOSE_DISTANCE:int = 20;
       
      
      private var _bubble:Bubble;
      
      private var _petInfo:TrainingPetInfo;
      
      private var _ownerInfo:UserInfo;
      
      private var _idelInterval:int = 0;
      
      private var _maxIdelInterval:int;
      
      private var _actorTargetPoint:Point;
      
      private var _shadow:Sprite;
      
      private var _position:Point;
      
      private var _sloganVec:Vector.<String>;
      
      public function TrainingPet(param1:TrainingPetInfo, param2:UserInfo, param3:Point, param4:Vector.<String>)
      {
         super();
         this._petInfo = param1;
         this._ownerInfo = param2;
         this._position = param3;
         this._sloganVec = param4;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.initEventListener();
      }
      
      private function createChildren() : void
      {
         this.id = this._petInfo.id;
         this.buttonMode = true;
         this.mouseChildren = false;
         this.resourceUrl = URLUtil.getPetSwf(this._petInfo.resourceId);
         this.showLabel();
         this.addShadow();
      }
      
      private function addShadow() : void
      {
         this._shadow = UIManager.getSprite("UI_PetShadow");
         this._shadow.scaleX = this._shadow.scaleY = width / 40;
         addChildAt(this._shadow,0);
      }
      
      private function showLabel() : void
      {
         setLabelStyle(13395456,16777215);
         this.label = "Lv." + this._petInfo.level + " " + this._petInfo.name;
      }
      
      private function initEventListener() : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(MouseEvent.CLICK,this.onPetClick);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.setPostion(this._position);
         this.action = STAND_DOWN;
         this.generateMaxIdelInterval();
         BubbleController.getInstance().addBubbleHost(this);
      }
      
      public function showBubble() : void
      {
         this.checkInBubble();
         if(this._sloganVec)
         {
            this._bubble = BubblePool.checkOut();
            this._bubble.show(this.getSlogan());
            this._bubble.addEventListener(Event.CLOSE,this.onBubbleDisappear);
            this._bubble.y = -this.height;
            addChild(this._bubble);
         }
      }
      
      private function getSlogan() : String
      {
         var _loc1_:int = Math.random() * this._sloganVec.length;
         return this._sloganVec[_loc1_];
      }
      
      private function checkInBubble() : void
      {
         if(this._bubble != null)
         {
            this._bubble.removeEventListener(Event.CLOSE,this.onBubbleDisappear);
            BubblePool.checkIn(this._bubble);
            DisplayUtil.removeForParent(this._bubble);
            this._bubble = null;
         }
      }
      
      private function onBubbleDisappear(param1:Event) : void
      {
         this.checkInBubble();
      }
      
      public function get position() : Point
      {
         return this._position;
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         this.closeInteraction();
         this.actorMoveClose();
         param1.stopImmediatePropagation();
      }
      
      private function openInteraction() : void
      {
         this.mouseEnabled = true;
      }
      
      private function closeInteraction() : void
      {
         this.mouseEnabled = false;
      }
      
      override public function update() : void
      {
         this.checkIdleState();
         super.update();
      }
      
      private function checkIdleState() : void
      {
         if(this.action != PERSONAL)
         {
            ++this._idelInterval;
            if(this._idelInterval > this._maxIdelInterval)
            {
               this.playIdelAnimation();
               this._idelInterval = 0;
            }
         }
      }
      
      private function generateMaxIdelInterval() : void
      {
         this._maxIdelInterval = (MAX_IDEL_INTERVAL >> 1) + (MAX_IDEL_INTERVAL >> 1) * Math.random();
         this._idelInterval = 0;
      }
      
      private function playIdelAnimation() : void
      {
         addActionEventListener(ActionEvent.FINISHED,this.onActionEnd);
         this.action = PERSONAL;
      }
      
      private function onActionEnd(param1:ActionEvent) : void
      {
         removeActionEventListener(ActionEvent.FINISHED,this.onActionEnd);
         this.action = STAND_DOWN;
         this.generateMaxIdelInterval();
      }
      
      private function actorMoveClose() : void
      {
         var _loc2_:Actor = null;
         var _loc1_:Rectangle = new Rectangle(this.x - ACTOR_CLOSE_DISTANCE,this.y - ACTOR_CLOSE_DISTANCE,ACTOR_CLOSE_DISTANCE * 2,ACTOR_CLOSE_DISTANCE * 2);
         this._actorTargetPoint = this.generateWalkablePoint(_loc1_);
         if(this.isActorArrived(this._actorTargetPoint) == true)
         {
            this.actorCloseAction();
         }
         else
         {
            _loc2_ = ActorManager.getActor();
            _loc2_.addEventListener(MoveEvent.FINISHED,this.onActorReached);
            _loc2_.runToLocation(this._actorTargetPoint.x,this._actorTargetPoint.y);
         }
      }
      
      private function isActorArrived(param1:Point) : Boolean
      {
         var _loc2_:Actor = ActorManager.getActor();
         return _loc2_.isArrivedPosition(param1);
      }
      
      private function onActorReached(param1:MoveEvent) : void
      {
         if(this.isActorArrived(this._actorTargetPoint) == true)
         {
            this.actorCloseAction();
         }
         this.removeActorEventListener();
         this.openInteraction();
      }
      
      private function generateWalkablePoint(param1:Rectangle) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         do
         {
            _loc2_ = param1.x + Math.random() * param1.width;
            _loc3_ = param1.y + Math.random() * param1.height;
         }
         while(!SceneManager.active.mapModel.canWalk(_loc2_,_loc3_));
         
         return new Point(_loc2_,_loc3_);
      }
      
      private function removeActorEventListener() : void
      {
         ActorManager.getActor().removeEventListener(MoveEvent.FINISHED,this.onActorReached);
      }
      
      private function actorCloseAction() : void
      {
         if(this._ownerInfo.id == ActorManager.getActor().id)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("TrainingPetInfoPanel"),"正在打开精灵信息面板...",{
               "type":1,
               "petInfo":this._petInfo,
               "ownerInfo":this._ownerInfo
            });
         }
         else if(this.validateStartFight() == true)
         {
            this.startFight();
         }
      }
      
      private function startFight() : void
      {
         FightManager.startFightWithTrainMonster(id);
      }
      
      private function validateStartFight() : Boolean
      {
         if(HomeScene(SceneManager.active).homeInfo.leftFightCount == 0)
         {
            AlertManager.showAlert("今天的对战次数已用完");
            return false;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         BubbleController.getInstance().removeBubbleHost(this);
         this.removeActorEventListener();
         this.checkInBubble();
         this._sloganVec = null;
         super.dispose();
      }
   }
}
