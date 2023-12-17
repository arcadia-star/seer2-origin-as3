package com.taomee.seer2.app.robot
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.ActorShadow;
   import com.taomee.seer2.app.actor.attach.ActorAttachType;
   import com.taomee.seer2.app.actor.attach.ActorTrainerLevel;
   import com.taomee.seer2.app.actor.attach.ChatActorAttach;
   import com.taomee.seer2.app.actor.attach.IActorAttach;
   import com.taomee.seer2.app.actor.attach.ShootActorAttach;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.equip.ActorEquipHelper;
   import com.taomee.seer2.app.actor.events.UserInfoEvent;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.item.MedalItemDefinition;
   import com.taomee.seer2.app.gameRule.nono.Nono;
   import com.taomee.seer2.app.gameRule.nono.NonoInfoEvent;
   import com.taomee.seer2.app.gameRule.nono.NonoUtil;
   import com.taomee.seer2.app.gameRule.nono.core.NonoInfo;
   import com.taomee.seer2.app.pet.FollowingPet;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.shoot.ShootHitEffect;
   import com.taomee.seer2.app.utils.ColorConstants;
   import com.taomee.seer2.app.vip.data.VipInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.LabelRenderer;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.taomee.utils.Tick;
   
   public class RobotActor extends Actor
   {
      
      private static const step:uint = 30;
       
      
      private var range:uint = 200;
      
      private var walking:Boolean = false;
      
      private var _autoSearchEnable:Boolean = false;
      
      public function RobotActor(param1:UserInfo)
      {
         super(param1);
      }
      
      override protected function initialize() : void
      {
         this.id = _userInfo.id;
         setPostion(new Point(_userInfo.x,_userInfo.y));
         this.updateTrainerLevel();
         this.updateNick(_userInfo.nick);
         this.updateMedal(_userInfo.medalId);
         this.initLayer();
         this.initShadow();
         this.initActorEquip();
         this.initEventListener();
         this.initNono();
         this.initFollowingPet();
         this.initActorAttach();
      }
      
      private function initLayer() : void
      {
         _normalLayer = new Sprite();
         addChild(_normalLayer);
         _attachLayer = new Sprite();
         addChild(_attachLayer);
      }
      
      private function tweenDown() : void
      {
         if(this.animation)
         {
            TweenMax.to(this.animation,1.5,{
               "bezier":[{"y":-45}],
               "onComplete":this.tweenUp
            });
         }
      }
      
      private function tweenUp() : void
      {
         if(this.animation)
         {
            TweenMax.to(this.animation,1.5,{
               "bezier":[{"y":-55}],
               "onComplete":this.tweenDown
            });
         }
      }
      
      private function tweenShadowBig() : void
      {
         TweenMax.to(_shadow.animation,1.5,{
            "scaleX":1.1,
            "scaleY":1.1,
            "onComplete":this.tweenShadowsmall
         });
      }
      
      private function tweenShadowsmall() : void
      {
         TweenMax.to(_shadow.animation,1.5,{
            "scaleX":0.9,
            "scaleY":0.9,
            "onComplete":this.tweenShadowBig
         });
      }
      
      private function updateVisible() : void
      {
         var _loc1_:Mobile = null;
         this.visible = _isShow;
         for each(_loc1_ in getCarriedMobileVec())
         {
            _loc1_.visible = _isShow;
         }
         if(_isShow)
         {
            _normalLayer.visible = _isShowNoraml;
            this.updateTransform();
            this.updateBlockFollowingPet();
            this.updateBlockFollowingNono();
         }
      }
      
      private function updateTransform() : void
      {
         if(_isTransform)
         {
            this.visible = false;
            _transformMobile.visible = true;
         }
         else
         {
            this.visible = true;
         }
      }
      
      private function updateBlockFollowingPet() : void
      {
         if(_followingPet)
         {
            _followingPet.visible = !_isBlockFollowingPet;
         }
      }
      
      private function updateBlockFollowingNono() : void
      {
         if(_followingNono)
         {
            _followingNono.visible = !_isBlockFollowingNono;
         }
      }
      
      private function layoutNormal() : void
      {
         _normalLayer.addChild(_shadow);
         _normalLayer.addChild(DisplayObject(this.animation));
         var _loc1_:int = -5;
         if(_titleImage != null)
         {
            _titleImage.x = -1 * (_titleImage.width >> 1);
            _titleImage.y = 0;
            _normalLayer.addChild(_titleImage);
         }
         if(_nickImage != null)
         {
            _nickImage.x = -1 * (_nickImage.width >> 1);
            _nickImage.y = !!_titleImage ? _titleImage.height : 0;
            _nickImage.y += _loc1_;
            _normalLayer.addChild(_nickImage);
            if(_userInfo.trainerLevel > 0)
            {
               _nickImage.x += _trainerLevel.width >> 1;
               _trainerLevel.x = _nickImage.x - _trainerLevel.width;
               _trainerLevel.y = _nickImage.y + 4;
               _normalLayer.addChild(_trainerLevel);
            }
            else
            {
               DisplayObjectUtil.removeFromParent(_trainerLevel);
            }
         }
      }
      
      private function updateTrainerLevel() : void
      {
         _trainerLevel = new ActorTrainerLevel();
         _trainerLevel.setData(_userInfo.trainerLevel);
      }
      
      override public function updateNick(param1:String) : void
      {
         _isInvalidate = true;
         _userInfo.nick = param1;
         DisplayObjectUtil.removeFromParent(_nickImage);
         if(_userInfo.vipInfo.isVip())
         {
            _nickImage = LabelRenderer.getLabelImage(param1,ColorConstants.VIP_TEXT_COLOR,3342336);
         }
         else
         {
            _nickImage = LabelRenderer.getLabelImage(param1,0,16777215);
         }
      }
      
      override public function updateMedal(param1:uint) : void
      {
         var _loc3_:String = null;
         _isInvalidate = true;
         _userInfo.medalId = param1;
         DisplayObjectUtil.removeFromParent(_titleImage);
         _titleImage = null;
         var _loc2_:MedalItemDefinition = ItemConfig.getMedalDefinition(_userInfo.medalId);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.title;
            _titleImage = LabelRenderer.getLabelImage(_loc3_,5635874,0);
         }
      }
      
      private function initShadow() : void
      {
         _shadow = new ActorShadow();
         this.updateShadow();
      }
      
      private function updateShadow() : void
      {
         _isInvalidate = true;
         _shadow.updateLabel(_userInfo);
      }
      
      private function disposeShadow() : void
      {
         _shadow.dispose();
         _shadow = null;
      }
      
      private function initActorEquip() : void
      {
         _actorEquip = new ActorEquipHelper(this);
         this.animation = _actorEquip.getAnimation();
         _actorEquip.initEquip();
      }
      
      override public function addEquipByReferenceId(param1:int) : void
      {
         _actorEquip.addEquip(param1);
      }
      
      override public function removeEquipByReferenceId(param1:int) : void
      {
         _actorEquip.removeEquip(param1);
      }
      
      private function onEquipUpdate(param1:UserInfoEvent) : void
      {
         _actorEquip.updateEquipVec(_userInfo.equipVec);
      }
      
      override public function show() : void
      {
         this.isShow = true;
      }
      
      override public function hide() : void
      {
         this.isShow = false;
      }
      
      override public function set isShowNormal(param1:Boolean) : void
      {
         _isShowNoraml = param1;
         _isInvalidate = true;
      }
      
      override public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
         _isInvalidate = true;
      }
      
      override public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      override public function set isStop(param1:Boolean) : void
      {
         _isStop = param1;
      }
      
      override public function get isStop() : Boolean
      {
         return !_isShow || _isStop;
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return _hotObject.hitTestPoint(param1,param2,param3);
      }
      
      override public function walk(param1:Number, param2:Number) : void
      {
         runToLocation(param1,param2);
      }
      
      override public function talk(param1:String) : void
      {
         this.getActorAttach(ActorAttachType.CHAT).excute(param1);
      }
      
      override public function addShootEffect(param1:ShootHitEffect) : void
      {
         this.getActorAttach(ActorAttachType.SHOOT).excute({
            "effect":param1,
            "isAdd":true
         });
      }
      
      override public function removeShootEffect(param1:ShootHitEffect) : void
      {
         this.getActorAttach(ActorAttachType.SHOOT).excute({
            "effect":param1,
            "isAdd":false
         });
      }
      
      private function initActorAttach() : void
      {
         _acttachVec = new Vector.<IActorAttach>();
         var _loc1_:ChatActorAttach = new ChatActorAttach();
         _loc1_.attach(this);
         _acttachVec.push(_loc1_);
         var _loc2_:ShootActorAttach = new ShootActorAttach();
         _loc2_.attach(this);
         _acttachVec.push(_loc2_);
      }
      
      private function getActorAttach(param1:String) : IActorAttach
      {
         var _loc2_:IActorAttach = null;
         for each(_loc2_ in _acttachVec)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function disposeActorAttach() : void
      {
         var _loc1_:IActorAttach = null;
         for each(_loc1_ in _acttachVec)
         {
            _loc1_.detach();
         }
         _acttachVec = null;
      }
      
      public function set autoSearchEnable(param1:Boolean) : void
      {
         this._autoSearchEnable = param1;
      }
      
      private function initEventListener() : void
      {
         this.mouseEnabled = false;
         _hotObject = this.animation as Sprite;
         _hotObject.buttonMode = true;
         _hotObject.mouseChildren = false;
         _hotObject.mouseEnabled = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         _hotObject.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         _userInfo.addEventListener(UserInfoEvent.FOLLOWING_PET_UPDATE,this.onFollowingPetUpdate);
         _userInfo.addEventListener(UserInfoEvent.EQUIP_UPDATE,this.onEquipUpdate);
         _userInfo.addEventListener(UserInfoEvent.TRAINER_SCORE_UPDATE,this.onTrainerScoreUpdate);
         _userInfo.vipInfo.addEventListener(VipInfo.VIP_UPDATE,this.onVipUpdate);
         _userInfo.addEventListener(NonoInfoEvent.NONOINFO_UPDATE,this.updateNonoInfo);
         NonoUtil.addEventListener(NonoInfoEvent.NONO_FLAG_CHANGE,this.updateNonoInfo);
         PetInfoManager.addEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE,this.onPetPropertiesChange);
         Tick.instance.addRender(this.checkRange,1000);
         addEventListener(MoveEvent.FINISHED,this.onActorMoveFinished);
         addEventListener(MoveEvent.START,this.onActorMoveStart);
      }
      
      private function disposeEventListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         _hotObject.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         _userInfo.removeEventListener(UserInfoEvent.FOLLOWING_PET_UPDATE,this.onFollowingPetUpdate);
         _userInfo.removeEventListener(UserInfoEvent.EQUIP_UPDATE,this.onEquipUpdate);
         _userInfo.removeEventListener(UserInfoEvent.TRAINER_SCORE_UPDATE,this.onTrainerScoreUpdate);
         _userInfo.vipInfo.removeEventListener(VipInfo.VIP_UPDATE,this.onVipUpdate);
         _userInfo.removeEventListener(NonoInfoEvent.NONOINFO_UPDATE,this.updateNonoInfo);
         NonoUtil.removeEventListener(NonoInfoEvent.NONO_FLAG_CHANGE,this.updateNonoInfo);
         PetInfoManager.removeEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE,this.onPetPropertiesChange);
         Tick.instance.removeRender(this.checkRange);
         removeEventListener(MoveEvent.FINISHED,this.onActorMoveFinished);
         removeEventListener(MoveEvent.START,this.onActorMoveStart);
      }
      
      private function onActorMoveFinished(param1:MoveEvent) : void
      {
         this.walking = false;
      }
      
      private function onActorMoveStart(param1:MoveEvent) : void
      {
         this.walking = true;
      }
      
      private function checkRange(param1:uint) : void
      {
         if(this._autoSearchEnable)
         {
            if((ActorManager.getActor().animation as DisplayObject).hitTestObject(this.animation as DisplayObject))
            {
               this.stand();
               this.walking = false;
               return;
            }
            if(Point.distance(ActorManager.getActor().pos,this.pos) < this.range)
            {
               if(this.walking == false)
               {
                  this.walk(ActorManager.getActor().pos.x,ActorManager.getActor().pos.y);
               }
            }
         }
      }
      
      private function randomWalk() : void
      {
         var _loc1_:Rectangle = new Rectangle(0,0,LayerManager.root.width,LayerManager.root.height - 80);
         var _loc2_:Point = this.generateWalkablePoint(_loc1_);
         this.walk(_loc2_.x,_loc2_.y);
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
         while(SceneManager.active.mapModel.canWalk(_loc2_,_loc3_) == false);
         
         return new Point(_loc2_,_loc3_);
      }
      
      override public function removeMouseEvent() : void
      {
         _hotObject.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onPetPropertiesChange(param1:PetInfoEvent) : void
      {
         var _loc2_:PetInfo = param1.info;
         if(Boolean(_userInfo.followingPetInfo) && _loc2_.catchTime == _userInfo.followingPetInfo.catchTime)
         {
            _userInfo.setFollowingPetInfo(_loc2_);
         }
      }
      
      private function onTrainerScoreUpdate(param1:UserInfoEvent) : void
      {
         _trainerLevel.setData(_userInfo.trainerLevel);
         _isInvalidate = true;
      }
      
      private function onVipUpdate(param1:Event) : void
      {
         this.updateNick(_userInfo.nick);
         this.updateNono();
         this.updateShadow();
      }
      
      private function updateNono() : void
      {
         if(_followingNono == null)
         {
            _followingNono = new Nono();
         }
         _followingNono.clearView();
         _followingNono.updateView(_userInfo);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      override public function startTransform(param1:int, param2:String = "pet") : void
      {
         if(_isTransform)
         {
            if(param1 == _transformMobile.id)
            {
               return;
            }
            this.stopTransform();
         }
         _transformMobile = new Mobile();
         _transformMobile.id = param1;
         if(param2 == PET)
         {
            _transformMobile.resourceUrl = URLUtil.getPetSwf(param1);
         }
         else
         {
            _transformMobile.resourceUrl = URLUtil.getActivityActorSwf(param1);
         }
         this.addCarriedMobile(_transformMobile);
         this.isTransform = true;
      }
      
      override public function stopTransform() : void
      {
         if(_isTransform)
         {
            this.removeCarriedMobile(_transformMobile);
            _transformMobile.dispose();
            _transformMobile = null;
            this.isTransform = false;
         }
      }
      
      private function set isTransform(param1:Boolean) : void
      {
         _isTransform = param1;
         _isInvalidate = true;
      }
      
      private function initNono() : void
      {
         _followingNono = new Nono();
         this.updateNonoInfo(null);
      }
      
      private function updateNonoInfo(param1:NonoInfoEvent = null) : void
      {
         var _loc2_:NonoInfo = _userInfo.getNonoInfo();
         if(_loc2_.isHava)
         {
            if(_loc2_.isFollowing)
            {
               if(_followingNono.isCarried() == false)
               {
                  this.addCarriedMobile(_followingNono,_followingNono.followDistance);
               }
            }
            else
            {
               this.removeCarriedMobile(_followingNono);
            }
            _followingNono.updateView(_userInfo);
         }
      }
      
      override public function set blockNoNo(param1:Boolean) : void
      {
         _isBlockFollowingNono = param1;
         _isInvalidate = true;
      }
      
      private function disposeFollowingNono() : void
      {
         this.removeCarriedMobile(_followingNono);
         _followingNono.dispose();
         _followingNono = null;
      }
      
      override public function getNono() : Nono
      {
         return _followingNono;
      }
      
      override public function addDogz(param1:Boolean, param2:uint) : void
      {
         if(param1 == false)
         {
            (this.animation as Sprite).y = -50;
            this.checkAddFloat(param2);
         }
         else
         {
            this.checkAddFloat(param2,true);
         }
         _actorEquip.hidHandAndFoot();
         this.runSpeed = DOGZ_RUN_SPEED;
      }
      
      override public function removeDogz(param1:Boolean, param2:uint) : void
      {
         this.checkRemoveFloat(param2);
         (this.animation as Sprite).y = 0;
         _actorEquip.showHandAndFoot();
         this.runSpeed = NOMARL_RUN_SPEED;
      }
      
      override public function get isDogz() : Boolean
      {
         return _isDogz;
      }
      
      override public function set isDogz(param1:Boolean) : void
      {
         _isDogz = param1;
      }
      
      override public function get curtDogzId() : int
      {
         return _curDogId;
      }
      
      override public function set curtDogzId(param1:int) : void
      {
         _curDogId = param1;
      }
      
      private function checkAddFloat(param1:uint, param2:Boolean = false) : void
      {
         var id:uint = param1;
         var isEuipAction:Boolean = param2;
         if(_floatList.indexOf(id) != -1)
         {
            if(isEuipAction == true)
            {
               this.isStop = true;
               TweenMax.to(this.animation,2,{
                  "bezier":[{"y":-50}],
                  "orientToBezier":true,
                  "ease":Back.easeIn,
                  "onComplete":function():void
                  {
                     isStop = false;
                     tweenDown();
                  }
               });
            }
            else
            {
               this.tweenDown();
            }
         }
         else
         {
            (this.animation as Sprite).y = -50;
         }
      }
      
      private function checkRemoveFloat(param1:uint) : void
      {
         if(_floatList.indexOf(param1) != -1)
         {
            TweenMax.killChildTweensOf(_normalLayer);
         }
      }
      
      private function initFollowingPet() : void
      {
         _followingPet = new FollowingPet();
         this.onFollowingPetUpdate(null);
      }
      
      private function onFollowingPetUpdate(param1:UserInfoEvent) : void
      {
         if(_userInfo.followingPetInfo)
         {
            if(!_followingPet.isCarried())
            {
               this.addCarriedMobile(_followingPet,_followingPet.followDistance);
            }
         }
         else
         {
            this.removeCarriedMobile(_followingPet);
         }
         _followingPet.updateView(_userInfo);
      }
      
      private function disposeFollowingPet() : void
      {
         this.removeCarriedMobile(_followingPet);
         _followingPet.dispose();
         _followingPet = null;
      }
      
      override public function set blockFollowingPet(param1:Boolean) : void
      {
         _isBlockFollowingPet = param1;
         _isInvalidate = true;
      }
      
      override public function hasFollowingPet() : Boolean
      {
         return _userInfo.followingPetInfo != null;
      }
      
      override public function getFollowingPet() : FollowingPet
      {
         return _followingPet;
      }
      
      private function onAddToStage(param1:Event) : void
      {
         var _loc2_:Mobile = null;
         for each(_loc2_ in getCarriedMobileVec())
         {
            this.parent.addChild(_loc2_);
         }
      }
      
      private function onRemoveFromStage(param1:Event) : void
      {
         var _loc2_:Mobile = null;
         for each(_loc2_ in getCarriedMobileVec())
         {
            DisplayObjectUtil.removeFromParent(_loc2_);
         }
      }
      
      override public function addCarriedMobile(param1:Mobile, param2:int = 0) : void
      {
         if(this.parent)
         {
            this.parent.addChild(param1);
         }
         super.addCarriedMobile(param1,param2);
      }
      
      override public function removeCarriedMobile(param1:Mobile) : void
      {
         DisplayObjectUtil.removeFromParent(param1);
         super.removeCarriedMobile(param1);
      }
      
      override public function dispose() : void
      {
         if(!_isDisposed)
         {
            _isDisposed = true;
            this.stopTransform();
            this.disposeEventListener();
            this.disposeFollowingPet();
            this.disposeFollowingNono();
            this.disposeActorAttach();
            this.disposeShadow();
            super.dispose();
         }
      }
      
      override public function getInfo() : UserInfo
      {
         return _userInfo;
      }
   }
}
