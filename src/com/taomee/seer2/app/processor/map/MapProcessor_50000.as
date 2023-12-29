package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.FindMiKaAct;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.group.UserGroupManager;
   import com.taomee.seer2.app.actor.group.UserGroupType;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.record.FightRecordData;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.component.teleport.HomeDeferTeleport;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.nono.NonoInfoEvent;
   import com.taomee.seer2.app.gameRule.nono.NonoUtil;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.LeiKeGrowthHelper;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.activity.CandyNightmareAct.CandyNightmareAct;
   import com.taomee.seer2.app.processor.activity.homeActiviry.SemiyaAvtivity;
   import com.taomee.seer2.app.processor.activity.nextyearActivity.NextyearActivity;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.VersionManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_50000 extends MapProcessor
   {
      
      private static const MOVESKYCONST:int = 1;
      
      private static const MOVESKYMAX:int = 210;
      
      private static const MOVESKYMIN:int = 523;
      
      private static const LOVE_DAY:int = 1013;
      
      private static const LOVE_NUM:int = 10;
      
      private static const FIGHT_INDEX:int = 843;
       
      
      private var _starrySky:MovieClip;
      
      private var _moveSkyType:int;
      
      private var _skyInterval:int;
      
      private var _openGameMenu:MovieClip;
      
      private var _openWeeklyNews:MovieClip;
      
      private var _openPetStorage:MovieClip;
      
      private var _goTransmitCabin:MovieClip;
      
      private var _birthBtn:SimpleButton;
      
      private var _goTransmitDeferTeleport:HomeDeferTeleport;
      
      private var _newsPaperMC:MovieClip;
      
      private var _paperTip:MovieClip;
      
      private var _nono:MovieClip;
      
      private var _userInfo:UserInfo;
      
      private var _npc30001:Mobile;
      
      private var _sexStr:String;
      
      private var _semiya:SemiyaAvtivity;
      
      private var _mimaMC:MovieClip;
      
      private var _nextyearActivity:NextyearActivity;
      
      private var _candyAct:CandyNightmareAct;
      
      private var _resLib:ApplicationDomain;
      
      private var _npc:Mobile;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function MapProcessor_50000(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMouseMoveOn();
         this.initDoor();
         this.initDoorDeferTeleport();
         this.initFireDragon();
         this.init30001();
         this.initPlantWindow();
         this.initChallengeHomePet();
         this._nono = _map.content["nono"];
         this._nono.addEventListener(MouseEvent.CLICK,this.onNonoClick);
         this._userInfo = ActorManager.actorInfo;
         this._userInfo.addEventListener(NonoInfoEvent.NONOINFO_UPDATE,this.updateNonoInfo);
         if(SceneManager.active.mapID == this._userInfo.id)
         {
            this.updateNonoInfo(null);
         }
         else
         {
            this._nono.visible = false;
            _map.content.removeChild(this._nono);
         }
         this._mimaMC = _map.content["mimaMC"];
         this._mimaMC.buttonMode = true;
         this._mimaMC.addEventListener(MouseEvent.CLICK,this.onMima);
         this.initBirth();
         //this.initSemiya();
         this.initNextyearActivity();
         this.lovePaoPoaActInit();
         this.initFoolDay();
         this._candyAct = new CandyNightmareAct(_map);
         _map.content["qiqiu"].addEventListener(MouseEvent.CLICK,this.onQiqiuClick);
      }
      
      private function initFoolDay() : void
      {
         FindMiKaAct.instance.setup();
      }
      
      private function lovePaoPoaActInit() : void
      {
         if(_map.id == ActorManager.actorInfo.id)
         {
            return;
         }
         DayLimitManager.getDoCount(LOVE_DAY,function(param1:uint):void
         {
            var val:Number;
            var count:uint = param1;
            if(count >= LOVE_NUM)
            {
               if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
               {
                  ServerMessager.addMessage("丘比特的爱泡泡已经传完啦，明天再来吧。");
               }
               return;
            }
            val = Math.random();
            if(val >= 0 && val <= 0.4)
            {
               getURL(function():void
               {
                  var sceneMC:MovieClip = null;
                  sceneMC = getMovie("SceneMC");
                  sceneMC.x = 263;
                  sceneMC.y = 236;
                  _map.front.addChild(sceneMC);
                  MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(sceneMC);
                     sceneMC = null;
                     addNpc();
                  });
               });
            }
         });
      }
      
      private function addNpc() : void
      {
         this._npc = new Mobile();
         this._npc.width = 82;
         this._npc.height = 115;
         this._npc.setPostion(new Point(552,340));
         this._npc.resourceUrl = URLUtil.getNpcSwf(717);
         this._npc.direction = 0;
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.label = "丘比特";
         this._npc.labelImage.y = -this._npc.height - 10;
         this._npc.buttonMode = true;
         this.showMouseHintAtMonster(this._npc);
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function removeNpc() : void
      {
         if(this._npc)
         {
            this.removeMouseHint();
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(716,"丘比特",[[0,"做一个充满爱的小赛尔，和我挑战将爱传播下去吧"]],["嗯嗯！","你和天使是亲戚吗"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX);
         }]);
      }
      
      private function showMouseHintAtMonster(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
         param1.addChild(this._mouseHint);
      }
      
      private function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = null;
      }
      
      private function getURL(param1:Function) : void
      {
         var callBack:Function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("lovePaoPaoAct/LovePaoPaoAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            callBack();
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function lovePaoPoaActDispose() : void
      {
         this._resLib = null;
         this.removeNpc();
         this.removeMouseHint();
      }
      
      private function onMima(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("PasswordDefendPanel"),"正在打开...");
      }
      
      private function initNextyearActivity() : void
      {
      }
      
      private function disposeNextyearActivity() : void
      {
      }
      
      private function initPlantWindow() : void
      {
         TooltipManager.addCommonTip(_map.content["window"],"普兰特山麓");
         _map.content["window"].buttonMode = true;
         _map.content["window"].addEventListener(MouseEvent.CLICK,this.onWindowClick);
      }
      
      private function onWindowClick(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.PLANT,ActorManager.actorInfo.id);
      }
      
      private function initChallengeHomePet() : void
      {
         var count:int = 0;
         if(SceneManager.active.mapID == ActorManager.actorInfo.id)
         {
            return;
         }
         count = 0;
         ServerBufferManager.getServerBuffer(ServerBufferType.POSTCARD_ACT,function(param1:ServerBuffer):void
         {
            count = param1.readDataAtPostion(0);
            if(count >= 3)
            {
               return;
            }
            if(FightManager.isJustWinFight() && FightManager.isFightRecordData(FightRecordData.FIGHT_TRAINER))
            {
               ++count;
               ServerBufferManager.updateServerBuffer(ServerBufferType.POSTCARD_ACT,0,count);
            }
         });
      }
      
      protected function onBola(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("PetKingLotteryPanel"),"正在打开...");
      }
      
      private function initBirth() : void
      {
         this._birthBtn = _map.content["birthBtn"];
         this._birthBtn.addEventListener(MouseEvent.CLICK,this.onBirth);
         TooltipManager.addCommonTip(this._birthBtn,"繁殖舱");
      }
      
      private function onBirth(param1:MouseEvent) : void
      {
         var _loc2_:Object = new Object();
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == ActorManager.actorInfo.id)
         {
            StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_66);
            _loc2_.birthType = 2;
         }
         else
         {
            StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_67);
            _loc2_.birthType = 3;
         }
         ModuleManager.toggleModule(URLUtil.getAppModule("BirthSystemPanel"),"正在打开繁殖...",_loc2_);
      }
      
      private function onQiqiuClick(param1:* = null) : void
      {
         var uName:String;
         var uid:int = 0;
         var e:* = param1;
         uid = int(SceneManager.active.mapID);
         if(uid == ActorManager.actorInfo.id)
         {
            ModuleManager.showAppModule("GuangyiteQiuPanel");
            return;
         }
         uName = UserGroupManager.getUser(UserGroupType.BUDDY,uid).nick;
         AlertManager.showConfirm("是否向玩家" + uName + "赠送1个光伊特气球？回礼后系统会返还你足够的光伊特气球作为奖励，何乐而不为呢~",function():void
         {
            if(ItemManager.getItemQuantityByReferenceId(401305) == 0)
            {
               AlertManager.showAlert("你持有的光伊特气球数量不足哦！");
            }
            else
            {
               SwapManager.swapItem(4636,1,function success(param1:IDataInput):void
               {
                  AlertManager.showAlert("赠送成功!");
                  new SwapInfo(param1);
               },null,new SpecialInfo(1,uid));
            }
         });
      }
      
      private function isReandNews() : Boolean
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_NEWS_PAPER_TAG);
         var _loc2_:String = String(_loc1_.data["newspaper"]);
         if(_loc2_ == VersionManager.version)
         {
            return true;
         }
         return false;
      }
      
      private function writeRecord() : void
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_NEWS_PAPER_TAG);
         _loc1_.data["newspaper"] = VersionManager.version;
         _loc1_.flush();
      }
      
      private function onNewsPaperClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_home_newspaper);
         ModuleManager.toggleModule(URLUtil.getAppModule("TimeNews"),"正在打开赛尔新闻...");
      }
      
      private function initStarrySky() : void
      {
         this._skyInterval = 0;
         this._starrySky = _map.far["starrySky"];
         this._starrySky.addEventListener(Event.ENTER_FRAME,this.moveSky);
      }
      
      private function moveSky(param1:Event) : void
      {
         ++this._skyInterval;
         if(this._skyInterval == 2)
         {
            this._skyInterval = 0;
            if(this._starrySky.x == MOVESKYMAX)
            {
               this._moveSkyType = 1;
            }
            if(this._starrySky.x == MOVESKYMIN)
            {
               this._moveSkyType = 0;
            }
            if(this._moveSkyType == 1)
            {
               this._starrySky.x -= MOVESKYCONST;
            }
            else
            {
               this._starrySky.x += MOVESKYCONST;
            }
            return;
         }
      }
      
      private function initDoor() : void
      {
         this._goTransmitCabin = _map.content["goTransmitCabin"];
         this._goTransmitCabin.gotoAndStop(1);
         initInteractor(this._goTransmitCabin);
         this._goTransmitCabin.addEventListener(MouseEvent.CLICK,this.onDoorClick);
      }
      
      private function onDoorClick(param1:MouseEvent) : void
      {
         this._goTransmitDeferTeleport.actorMoveClose();
      }
      
      private function initDoorDeferTeleport() : void
      {
         this._goTransmitDeferTeleport = new HomeDeferTeleport(this._goTransmitCabin);
         this._goTransmitDeferTeleport.setActorPostion(new Point(162,434));
         this._goTransmitDeferTeleport.setActorTargetMapId(70);
         this._goTransmitDeferTeleport.addEventListener(HomeDeferTeleport.ACTOR_ARRIVED,this.onActorArrivedDoor);
      }
      
      private function onActorArrivedDoor(param1:Event) : void
      {
         this._goTransmitCabin.play();
      }
      
      private function initMouseMoveOn() : void
      {
         var _loc1_:Vector.<MovieClip> = null;
         var _loc4_:int = 0;
         this._openGameMenu = _map.content["openGameMenu"];
         this._openWeeklyNews = _map.content["openHomeNews"];
         this._openPetStorage = _map.content["openPetStorage"];
         _loc1_ = Vector.<MovieClip>([this._openGameMenu,this._openPetStorage]);
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:Boolean = true;
         if(_loc3_ == true)
         {
            TooltipManager.addCommonTip(this._openGameMenu,"小游戏库");
            TooltipManager.addCommonTip(this._openPetStorage,"精灵仓库");
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               initInteractor(_loc1_[_loc4_]);
               _loc1_[_loc4_].addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
               _loc1_[_loc4_].addEventListener(MouseEvent.MOUSE_OUT,this.offMouseOver);
               _loc1_[_loc4_].addEventListener(MouseEvent.CLICK,this.onMouseClick);
               _loc4_++;
            }
            this._openGameMenu.buttonMode = true;
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      private function offMouseOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      private function init30001() : void
      {
         var _loc1_:XML = null;
         var _loc2_:NpcDefinition = null;
         if(_map.id == ActorManager.actorInfo.id && QuestManager.isAccepted(30001))
         {
            if(ActorManager.actorInfo.sex == 1)
            {
               this._sexStr = "妈妈";
            }
            else
            {
               this._sexStr = "爸爸";
            }
            _loc1_ = <npc id="161" resId="161" name="小雷克" dir="0" width="25" height="65" pos="150,334" actorPos="388,334" path="">
						<eventHandler>
							<click>
								<HandlerOpenDialogPanel/>
							</click>
						</eventHandler>
					</npc>;
            _loc2_ = new NpcDefinition(_loc1_);
            this._npc30001 = MobileManager.createNpc(_loc2_);
            this._npc30001.buttonMode = true;
            this._npc30001.addEventListener(MouseEvent.CLICK,this.on30001,false,1);
            TooltipManager.addCommonTip(this._npc30001,this._sexStr + "…饿了！");
         }
      }
      
      private function on30001(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         event.stopImmediatePropagation();
         NpcDialog.show(11,"多罗",[[1,"哈哈哈，队长，这个爱哭鬼叫你" + this._sexStr + "呀！"]],["头疼，带上这家伙，去问问伊娃博士吧！"],[function():void
         {
            if(_npc30001)
            {
               _npc30001.dispose();
            }
            DisplayUtil.removeForParent(_npc30001);
            _npc30001 = null;
            ServerMessager.addMessage("带雷克去找伊娃博士吧！");
         }]);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.target as MovieClip;
         switch(_loc2_)
         {
            case this._openGameMenu:
               ModuleManager.toggleModule(URLUtil.getAppModule("GameMenu"),"正在打开小游戏库...");
               break;
            case this._openPetStorage:
               ModuleManager.toggleModule(URLUtil.getAppModule("PetStoragePanel"),"正在打开精灵仓库...");
         }
      }
      
      private function initFireDragon() : void
      {
         if(_map.id == ActorManager.actorInfo.id)
         {
            LeiKeGrowthHelper.enterHome(_map);
         }
      }
      
      private function diposeFireDragon() : void
      {
         if(_map.id == ActorManager.actorInfo.id)
         {
            LeiKeGrowthHelper.leaveHome();
         }
      }
      
      private function onNonoClick(param1:MouseEvent) : void
      {
         if(ActorManager.actorInfo.getNonoInfo().isHava == false && ActorManager.actorInfo.vipInfo.isVip() == false)
         {
            AlertManager.showAlert("您当前没有nono!");
            return;
         }
         if(NonoUtil.isShow == false)
         {
            NonoUtil.show();
         }
         else
         {
            AlertManager.showAlert("您的nono当前处于显示状态!");
         }
      }
      
      private function updateNonoInfo(param1:NonoInfoEvent) : void
      {
         if(NonoUtil.isShow == false)
         {
            this._nono.visible = true;
            this._nono.useHandCursor = true;
            this._nono.buttonMode = true;
            TooltipManager.addCommonTip(this._nono,"召唤");
            if(VipManager.vipInfo.isVip())
            {
               this._nono.gotoAndStop(1);
            }
            else
            {
               this._nono.gotoAndStop(2);
            }
            _map.content.addChild(this._nono);
         }
         else
         {
            this._nono.visible = false;
            _map.content.removeChild(this._nono);
         }
      }
      
      private function initSemiya() : void
      {
      }
      
      override public function dispose() : void
      {
         FindMiKaAct.instance.dispose();
         TooltipManager.remove(this._openGameMenu);
         TooltipManager.remove(this._openPetStorage);
         this.diposeFireDragon();
         this.disposeNextyearActivity();
         this._nono.removeEventListener(MouseEvent.CLICK,this.onNonoClick);
         _map.content["window"].removeEventListener(MouseEvent.CLICK,this.onWindowClick);
         TooltipManager.remove(_map.content["window"]);
         this._mimaMC.removeEventListener(MouseEvent.CLICK,this.onMima);
         _map.content["qiqiu"].removeEventListener(MouseEvent.CLICK,this.onQiqiuClick);
         this._mimaMC = null;
         this._nono = null;
         if(this._userInfo != null)
         {
            this._userInfo.removeEventListener(NonoInfoEvent.NONOINFO_UPDATE,this.updateNonoInfo);
            this._userInfo = null;
         }
         if(this._npc30001)
         {
            this._npc30001.dispose();
         }
         this._npc30001 = null;
         this.lovePaoPoaActDispose();
         if(this._candyAct)
         {
            this._candyAct.dispose();
            this._candyAct = null;
         }
      }
   }
}
