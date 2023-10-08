package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activity.processor.FightDuoluo;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.component.teleport.DeferTeleport;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
   import com.taomee.seer2.app.processor.activity.heroTieAct.HeroTieAct;
   import com.taomee.seer2.app.processor.activity.mascot.MascotManager;
   import com.taomee.seer2.app.processor.activity.nextyearActivity.NextYearActivityShip;
   import com.taomee.seer2.app.processor.quest.handler.branch.quest10100.PetKingDayQuestNpc;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.MathUtil;
   
   public class MapProcessor_50 extends TitleMapProcessor
   {
       
      
      private var _goTransmitCabin:MovieClip;
      
      private var _leftChangeEquipment:MovieClip;
      
      private var _rightChangeEquipment:MovieClip;
      
      private var _makeEquipment:MovieClip;
      
      private var _goTransmitDeferTeleport:DeferTeleport;
      
      private var dandan:Mobile;
      
      private var _petKingQuest:PetKingDayQuestNpc;
      
      private var _fightHrader:FightDuoluo;
      
      private var _mascot:MascotManager;
      
      private var _npcShow:Vector.<SimpleButton>;
      
      private var _nextYearShip:NextYearActivityShip;
      
      private var _heroTieAct:HeroTieAct;
      
      private var _twoYearNpc:Mobile;
      
      private var _oldNpc:Mobile;
      
      private const DAY_LIST:Array = [5190,5192];
      
      private const SWAP_LIST:Vector.<int> = Vector.<int>([4199]);
      
      private const TASK_FINISH_FOV:int = 202496;
      
      private var timeId:int;
      
      public function MapProcessor_50(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         GrabXiaoYueSeAct.getInstance().setup(_map);
         StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_195);
         ModelLocator.getInstance().addEventListener(LogicEvent.TRAINER_PK_UPDATE,this.initTwoYearNpcHandle);
      }
      
      private function initHeroTieAct() : void
      {
         this._heroTieAct = new HeroTieAct(_map);
      }
      
      private function disposeHeroTieAct() : void
      {
         if(this._heroTieAct)
         {
            this._heroTieAct.dispose();
            this._heroTieAct = null;
         }
      }
      
      private function initShowNpc() : void
      {
         var _loc1_:SimpleButton = null;
         this._npcShow = new Vector.<SimpleButton>();
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = _map.content["btn" + _loc2_];
            TooltipManager.addCommonTip(_loc1_,"神勇骑士铠甲秀");
            _loc1_.addEventListener(MouseEvent.CLICK,this.onOpenShowBuyPanel);
            this._npcShow.push(_loc1_);
            _loc2_++;
         }
         this.randomShow();
      }
      
      private function timeManage() : void
      {
         var _showTxt:Function = null;
         _showTxt = function(param1:TimerEvent):void
         {
            var _loc2_:int = 5;
            _loc2_--;
            if(_loc2_ == 0)
            {
               _loc2_ = 10;
               randomShow();
            }
         };
         var my_Timer:Timer = new Timer(1000);
         my_Timer.start();
         my_Timer.addEventListener(TimerEvent.TIMER,_showTxt);
         this.randomShow();
      }
      
      private function randomShow() : void
      {
         var _loc1_:SimpleButton = null;
         var _loc2_:int = int(MathUtil.randomRegion(0,6));
         var _loc3_:int = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = this._npcShow[_loc3_];
            if(_loc3_ == _loc2_)
            {
               _loc1_.visible = true;
            }
            else
            {
               _loc1_.visible = false;
            }
            _loc3_++;
         }
      }
      
      private function onOpenShowBuyPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("KnightArmourPanel"),"正在打开面板...");
      }
      
      private function onClickBoy(param1:MouseEvent) : void
      {
         if(SwapManager.isSwapNumberMax(616))
         {
            SwapManager.entrySwap(616);
         }
      }
      
      private function initMascot() : void
      {
         this._mascot = new MascotManager(50,3,_map);
      }
      
      private function initPetKing() : void
      {
         this._petKingQuest = new PetKingDayQuestNpc(1003);
      }
      
      private function initFight() : void
      {
         this._fightHrader = new FightDuoluo();
      }
      
      private function initNpc() : void
      {
         var _loc1_:XML = <npc id="124" resId="124" name="蛋蛋" dir="1" width="25" height="50" pos="120,300" actorPos="334,325" path="">
												<eventHandler>
													<mouseOver>
														<HandlerShowNpcSlogan><![CDATA[蛋蛋蛋，拿出你的蛋！]]></HandlerShowNpcSlogan>
													</mouseOver>
												</eventHandler>
										  </npc>;
         this.dandan = MobileManager.createNpc(new NpcDefinition(_loc1_));
         this.dandan.addEventListener(MouseEvent.CLICK,this.clickDandan);
      }
      
      private function clickDandan(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var date:Date = new Date(TimeManager.getServerTime() * 1000);
         if(date.day != 0 && date.day < 5)
         {
            NpcDialog.show(124,"蛋蛋",[[0,"有彩色球？没有彩色球？只要你有！就可以抽取寡人必身的珍藏礼珍宝！！掐指一算（周五、周六、周日）才可以拿彩球来兑换哦"]],["好的我知道啦！"],[function():void
            {
               NpcDialog.hide();
            }]);
         }
         else
         {
            NpcDialog.show(124,"蛋蛋",[[0,"彩蛋神秘抽抽抽！！你准备好了吗？每次抽都会消耗一个彩蛋哦！"]],["来吧！抽吧！","我一会再来找你！"],[function():void
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("LuckySeerSpecialPanel"),"幸运赛尔");
            },function():void
            {
               NpcDialog.hide();
            }]);
         }
      }
      
      private function initChangeEquipment() : void
      {
         this._leftChangeEquipment = _map.content["leftChangeEquipment"];
         this._rightChangeEquipment = _map.content["rightChangeEquipment"];
         initInteractor(this._leftChangeEquipment);
         initInteractor(this._rightChangeEquipment);
         this._leftChangeEquipment.addEventListener(MouseEvent.CLICK,this.onChangeEquipmentClick);
         this._rightChangeEquipment.addEventListener(MouseEvent.CLICK,this.onChangeEquipmentClick);
      }
      
      private function onChangeEquipmentClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         closeInteractor(_loc2_);
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onChangeEquipmentClick);
         _loc2_.nextFrame();
      }
      
      private function initMakeEquipment() : void
      {
         this._makeEquipment = _map.content["makeEquipment"];
         initInteractor(this._makeEquipment);
         this._makeEquipment.addEventListener(MouseEvent.CLICK,this.onMakeEquipmentClick);
      }
      
      private function onMakeEquipmentClick(param1:MouseEvent) : void
      {
         this._makeEquipment.nextFrame();
         if(this._makeEquipment.currentFrame == 3)
         {
            this._makeEquipment.removeEventListener(MouseEvent.CLICK,this.onMakeEquipmentClick);
            closeInteractor(this._makeEquipment);
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
         this._goTransmitDeferTeleport = new DeferTeleport(this._goTransmitCabin);
         this._goTransmitDeferTeleport.setActorPostion(new Point(650,150));
         this._goTransmitDeferTeleport.setActorTargetMapId(70);
         this._goTransmitDeferTeleport.addEventListener(DeferTeleport.ACTOR_ARRIVED,this.onActorArrivedDoor);
      }
      
      private function onActorArrivedDoor(param1:Event) : void
      {
         this._goTransmitCabin.play();
      }
      
      private function initPrizeNpc() : void
      {
         MobileManager.getMobile(151,MobileType.NPC).visible = false;
      }
      
      private function initSuperPrize() : void
      {
         var npc:Mobile = null;
         npc = MobileManager.getMobile(151,MobileType.NPC);
         if(DateUtil.inInDateScope(5,14,11,14,21))
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,function(param1:ServerBuffer):void
            {
               var _loc2_:int = param1.readDataAtPostion(15);
               if(_loc2_ == 0)
               {
                  if(npc)
                  {
                     npc.visible = true;
                     npc.buttonMode = true;
                     npc.addEventListener(MouseEvent.CLICK,OnSuperPrizeHandler);
                  }
                  ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,15,1);
               }
            });
         }
      }
      
      private function OnSuperPrizeHandler(param1:MouseEvent) : void
      {
         var npc:Mobile = null;
         var evt:MouseEvent = param1;
         npc = MobileManager.getMobile(151,MobileType.NPC);
         SwapManager.swapItem(527,1,function(param1:IDataInput):void
         {
            var _loc2_:SwapInfo = new SwapInfo(param1);
            npc.removeEventListener(MouseEvent.CLICK,OnSuperPrizeHandler);
            npc.visible = false;
         });
      }
      
      private function initTwoYearNpcHandle(param1:LogicEvent = null) : void
      {
         var evt:LogicEvent = param1;
         this._oldNpc = MobileManager.getMobile(4,MobileType.NPC);
         if(this._oldNpc)
         {
            this._oldNpc.visible = false;
         }
         DayLimitListManager.getDaylimitList(this.DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            if(info.getCount(DAY_LIST[1]) > 0 && info.getCount(DAY_LIST[0]) == 0)
            {
               if(!MobileManager.getMobile(4,MobileType.NPC))
               {
                  timeId = setTimeout(function():void
                  {
                     initNpc1();
                  },2000);
               }
               else
               {
                  initNpc1();
               }
            }
            else if(_oldNpc)
            {
               _oldNpc.visible = true;
            }
         });
      }
      
      private function initNpc1() : void
      {
         this.afterFinish();
         this._oldNpc = MobileManager.getMobile(4,MobileType.NPC);
         this._oldNpc.visible = false;
         clearInterval(this.timeId);
         this._twoYearNpc = new Mobile();
         this._twoYearNpc.width = this._oldNpc.width;
         this._twoYearNpc.height = this._oldNpc.height;
         this._twoYearNpc.label = this._oldNpc.label;
         this._twoYearNpc.setPostion(new Point(this._oldNpc.x,this._oldNpc.y));
         this._twoYearNpc.resourceUrl = this._oldNpc.resourceUrl;
         this._twoYearNpc.buttonMode = true;
         this.showMouseHintAtMonster(this._twoYearNpc);
         MobileManager.addMobile(this._twoYearNpc,MobileType.NPC);
         this._twoYearNpc.addEventListener(MouseEvent.CLICK,this.onTwoYearNpcClick);
      }
      
      private function onTwoYearNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(400,"赛尔",[[0,"教官教官！！在人气大比拼中，我选择支持你了噢！！"]],["嘿嘿、是不是很感动呀？"],[function():void
         {
            NpcDialog.show(4,"菲鲁",[[0,"哇！你也选择支持我吗？那我就又能多一票了！~真开心，不过我还想要获得更多的人气~~~~"]],["我来帮教官拉票吧！"],[function():void
            {
               NpcDialog.show(4,"菲鲁",[[0,"好呀好呀！~难得你这么热心~~~那你就带着我的徽章去各处替我宣传宣传吧~~嘿嘿！~~记得去人多的地方噢~~去跑个5分钟什么的"]],["好哒！"],[function():void
               {
                  SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     ActorManager.getActor().updateMiKaChangeAct();
                  });
                  afterFinish();
               }]);
            }]);
         }]);
      }
      
      private function afterFinish() : void
      {
         if(this._twoYearNpc)
         {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK,this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
         }
         if(this._oldNpc)
         {
            this._oldNpc.visible = true;
         }
         clearInterval(this.timeId);
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 50;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      private function disposeTwoYearNpcHandle() : void
      {
         if(this._twoYearNpc)
         {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK,this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
         }
         this._oldNpc = null;
         clearInterval(this.timeId);
         ModelLocator.getInstance().removeEventListener(LogicEvent.TRAINER_PK_UPDATE,this.initTwoYearNpcHandle);
      }
      
      override public function dispose() : void
      {
         GrabXiaoYueSeAct.getInstance().dispose();
         super.dispose();
      }
   }
}
