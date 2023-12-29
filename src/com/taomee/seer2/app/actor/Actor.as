package com.taomee.seer2.app.actor
{
   import com.greensock.TweenMax;
   import com.greensock.TweenNano;
   import com.greensock.easing.Back;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.attach.ActorAttachType;
   import com.taomee.seer2.app.actor.attach.ActorTrainerLevel;
   import com.taomee.seer2.app.actor.attach.ChatActorAttach;
   import com.taomee.seer2.app.actor.attach.IActorAttach;
   import com.taomee.seer2.app.actor.attach.ShootActorAttach;
   import com.taomee.seer2.app.actor.constant.EquipSlot;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.equip.ActorEquipHelper;
   import com.taomee.seer2.app.actor.events.UserInfoEvent;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.PetRideShopConfig;
   import com.taomee.seer2.app.config.item.MedalItemDefinition;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.gameRule.nono.Nono;
   import com.taomee.seer2.app.gameRule.nono.NonoInfoEvent;
   import com.taomee.seer2.app.gameRule.nono.NonoUtil;
   import com.taomee.seer2.app.gameRule.nono.core.NonoInfo;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.morphSystem.MorphManager;
   import com.taomee.seer2.app.morphSystem.MorphSwitch;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.FollowingPet;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.activity.decoration.DecorationManager;
   import com.taomee.seer2.app.processor.map.MapProcessor_3845;
   import com.taomee.seer2.app.processor.map.MapProcessor_3852;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shoot.ShootHitEffect;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ColorConstants;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.data.VipInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.LabelRenderer;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class Actor extends PathMobile
   {
      
      public static const PET:String = "pet";
      
      public static const CHARACTER:String = "character";
      
      private static const DAY_LIST:Array = [5068];
      
      private static const FOR_LIST:Array = [250151];
      
      private static const CD_TIME:int = 300;
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3918,3915]);
      
      private static const CHANGE_INDEX:Vector.<int> = Vector.<int>([39,40,41,42,43]);
      
      private static const WIN_VAL:Vector.<int> = Vector.<int>([0,1,1,1,5,3]);
       
      
      private const TEAM_ID:Vector.<int> = Vector.<int>([603030,603031]);
      
      protected var _userInfo:UserInfo;
      
      protected var _actorEquip:ActorEquipHelper;
      
      protected var _nickImage:Bitmap;
      
      protected var _titleImage:Bitmap;
      
      protected var _trainerLevel:ActorTrainerLevel;
      
      protected var _shadow:ActorShadow;
      
      protected var _hotObject:Sprite;
      
      protected var _followingPet:FollowingPet;
      
      protected var _followingNono:Nono;
      
      protected var _transformMobile:Mobile;
      
      protected var _isStop:Boolean = false;
      
      protected var _isShow:Boolean = true;
      
      protected var _isShowNoraml:Boolean = true;
      
      protected var _isInvalidate:Boolean = true;
      
      protected var _isTransform:Boolean = false;
      
      protected var _isBlockFollowingPet:Boolean;
      
      protected var _isBlockFollowingNono:Boolean;
      
      protected var _acttachVec:Vector.<IActorAttach>;
      
      protected var _normalLayer:Sprite;
      
      protected var _nickTitleLayer:Sprite;
      
      protected var _attachLayer:Sprite;
      
      protected var _isDisposed:Boolean = false;
      
      protected var _isDogz:Boolean = false;
      
      protected var headIcon:DisplayObject;
      
      protected var taoLeJieIcon:DisplayObject;
      
      protected var _curDogId:int = 0;
      
      protected const DOGZ_RUN_SPEED:uint = 25;
      
      protected const NOMARL_RUN_SPEED:uint = 20;
      
      protected var _isFloat:Boolean = true;
      
      protected var _morphMC:MovieClip;
      
      protected var _decorationMC:MovieClip;
      
      private var _yearVipIcon:MovieClip;
      
      private var _yearIconClassName:String = "YearVipIcon";
      
      private var _eggIcon:MovieClip;
      
      private var _famouseMC:MovieClip;
      
      protected var _floatList:Array;
      
      private var nickContainer:Sprite;
      
      private var _taoLeJieHead:IconDisplayer;
      
      private var _headIcon1:IconDisplayer;
      
      private const ICON_NAME1:Array = ["team0","team1","team2"];
      
      private var _headIcon:IconDisplayer;
      
      private var _timeUI:MovieClip;
      
      private var _timeTxt:TextField;
      
      private var _bar:MovieClip;
      
      private var _haveAward:MovieClip;
      
      private var _leaveTime:int;
      
      private var _type:int;
      
      private var _rabbitHead:IconDisplayer;
      
      private var _goPanel:MovieClip;
      
      private var _transTimeUI:MovieClip;
      
      private var _transTimeTxt:TextField;
      
      private var _transTimeBar:MovieClip;
      
      private var _transTime:int = 0;
      
      private const RABBIT_SWAP_LIST:Array = [4220,4221];
      
      private const RABBIT_DAY_LIST:Array = [5204,5205];
      
      private const TRANSTOTALTIME:int = 300;
      
      public function Actor(param1:UserInfo)
      {
         this._floatList = [100324,100377,100393,100394,100419,100439,100464,100512,100582,100568,100569,100595,100690];
         super();
         this._userInfo = param1;
         this.initialize();
      }
      
      public function get transformMobile() : Mobile
      {
         return this._transformMobile;
      }
      
      public function addHeadIcon(param1:DisplayObject) : void
      {
         if(this.headIcon)
         {
            DisplayObjectUtil.removeFromParent(this.headIcon);
         }
         this.headIcon = param1;
         this.headIcon.y = -130;
         this.headIcon.x -= this.headIcon.width / 2;
         if(this.animation)
         {
            DisplayObjectContainer(this.animation).addChild(this.headIcon);
         }
      }
      
      public function get HeadIcon() : DisplayObject
      {
         return this.headIcon;
      }
      
      protected function initialize() : void
      {
         this.id = this._userInfo.id;
         this.nickContainer = new Sprite();
         setPostion(new Point(this._userInfo.x,this._userInfo.y));
         this.updateTrainerLevel();
         this.updateNick(this._userInfo.nick);
         this.updateMedal(this._userInfo.medalId);
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
         this._normalLayer = new Sprite();
         addChild(this._normalLayer);
         this._nickTitleLayer = new Sprite();
         addChild(this._nickTitleLayer);
         this._attachLayer = new Sprite();
         addChild(this._attachLayer);
      }
      
      override public function update() : void
      {
         super.update();
         if(this._shadow)
         {
            this._shadow.update();
         }
         if(this._isInvalidate)
         {
            this._isInvalidate = false;
            this.updateVisible();
            this.layoutNormal();
         }
      }
      
      private function tweenDown() : void
      {
         if(Boolean(this.animation) && this._isFloat)
         {
            TweenMax.to(this.animation,1.5,{
               "bezier":[{"y":-45}],
               "onComplete":this.tweenUp
            });
         }
      }
      
      private function tweenUp() : void
      {
         if(Boolean(this.animation) && this._isFloat)
         {
            TweenMax.to(this.animation,1.5,{
               "bezier":[{"y":-55}],
               "onComplete":this.tweenDown
            });
         }
      }
      
      private function tweenShadowBig() : void
      {
         TweenMax.to(this._shadow.animation,1.5,{
            "scaleX":1.1,
            "scaleY":1.1,
            "onComplete":this.tweenShadowsmall
         });
      }
      
      private function tweenShadowsmall() : void
      {
         TweenMax.to(this._shadow.animation,1.5,{
            "scaleX":0.9,
            "scaleY":0.9,
            "onComplete":this.tweenShadowBig
         });
      }
      
      private function updateVisible() : void
      {
         var _loc1_:Mobile = null;
         this.visible = this._isShow;
         for each(_loc1_ in getCarriedMobileVec())
         {
            _loc1_.visible = this._isShow;
         }
         if(this._isShow)
         {
            this._normalLayer.visible = this._isShowNoraml;
            this._nickTitleLayer.visible = this._isShowNoraml;
            this.updateTransform();
            this.updateBlockFollowingPet();
            this.updateBlockFollowingNono();
         }
      }
      
      private function updateTransform() : void
      {
         if(this._isTransform)
         {
            this._normalLayer.visible = false;
            this._nickTitleLayer.visible = true;
            this._transformMobile.visible = true;
         }
         else
         {
            this._normalLayer.visible = true;
         }
      }
      
      private function updateBlockFollowingPet() : void
      {
         if(this._followingPet)
         {
            this._followingPet.visible = !this._isBlockFollowingPet;
         }
      }
      
      private function updateBlockFollowingNono() : void
      {
         if(this._followingNono)
         {
            this._followingNono.visible = !this._isBlockFollowingNono;
         }
      }
      
      private function layoutNormal() : void
      {
         this._normalLayer.addChild(this._shadow);
         this._normalLayer.addChild(DisplayObject(this.animation));
         var _loc1_:int = -5;
         if(this._titleImage != null)
         {
            this._titleImage.x = -1 * (this._titleImage.width >> 1);
            this._titleImage.y = 0;
            this._nickTitleLayer.addChild(this._titleImage);
         }
         if(this._nickImage != null)
         {
            this._nickImage.x = -1 * (this._nickImage.width >> 1);
            this._nickImage.y = !!this._titleImage ? this._titleImage.height : 0;
            this._nickImage.y += _loc1_;
            this._nickTitleLayer.addChild(this._nickImage);
            if(this._userInfo.trainerLevel > 0)
            {
               this._nickImage.x += this._trainerLevel.width >> 1;
               this._trainerLevel.x = this._nickImage.x - this._trainerLevel.width;
               this._trainerLevel.y = this._nickImage.y + 4;
               this._nickTitleLayer.addChild(this._trainerLevel);
            }
            else
            {
               DisplayObjectUtil.removeFromParent(this._trainerLevel);
            }
         }
         this.initDecoration();
         this.initYearVipIcon();
         this.initFamousMark();
         this.updateMiKaChangeAct();
         if(DateUtil.isInTime(new Date(2015,8,18,0,0,0),new Date(2015,8,25,23,59,59)))
         {
            this.transformAsRabbit(0);
         }
         if(this.isInTaoLeJieTime())
         {
            this.updateTaoLeJieAct();
         }
      }
      
      private function isInTaoLeJieTime() : Boolean
      {
         return DateUtil.isInTime(new Date(2014,10,22),new Date(2014,10,23,23,59,59));
      }
      
      public function setTaoLeJieData(param1:uint) : void
      {
         this._userInfo.activityData[16] = param1;
         if(this.isInTaoLeJieTime())
         {
            this.updateTaoLeJieAct();
         }
      }
      
      private function updateTaoLeJieAct() : void
      {
         if(this._userInfo.activityData.length < 17)
         {
            return;
         }
         var _loc1_:int = int(this._userInfo.activityData[16]);
         if(_loc1_ == 2)
         {
            if(this._taoLeJieHead)
            {
               DisplayUtil.removeForParent(this._taoLeJieHead);
               this._taoLeJieHead = null;
            }
         }
         else if(_loc1_ == 1)
         {
            this._taoLeJieHead = new IconDisplayer();
            this._taoLeJieHead.setIconUrl(URLUtil.getActivityAnimation("TaoLeJieBubble"),this.onTaoLeJieComplete);
         }
      }
      
      private function onTaoLeJieComplete() : void
      {
         this.addTaoLeJieHeadIcon(this._taoLeJieHead);
      }
      
      public function addTaoLeJieHeadIcon(param1:DisplayObject) : void
      {
         if(this.taoLeJieIcon)
         {
            DisplayObjectUtil.removeFromParent(this.taoLeJieIcon);
         }
         this.taoLeJieIcon = param1;
         this.taoLeJieIcon.y = -110;
         this.taoLeJieIcon.x -= this.taoLeJieIcon.width / 2;
         if(this.animation)
         {
            DisplayObjectContainer(this.animation).addChild(this.taoLeJieIcon);
         }
      }
      
      public function updateTeamIcon1() : void
      {
         if(this._userInfo.activityData.length < 20)
         {
            return;
         }
         var _loc1_:int = int(this._userInfo.activityData[19]);
         if(_loc1_ == 0)
         {
            if(this._headIcon1)
            {
               DisplayUtil.removeForParent(this._headIcon1);
               this._headIcon1 = null;
            }
         }
         else
         {
            this._headIcon1 = new IconDisplayer();
            this._headIcon1.setIconUrl(URLUtil.getActivityAnimation("heroTieAct/" + this.ICON_NAME1[_loc1_ - 1]),this.onNewComplete);
         }
      }
      
      private function onNewComplete() : void
      {
         this.addHeadIcon1(this._headIcon1);
      }
      
      public function addHeadIcon1(param1:DisplayObject) : void
      {
         if(this.headIcon)
         {
            DisplayObjectUtil.removeFromParent(this.headIcon);
         }
         this.headIcon = param1;
         this.headIcon.y = -110;
         this.headIcon.x -= this.headIcon.width / 2;
         if(this.animation)
         {
            DisplayObjectContainer(this.animation).addChild(this.headIcon);
         }
      }
      
      public function setNewTeamData(param1:int) : void
      {
         this._userInfo.activityData[19] = param1;
         this.updateTeamIcon1();
      }
      
      private function updateTrainerLevel() : void
      {
         this._trainerLevel = new ActorTrainerLevel();
         this._trainerLevel.setData(this._userInfo.trainerLevel);
      }
      
      public function updateNick(param1:String) : void
      {
         var value:String = param1;
         this._isInvalidate = true;
         this._userInfo.nick = value;
         DisplayObjectUtil.removeFromParent(this._nickImage);
         if(this._userInfo.vipInfo.isVip())
         {
            if(this._userInfo.isYearVip)
            {
               this._nickImage = LabelRenderer.getYearVipImage(value,ColorConstants.YEAR_VIP_TEXT_COLOR,3342336);
               ServerBufferManager.getServerBuffer(ServerBufferType.NEW_YEAR_VIP_PET,function(param1:ServerBuffer):void
               {
                  var server:ServerBuffer = param1;
                  var _isPlay:Boolean = Boolean(server.readDataAtPostion(8));
                  if(!_isPlay)
                  {
                     ServerBufferManager.updateServerBuffer(ServerBufferType.NEW_YEAR_VIP_PET,8,1);
                     TweenNano.delayedCall(20,function():void
                     {
                        var yearEffect:MovieClip = null;
                        yearEffect = UIManager.getMovieClip("YearVipFirstEffect");
                        _nickTitleLayer.addChild(yearEffect);
                        yearEffect.x = _nickImage.x + 28;
                        yearEffect.y = _nickImage.y + 15;
                        MovieClipUtil.playMc(yearEffect,2,yearEffect.totalFrames,function():void
                        {
                           yearEffect.gotoAndStop(1);
                           DisplayUtil.removeForParent(yearEffect);
                        });
                     });
                  }
               });
            }
            else
            {
               this._nickImage = LabelRenderer.getLabelImage(value,ColorConstants.VIP_TEXT_COLOR,3342336);
            }
         }
         else
         {
            this._nickImage = LabelRenderer.getLabelImage(value,0,16777215);
         }
      }
      
      private function layoutNickImage() : void
      {
         var _loc1_:int = -5;
         if(this._nickImage != null)
         {
            this._nickImage.x = -1 * (this._nickImage.width >> 1);
            this._nickImage.y = !!this._titleImage ? this._titleImage.height : 0;
            this._nickImage.y += _loc1_;
            this._nickTitleLayer.addChild(this._nickImage);
            if(this._userInfo.trainerLevel > 0)
            {
               this._nickImage.x += this._trainerLevel.width >> 1;
               this._trainerLevel.x = this._nickImage.x - this._trainerLevel.width;
               this._trainerLevel.y = this._nickImage.y + 4;
               this._nickTitleLayer.addChild(this._trainerLevel);
            }
            else
            {
               DisplayObjectUtil.removeFromParent(this._trainerLevel);
            }
         }
      }
      
      public function updateMedal(param1:uint) : void
      {
         var _loc3_:String = null;
         this._isInvalidate = true;
         this._userInfo.medalId = param1;
         DisplayObjectUtil.removeFromParent(this._titleImage);
         this._titleImage = null;
         var _loc2_:MedalItemDefinition = ItemConfig.getMedalDefinition(this._userInfo.medalId);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.title;
            this._titleImage = LabelRenderer.getLabelImage(_loc3_,5635874,0);
         }
      }
      
      private function initShadow() : void
      {
         this._shadow = new ActorShadow();
         this.updateShadow();
      }
      
      private function updateShadow() : void
      {
         this._isInvalidate = true;
         this._shadow.updateLabel(this._userInfo);
      }
      
      private function disposeShadow() : void
      {
         this._shadow.dispose();
         this._shadow = null;
      }
      
      private function initActorEquip() : void
      {
         this._actorEquip = new ActorEquipHelper(this);
         this.animation = this._actorEquip.getAnimation();
         this._actorEquip.initEquip();
      }
      
      public function addEquipByReferenceId(param1:int) : void
      {
         this._actorEquip.addEquip(param1);
      }
      
      public function removeEquipByReferenceId(param1:int) : void
      {
         this._actorEquip.removeEquip(param1);
      }
      
      private function onEquipUpdate(param1:UserInfoEvent) : void
      {
         this._actorEquip.updateEquipVec(this._userInfo.equipVec);
      }
      
      public function show() : void
      {
         this.isShow = true;
      }
      
      public function hide() : void
      {
         this.isShow = false;
      }
      
      public function set isShowNormal(param1:Boolean) : void
      {
         this._isShowNoraml = param1;
         this._isInvalidate = true;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         this._isShow = param1;
         this._isInvalidate = true;
      }
      
      public function get isShow() : Boolean
      {
         return this._isShow;
      }
      
      public function set isStop(param1:Boolean) : void
      {
         this._isStop = param1;
      }
      
      public function get isStop() : Boolean
      {
         return !this._isShow || this._isStop;
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return this._hotObject.hitTestPoint(param1,param2,param3);
      }
      
      public function walk(param1:Number, param2:Number) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         if(!this._userInfo.isRemote())
         {
            this.syncToSever(param1,param2);
         }
         if(Boolean(SceneManager.active) && SceneManager.active.mapModel.sceneType == SceneType.BIG_LOBBY)
         {
            _loc3_ = new Point(this.x,this.y);
            _loc4_ = new Point(param1,param2);
            SceneManager.active.mapModel.gameMap.walk(this,_loc3_,_loc4_);
         }
         else
         {
            runToLocation(param1,param2);
         }
      }
      
      protected function syncToSever(param1:Number, param2:Number) : void
      {
         Connection.send(CommandSet.SYNC_POSITION_1101,param1,param2,getTimer() / DateUtil.MILLISECONDS_PER_SECOND);
      }
      
      public function talk(param1:String) : void
      {
         this.getActorAttach(ActorAttachType.CHAT).excute(param1);
      }
      
      public function addShootEffect(param1:ShootHitEffect) : void
      {
         this.getActorAttach(ActorAttachType.SHOOT).excute({
            "effect":param1,
            "isAdd":true
         });
      }
      
      public function removeShootEffect(param1:ShootHitEffect) : void
      {
         this.getActorAttach(ActorAttachType.SHOOT).excute({
            "effect":param1,
            "isAdd":false
         });
      }
      
      private function initActorAttach() : void
      {
         this._acttachVec = new Vector.<IActorAttach>();
         var _loc1_:ChatActorAttach = new ChatActorAttach();
         _loc1_.attach(this);
         this._acttachVec.push(_loc1_);
         var _loc2_:ShootActorAttach = new ShootActorAttach();
         _loc2_.attach(this);
         this._acttachVec.push(_loc2_);
      }
      
      public function initDecoration() : void
      {
         if(this.getInfo().birthdayInfo.isOpen)
         {
            if(this._decorationMC == null)
            {
               this._decorationMC = UIManager.getMovieClip("Decoration" + DecorationManager.getConstellation(String(this.getInfo().birthdayInfo.month),String(this.getInfo().birthdayInfo.day)));
            }
            this._decorationMC.x = this._nickImage.x - (this._decorationMC.width + 3);
            if(this._userInfo.trainerLevel > 0)
            {
               this._decorationMC.x = this._nickImage.x - (this._trainerLevel.width + this._decorationMC.width + 3);
            }
            this._decorationMC.y = this._nickImage.y;
            this._nickTitleLayer.addChild(this._decorationMC);
         }
      }
      
      public function initFamousMark() : void
      {
         if(this._userInfo.activityData.length < 15)
         {
            return;
         }
         var _loc1_:Boolean = Boolean(this._userInfo.activityData[14]);
         if(_loc1_)
         {
            if(this._famouseMC == null)
            {
               this._famouseMC = UIManager.getMovieClip("FamouseMC");
            }
            if(this._yearVipIcon)
            {
               this._famouseMC.x = this._nickImage.x + this._nickImage.width + 3 + this._yearVipIcon.width + 8;
            }
            else
            {
               this._famouseMC.x = this._nickImage.x + this._nickImage.width + 8;
            }
            this._famouseMC.y = this._nickImage.y + 10;
            this._nickTitleLayer.addChild(this._famouseMC);
         }
      }
      
      private function initYearVipIcon() : void
      {
         if(this._userInfo.isYearVip)
         {
            if(this._yearVipIcon == null)
            {
               this._yearVipIcon = UIManager.getMovieClip(this._yearIconClassName);
            }
            this._yearVipIcon.gotoAndStop(this._userInfo.isYearVip);
            this._yearVipIcon.x = this._nickImage.x + this._nickImage.width;
            this._yearVipIcon.y = this._nickImage.y + 12;
            this._nickTitleLayer.addChild(this._yearVipIcon);
         }
      }
      
      public function updateYearIcon() : void
      {
         this.updateNick(this._userInfo.nick);
         this.layoutNickImage();
      }
      
      public function updateMiKaChangeAct() : void
      {
         if(this.id != ActorManager.getActor().id)
         {
            return;
         }
         SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
               {
                  candyActDispose();
                  _type = par.infoVec[0];
                  if(par.infoVec[0] == 0)
                  {
                     MorphManager.removeMorph(ActorManager.getActor());
                     return;
                  }
                  var _loc2_:uint = param1.getCount(DAY_LIST[0]);
                  _leaveTime = CD_TIME - _loc2_;
                  ActorManager.actorInfo.morphInfo.morphId = MorphSwitch.morphSwitch(CHANGE_INDEX[par.infoVec[0] - 1]);
                  MorphManager.startThisMorph(ActorManager.actorInfo.morphInfo.morphId);
                  _headIcon = new IconDisplayer();
                  _headIcon.mouseChildren = true;
                  Tick.instance.removeRender(timeCount);
                  _headIcon.setIconUrl(URLUtil.getActivityAnimation("CandySelfIcon"),onComplete);
               });
            });
         });
      }
      
      public function setCandyActData(param1:uint) : void
      {
         this._userInfo.activityData[15] = param1;
         this.updateMiKaChangeAct();
      }
      
      public function setSelfBarData(param1:int, param2:int) : void
      {
         this._userInfo.activityData[13] = param1;
         this._userInfo.activityData[14] = param2;
         this.updateSelfBar();
      }
      
      public function updateSelfBar() : void
      {
         if(this._userInfo.activityData.length < 15)
         {
            return;
         }
      }
      
      private function onComplete() : void
      {
         this._headIcon.x = -120;
         this._headIcon.y = this._nickImage.y - 180;
         this._nickTitleLayer.addChild(this._headIcon);
         var _loc1_:MovieClip = this._headIcon.icon as MovieClip;
         if(_loc1_ == null)
         {
            return;
         }
         this._timeUI = _loc1_["timeUI"];
         this._timeTxt = this._timeUI["timeTxt"];
         this._bar = this._timeUI["bar"];
         this._haveAward = _loc1_["haveAward"];
         this._haveAward.buttonMode = true;
         TooltipManager.addCommonTip(this._haveAward,"领取觉醒值");
         if(this._leaveTime <= 0)
         {
            this._leaveTime = 0;
            this._haveAward.filters = [];
            this._haveAward.gotoAndStop(2);
            this._haveAward.mouseEnabled = this._haveAward.mouseChildren = true;
         }
         else
         {
            ColorFilter.setGrayscale(this._haveAward);
            this._haveAward.gotoAndStop(1);
            this._haveAward.mouseEnabled = this._haveAward.mouseChildren = false;
            Tick.instance.addRender(this.timeCount,1000);
         }
         this._timeTxt.text = DateUtil.getMS(this._leaveTime);
         this._bar.scaleX = this._leaveTime / CD_TIME;
         this._haveAward.addEventListener(MouseEvent.CLICK,this.onHaveAward);
      }
      
      private function candyActDispose() : void
      {
         this._type = 0;
         if(this._haveAward)
         {
            this._haveAward.removeEventListener(MouseEvent.CLICK,this.onHaveAward);
            TooltipManager.remove(this._haveAward);
            this._haveAward = null;
         }
         if(this._headIcon)
         {
            DisplayObjectUtil.removeFromParent(this._headIcon);
            this._headIcon = null;
         }
         this._timeUI = null;
         this._timeTxt = null;
         this._bar = null;
         if(ActorManager.actorInfo.id == this._userInfo.id)
         {
            Tick.instance.removeRender(this.timeCount);
         }
      }
      
      private function onHaveAward(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         SwapManager.swapItem(SWAP_LIST[1],1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            ServerMessager.addMessage("恭喜获得" + WIN_VAL[_type] + "点觉醒值!");
            MorphManager.removeMorph(ActorManager.getActor());
            candyActDispose();
            ModuleManager.showAppModule("MiKaAwakenActFivePanel");
         });
      }
      
      private function timeCount(param1:int) : void
      {
         --this._leaveTime;
         this._timeTxt.text = DateUtil.getMS(this._leaveTime);
         this._bar.scaleX = this._leaveTime / CD_TIME;
         if(this._leaveTime <= 0)
         {
            this._haveAward.filters = [];
            this._haveAward.gotoAndStop(2);
            this._haveAward.mouseEnabled = this._haveAward.mouseChildren = true;
            this._userInfo.activityData[15] = 0;
            Tick.instance.removeRender(this.timeCount);
         }
         else
         {
            ColorFilter.setGrayscale(this._haveAward);
            this._haveAward.gotoAndStop(1);
            this._haveAward.mouseEnabled = this._haveAward.mouseChildren = false;
         }
      }
      
      public function transformAsRabbit(param1:int) : void
      {
         var which:int = param1;
         if(this.id != ActorManager.getActor().id)
         {
            return;
         }
         SwapManager.swapItem(this.RABBIT_SWAP_LIST[1],1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            DayLimitListManager.getDaylimitList(RABBIT_DAY_LIST,function(param1:DayLimitListInfo):void
            {
               var info:DayLimitListInfo = param1;
               _transTime = TRANSTOTALTIME - info.getCount(RABBIT_DAY_LIST[1]);
               if(which == 0 && info.getCount(RABBIT_DAY_LIST[1]) > 0)
               {
                  beginTrans();
               }
               else if(which == 1 && info.getCount(RABBIT_DAY_LIST[0]) == 0)
               {
                  SwapManager.swapItem(RABBIT_SWAP_LIST[0],1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     beginTrans();
                  });
               }
            });
         });
      }
      
      private function beginTrans() : void
      {
         this.transformDispose();
         ActorManager.actorInfo.morphInfo.morphId = MorphSwitch.morphSwitch(46);
         MorphManager.startThisMorph(ActorManager.actorInfo.morphInfo.morphId);
         this._rabbitHead = new IconDisplayer();
         this._rabbitHead.mouseChildren = true;
         this._rabbitHead.setIconUrl(URLUtil.getActivityAnimation("RabbitMoonLightCapsule/RabbitHeadIcon"),this.onRabbitIconLoaded);
      }
      
      private function onRabbitIconLoaded() : void
      {
         this._rabbitHead.x = -100;
         this._rabbitHead.y = this._nickImage.y - 130;
         this._nickTitleLayer.addChild(this._rabbitHead);
         var _loc1_:MovieClip = this._rabbitHead.icon as MovieClip;
         if(_loc1_ == null)
         {
            return;
         }
         this._transTimeUI = _loc1_["timeUI"];
         this._transTimeTxt = this._transTimeUI["timeTxt"];
         this._transTimeBar = this._transTimeUI["bar"];
         this._goPanel = _loc1_["haveAward"];
         this._goPanel.buttonMode = true;
         TooltipManager.addCommonTip(this._goPanel,"你可以挑选月光胶囊喽");
         if(this._transTime > 0)
         {
            Tick.instance.addRender(this.transformTime,1000);
         }
         this._goPanel.addEventListener(MouseEvent.CLICK,this.onGoPanel);
      }
      
      private function onGoPanel(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("RabbitMoonLightCapsuleRewardPanel");
      }
      
      private function transformTime(param1:int) : void
      {
         --this._transTime;
         if(this._transTime <= 0)
         {
            this._goPanel.filters = [];
            this._goPanel.gotoAndStop(2);
            this._goPanel.mouseEnabled = this._goPanel.mouseChildren = true;
            Tick.instance.removeRender(this.transformTime);
            this._transTime = 0;
         }
         else
         {
            ColorFilter.setGrayscale(this._goPanel);
            this._goPanel.gotoAndStop(1);
            this._goPanel.mouseEnabled = this._goPanel.mouseChildren = false;
         }
         this._transTimeTxt.text = DateUtil.getMS(this._transTime);
         this._transTimeBar.scaleX = (this.TRANSTOTALTIME - this._transTime) / this.TRANSTOTALTIME;
      }
      
      public function transformDispose() : void
      {
         if(this._goPanel)
         {
            this._goPanel.removeEventListener(MouseEvent.CLICK,this.onGoPanel);
            TooltipManager.remove(this._goPanel);
            this._goPanel = null;
         }
         if(this._rabbitHead)
         {
            DisplayObjectUtil.removeFromParent(this._rabbitHead);
            this._rabbitHead = null;
         }
         this._transTimeUI = null;
         this._transTimeTxt = null;
         this._transTimeBar = null;
         Tick.instance.removeRender(this.transformTime);
      }
      
      public function addEggIcon(param1:String = "eggIcon") : void
      {
         DisplayUtil.removeForParent(this._eggIcon);
         this._eggIcon = UIManager.getMovieClip(param1);
         (this.animation as Sprite).addChild(this._eggIcon);
      }
      
      public function removeEggIcon() : void
      {
         DisplayUtil.removeForParent(this._eggIcon);
      }
      
      private function getActorAttach(param1:String) : IActorAttach
      {
         var _loc2_:IActorAttach = null;
         for each(_loc2_ in this._acttachVec)
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
         for each(_loc1_ in this._acttachVec)
         {
            _loc1_.detach();
         }
         this._acttachVec = null;
      }
      
      private function initEventListener() : void
      {
         this.mouseEnabled = false;
         this._hotObject = this.animation as Sprite;
         this._hotObject.buttonMode = true;
         this._hotObject.mouseChildren = false;
         this._hotObject.mouseEnabled = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         this._hotObject.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         this._userInfo.addEventListener(UserInfoEvent.FOLLOWING_PET_UPDATE,this.onFollowingPetUpdate);
         this._userInfo.addEventListener(UserInfoEvent.RIDING_PET_UPDATE,this.onRidePetUpdate);
         this._userInfo.addEventListener(UserInfoEvent.EQUIP_UPDATE,this.onEquipUpdate);
         this._userInfo.addEventListener(UserInfoEvent.TRAINER_SCORE_UPDATE,this.onTrainerScoreUpdate);
         this._userInfo.vipInfo.addEventListener(VipInfo.VIP_UPDATE,this.onVipUpdate);
         this._userInfo.addEventListener(NonoInfoEvent.NONOINFO_UPDATE,this.updateNonoInfo);
         NonoUtil.addEventListener(NonoInfoEvent.NONO_FLAG_CHANGE,this.updateNonoInfo);
         PetInfoManager.addEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE,this.onPetPropertiesChange);
      }
      
      private function disposeEventListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         this._hotObject.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         this._userInfo.removeEventListener(UserInfoEvent.FOLLOWING_PET_UPDATE,this.onFollowingPetUpdate);
         this._userInfo.removeEventListener(UserInfoEvent.RIDING_PET_UPDATE,this.onRidePetUpdate);
         this._userInfo.removeEventListener(UserInfoEvent.EQUIP_UPDATE,this.onEquipUpdate);
         this._userInfo.removeEventListener(UserInfoEvent.TRAINER_SCORE_UPDATE,this.onTrainerScoreUpdate);
         this._userInfo.vipInfo.removeEventListener(VipInfo.VIP_UPDATE,this.onVipUpdate);
         this._userInfo.removeEventListener(NonoInfoEvent.NONOINFO_UPDATE,this.updateNonoInfo);
         NonoUtil.removeEventListener(NonoInfoEvent.NONO_FLAG_CHANGE,this.updateNonoInfo);
         PetInfoManager.removeEventListener(PetInfoEvent.PET_PROPERTIES_CHANGE,this.onPetPropertiesChange);
      }
      
      public function removeMouseEvent() : void
      {
         this._hotObject.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onPetPropertiesChange(param1:PetInfoEvent) : void
      {
         var _loc2_:PetInfo = param1.info;
         if(Boolean(this._userInfo.followingPetInfo) && _loc2_.catchTime == this._userInfo.followingPetInfo.catchTime)
         {
            this._userInfo.setFollowingPetInfo(_loc2_);
         }
      }
      
      private function onTrainerScoreUpdate(param1:UserInfoEvent) : void
      {
         this._trainerLevel.setData(this._userInfo.trainerLevel);
         this._isInvalidate = true;
      }
      
      private function onVipUpdate(param1:Event) : void
      {
         this.updateNick(this._userInfo.nick);
         this.updateNono();
         this.updateShadow();
      }
      
      private function updateNono() : void
      {
         if(this._followingNono == null)
         {
            this._followingNono = new Nono();
         }
         this._followingNono.clearView();
         this._followingNono.updateView(this._userInfo);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == 3845)
         {
            if(this.getInfo().id != ActorManager.getActor().id)
            {
               if(this.getInfo().activityData[17] != ActorManager.getActor().getInfo().activityData[17])
               {
                  AlertManager.showInviteFightAlert(this.getInfo().id);
                  _loc2_ = MapProcessor_3845.curFightType;
                  if(_loc2_ == 1)
                  {
                     _loc2_ = 2;
                  }
                  ModelLocator.getInstance().dispatchEvent(new LogicEvent(LogicEvent.GOD_FIRE_PK_SELECT,_loc2_));
               }
               else
               {
                  AlertManager.showAlert("这个赛尔是你的队友哦！请挑战其他阵营的成员！");
               }
               param1.stopImmediatePropagation();
               return;
            }
         }
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == 3852)
         {
            if(this.getInfo().id != ActorManager.getActor().id)
            {
               if(this.getInfo().activityData[20] != ActorManager.getActor().getInfo().activityData[20])
               {
                  AlertManager.showInviteFightAlert(this.getInfo().id);
                  _loc3_ = MapProcessor_3852.curFightType;
                  if(_loc3_ == 1)
                  {
                     _loc3_ = 2;
                  }
                  ModelLocator.getInstance().dispatchEvent(new LogicEvent(LogicEvent.BEST_CATCH_PK_SELECT,_loc3_));
               }
               else
               {
                  AlertManager.showAlert("这个赛尔是你的队友哦！请挑战其他阵营的成员！");
               }
               param1.stopImmediatePropagation();
               return;
            }
         }
         ModuleManager.showModule(URLUtil.getAppModule("UserPanel"),"正在打开个人信息面板...",this._userInfo.id);
         param1.stopImmediatePropagation();
      }
      
      public function startTransform(param1:int, param2:String = "pet") : void
      {
         if(this._isTransform)
         {
            if(param1 == this._transformMobile.id)
            {
               return;
            }
            this.stopTransform();
         }
         this._transformMobile = new Mobile();
         this._transformMobile.id = param1;
         if(param2 == PET)
         {
            this._transformMobile.resourceUrl = URLUtil.getPetSwf(param1);
         }
         else
         {
            this._transformMobile.resourceUrl = URLUtil.getActivityActorSwf(param1);
         }
         this.addCarriedMobile(this._transformMobile);
         if(this._transformMobile.hasEventListener(MouseEvent.CLICK) == false)
         {
            this._transformMobile.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         }
         this.isTransform = true;
      }
      
      public function stopTransform() : void
      {
         if(this._isTransform)
         {
            this.removeCarriedMobile(this._transformMobile);
            if(this._transformMobile)
            {
               this._transformMobile.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
               this._transformMobile.dispose();
            }
            this._transformMobile = null;
            this.isTransform = false;
         }
      }
      
      private function set isTransform(param1:Boolean) : void
      {
         this._isTransform = param1;
         this._isInvalidate = true;
      }
      
      private function initNono() : void
      {
         if(this._followingNono == null)
         {
            this._followingNono = new Nono();
         }
         this.updateNonoInfo(null);
      }
      
      private function updateNonoInfo(param1:NonoInfoEvent = null) : void
      {
         var _loc2_:NonoInfo = this._userInfo.getNonoInfo();
         if(_loc2_.isHava)
         {
            if(_loc2_.isFollowing)
            {
               if(this._followingNono.isCarried() == false)
               {
                  this.addCarriedMobile(this._followingNono,this._followingNono.followDistance);
               }
            }
            else
            {
               this.removeCarriedMobile(this._followingNono);
            }
            this._followingNono.updateView(this._userInfo);
         }
      }
      
      public function addMorph(param1:MovieClip) : void
      {
         this._morphMC = param1;
         this._nickTitleLayer.addChild(this._morphMC);
      }
      
      public function removeMorph() : void
      {
         DisplayUtil.removeForParent(this._morphMC);
         this._morphMC = null;
      }
      
      public function set blockNoNo(param1:Boolean) : void
      {
         this._isBlockFollowingNono = param1;
         this._isInvalidate = true;
      }
      
      private function disposeFollowingNono() : void
      {
         this.removeCarriedMobile(this._followingNono);
         this._followingNono.dispose();
         this._followingNono = null;
      }
      
      public function getNono() : Nono
      {
         return this._followingNono;
      }
      
      public function addDogz(param1:Boolean, param2:uint) : void
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
         this._actorEquip.hidHandAndFoot();
         this.runSpeed = this.DOGZ_RUN_SPEED;
      }
      
      public function removeDogz(param1:Boolean, param2:uint) : void
      {
         this.checkRemoveFloat(param2);
         (this.animation as Sprite).y = 0;
         this._actorEquip.showHandAndFoot();
         this.runSpeed = this.NOMARL_RUN_SPEED;
      }
      
      public function isShopAllEquipPlay(param1:Boolean, param2:Boolean) : void
      {
         this._isFloat = !param1;
         if(this._shadow)
         {
            if(param1)
            {
               this._shadow.stop();
            }
            else
            {
               this._shadow.play();
            }
         }
         if(this._followingPet)
         {
            if(this._followingPet.animation)
            {
               this._followingPet.animation.isStopAllAnimation(param2);
            }
            if(this._followingPet.getEffect())
            {
               this._followingPet.getEffect().visible = !param2;
            }
         }
         if(Boolean(this._followingNono) && Boolean(this._followingNono.animation))
         {
            this._followingNono.animation.isStopAllAnimation(param2);
         }
      }
      
      public function get isDogz() : Boolean
      {
         return this._isDogz;
      }
      
      public function set isDogz(param1:Boolean) : void
      {
         this._isDogz = param1;
      }
      
      public function get curtDogzId() : int
      {
         return this._curDogId;
      }
      
      public function set curtDogzId(param1:int) : void
      {
         this._curDogId = param1;
      }
      
      private function checkAddFloat(param1:uint, param2:Boolean = false) : void
      {
         var id:uint = param1;
         var isEuipAction:Boolean = param2;
         if(this._floatList.indexOf(id) != -1)
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
         if(this._floatList.indexOf(param1) != -1)
         {
            TweenMax.killChildTweensOf(this._normalLayer);
            TweenMax.killChildTweensOf(this._nickTitleLayer);
         }
      }
      
      private function initFollowingPet() : void
      {
         this._followingPet = new FollowingPet();
         this.onFollowingPetUpdate(null);
      }
      
      private function onFollowingPetUpdate(param1:UserInfoEvent) : void
      {
         if(this._userInfo.followingPetInfo)
         {
            if(!this._followingPet.isCarried())
            {
               this.addCarriedMobile(this._followingPet,this._followingPet.followDistance);
            }
         }
         else
         {
            this.removeCarriedMobile(this._followingPet);
         }
         this._followingPet.updateView(this._userInfo);
      }
      
      private function disposeFollowingPet() : void
      {
         this.removeCarriedMobile(this._followingPet);
         this._followingPet.dispose();
         this._followingPet = null;
      }
      
      public function set blockFollowingPet(param1:Boolean) : void
      {
         this._isBlockFollowingPet = param1;
         this._isInvalidate = true;
      }
      
      public function hasFollowingPet() : Boolean
      {
         return this._userInfo.followingPetInfo != null;
      }
      
      public function getFollowingPet() : FollowingPet
      {
         return this._followingPet;
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
         if(!this._isDisposed)
         {
            this._isDisposed = true;
            this.stopTransform();
            this.disposeEventListener();
            this.disposeFollowingPet();
            this.disposeFollowingNono();
            this.disposeActorAttach();
            this.disposeShadow();
            super.dispose();
         }
      }
      
      public function getInfo() : UserInfo
      {
         return this._userInfo;
      }
      
      private function onRidePetUpdate(param1:UserInfoEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:EquipItem = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc2_:Vector.<EquipItem> = this.getInfo().equipVec;
         if(this._userInfo.ridingPetInfo)
         {
            if(ActorManager.actorInfo.vipInfo.isVip() == false)
            {
               if(TimeManager.getServerTime() - this._userInfo.ridingPetInfo.chipPutOnTime > 7 * 24 * 60 * 60)
               {
                  return;
               }
            }
            _loc3_ = PetRideShopConfig.getEquipIdByChipBackId(this._userInfo.ridingPetInfo.petRideChipId);
            _loc4_ = new EquipItem(_loc3_);
            if(this._userInfo.ridingPetInfo.isPetRiding)
            {
               if(_loc4_)
               {
                  _loc2_.push(_loc4_);
               }
               this.updateItemManager(_loc2_);
               this.getInfo().updateEquipVec(_loc2_);
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc6_ = _loc2_[_loc5_].slotIndex == EquipSlot.DOGZ_LEFT || _loc2_[_loc5_].slotIndex == EquipSlot.DOGZ_RIGHT;
               _loc7_ = PetRideShopConfig.isRidePetEquip(_loc2_[_loc5_].referenceId);
               if(_loc6_ && _loc7_)
               {
                  _loc2_.splice(_loc5_,1);
               }
               _loc5_++;
            }
            this.updateItemManager(_loc2_);
            this.getInfo().updateEquipVec(_loc2_);
         }
      }
      
      private function updateItemManager(param1:Vector.<EquipItem>) : void
      {
         var _loc3_:EquipItem = null;
         var _loc4_:EquipItem = null;
         var _loc2_:Vector.<EquipItem> = ItemManager.getEquipVec();
         for each(_loc3_ in _loc2_)
         {
            _loc3_.isEquiped = false;
            for each(_loc4_ in param1)
            {
               if(_loc3_.referenceId == _loc4_.referenceId)
               {
                  _loc3_.isEquiped = true;
                  break;
               }
            }
         }
      }
   }
}
