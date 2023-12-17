package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.activity.processor.NewTermCeremonyActivity;
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.OptimizeManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.morphSystem.MorphUpdate;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.activity.giftMachine.GiftMachine;
   import com.taomee.seer2.app.processor.activity.nextyearActivity.ActivityNextyear;
   import com.taomee.seer2.app.processor.activity.nextyearActivity.NextYearActivityShip;
   import com.taomee.seer2.app.processor.activity.openSchool.OpenSchool;
   import com.taomee.seer2.app.processor.activity.processorQuest.Quest53Processor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.toolbar.TorchRelayorToolbar;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import com.taomee.seer2.core.utils.Util;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_70 extends TitleMapProcessor
   {
      
      private static const shou_chong_npc_id:int = 347;
       
      
      private var _leftBtn:SimpleButton;
      
      private var _rightBtn:SimpleButton;
      
      private var _newTermActivity:NewTermCeremonyActivity;
      
      private var _giftMachine:GiftMachine;
      
      private var _clickBoy:MovieClip;
      
      private var _vipBtn:SimpleButton;
      
      private var _saleNpc:Mobile;
      
      private var _npc:Mobile;
      
      private var _openSchool:OpenSchool;
      
      private var _haqi:SimpleButton;
      
      private var _mika:SimpleButton;
      
      private var _activityNextyear:ActivityNextyear;
      
      private var _nextYearShip:NextYearActivityShip;
      
      private var _xinxueqi:XinXueQiDianLi;
      
      private var _broadNpc:Mobile;
      
      private var _url:String;
      
      private var arrowMc:MovieClip;
      
      private var shouChong:Mobile;
      
      private var isCharged:Boolean;
      
      private var isFirstVip:Boolean;
      
      private var isShow:Boolean;
      
      private var _npc1046:Mobile;
      
      private var _firstNpc:Mobile;
      
      private var _flag:int;
      
      private var _flag1:int;
      
      private var _flag2:int;
      
      private var _flag3:int;
      
      private var oilBtn:SimpleButton;
      
      public function MapProcessor_70(param1:MapModel)
      {
         super(param1);
      }
      
      private static function onClosePanel() : void
      {
      }
      
      override public function init() : void
      {
         OptimizeManager.startOptimize();
         this.initBitMap();
         this.changeIndex();
         this.tojixiangBtn();
      }
      
      private function broadClickHandle() : void
      {
         this._broadNpc = MobileManager.getMobile(3038,MobileType.NPC);
         if(this._broadNpc)
         {
            this._broadNpc.addEventListener(MouseEvent.CLICK,this.onBroadClick);
         }
      }
      
      private function onBroadClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://seer.61.com/gameevent/2015stl/?tad=innermedia.seer2.free.inseer2"),"_blank");
      }
      
      private function broadClickDispose() : void
      {
         if(this._broadNpc)
         {
            this._broadNpc.removeEventListener(MouseEvent.CLICK,this.onBroadClick);
            this._broadNpc = null;
         }
      }
      
      private function onWidgetClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ActiveCountManager.requestActiveCount(250433,function(param1:int, param2:int):void
         {
            var type:int = param1;
            var count:int = param2;
            if(count <= 0)
            {
               SwapManager.swapItem(4162,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  jumpLink();
               });
            }
            else
            {
               jumpLink();
            }
         });
      }
      
      private function jumpLink() : void
      {
         this.exec("http://dc.61.com/Question/realQ?qn_id=84");
      }
      
      public function exec(param1:String) : void
      {
         var _loc2_:String = null;
         this._url = param1;
         if(this._url == "http://dc.61.com/Question/realQ?qn_id=84")
         {
            _loc2_ = "http://dc.61.com/Question/realQ?qn_id=84" + "&session=" + GlobalsManager.session + "&gameid=" + ClientConfig.productID + "&userid=" + ActorManager.actorInfo.id;
            navigateToURL(new URLRequest(_loc2_),"_blank");
         }
         else
         {
            Connection.addCommandListener(CommandSet.SESSION_1156,this.onSession);
            Connection.send(CommandSet.SESSION_1156,this.getGid(this._url));
         }
      }
      
      private function onSession(param1:MessageEvent) : void
      {
         var _loc2_:String = this.getFullHex(ActorManager.actorInfo.id.toString(16)) + Util.getSessionString(param1.message.getRawData());
         var _loc3_:String = this._url + "?sid=" + _loc2_ + "&fromGameId=" + ClientConfig.productID + "&serviceType=" + GlobalsManager.serverType;
         navigateToURL(new URLRequest(_loc3_));
      }
      
      private function getFullHex(param1:String) : String
      {
         if(param1.length >= 8)
         {
            return param1;
         }
         while(param1.length < 8)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      private function getGid(param1:String) : uint
      {
         if(param1.indexOf("gf.61.com") != -1)
         {
            return 6;
         }
         if(param1.indexOf("seer.61.com") != -1)
         {
            return 2;
         }
         return 0;
      }
      
      private function initNpcClick() : void
      {
         var _loc1_:Mobile = MobileManager.getMobile(1038,MobileType.NPC);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onNpc1038);
      }
      
      private function onNpc1038(param1:MouseEvent) : void
      {
      }
      
      private function tojixiangBtn() : void
      {
      }
      
      private function onDialogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:ColorTransform = null;
         if(param1.content == 8)
         {
            if(DialogPanel.functionalityBox.getUnit("有奖调查"))
            {
               _loc2_ = new ColorTransform();
               _loc2_.color = uint("0xFF0000");
               DialogPanel.functionalityBox.getUnit("有奖调查").createColorBtn(uint("0xFF0000"));
            }
         }
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(evt.content.params == "youjiangdiaocha")
         {
            ActiveCountManager.requestActiveCount(203801,function(param1:uint, param2:uint):void
            {
               var type:uint = param1;
               var count:uint = param2;
               if(count == 0)
               {
                  SwapManager.swapItem(2468,1,function(param1:IDataInput):void
                  {
                     var data:IDataInput = param1;
                     new SwapInfo(data);
                     AlertManager.showAlert("前往淘米调查团",function():void
                     {
                        VipManager.entryBBSCheck();
                     });
                  });
               }
               else
               {
                  AlertManager.showAlert("前往淘米调查团",function():void
                  {
                     VipManager.entryBBSCheck();
                  });
               }
            });
         }
      }
      
      private function initShouChongVip() : void
      {
         this.addFirstVip();
      }
      
      private function addFirstVip() : void
      {
         this.shouChong = new Mobile();
         this.shouChong.resourceUrl = URLUtil.getNpcSwf(shou_chong_npc_id);
         this.shouChong.x = 470;
         this.shouChong.y = 219;
         this.shouChong.buttonMode = true;
         MobileManager.addMobile(this.shouChong,MobileType.NPC);
         this.shouChong.addEventListener(MouseEvent.CLICK,this.onShouChong);
      }
      
      private function onShouChong(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("BellowPetKingPanel"),"");
      }
      
      private function onMail(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("ShuangMianMingWangStartPanel"),"");
      }
      
      private function initPetMelee() : void
      {
      }
      
      private function initBitMap() : void
      {
         var _loc1_:Mobile = null;
         for each(_loc1_ in MobileManager.getMobileVec(MobileType.NPC))
         {
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onNpcOver);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onNpcOut);
            _loc1_.animation.gotoAndStop(1);
         }
      }
      
      private function onNpcOver(param1:MouseEvent) : void
      {
         var _loc2_:Mobile = param1.currentTarget as Mobile;
         _loc2_.animation.gotoAndPlay(2);
      }
      
      private function onNpcOut(param1:MouseEvent) : void
      {
         var _loc2_:Mobile = param1.currentTarget as Mobile;
         if(_loc2_)
         {
            _loc2_.animation.gotoAndStop(1);
         }
      }
      
      private function initTwoOil() : void
      {
         ActiveCountManager.requestActiveCount(202344,this.getState);
      }
      
      private function getState(param1:uint, param2:uint) : void
      {
         this.oilBtn = SimpleButton(_map.content["oilBtn"]);
         if(param2 > 0)
         {
            this.oilBtn.visible = false;
         }
         else
         {
            this.oilBtn.addEventListener(MouseEvent.CLICK,this.toOil);
         }
      }
      
      protected function toOil(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         SwapManager.swapItem(1553,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            oilBtn.visible = false;
            ServerMessager.addMessage("获得一张2周年纪念券");
         });
      }
      
      private function onHaqi(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("HaQiPanel"),"正在打开...");
      }
      
      private function initTest() : void
      {
         var _loc1_:Mobile = new Mobile();
         _loc1_.resourceUrl = URLUtil.getNpcSwf(176);
         _loc1_.x = 464;
         _loc1_.y = 379;
         MobileManager.addMobile(_loc1_,MobileType.NPC);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onTest);
      }
      
      private function onTest(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,80012);
      }
      
      private function onBroadCast(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,1300);
      }
      
      private function initOpenSchool() : void
      {
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_270);
      }
      
      private function changeIndex() : void
      {
      }
      
      private function on1046(param1:MouseEvent) : void
      {
         var _loc2_:* = "http://jl.61.com/" + "?sid=" + GlobalsManager.session + "&uid=" + ActorManager.actorInfo.id + "&fromGameId=10";
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
      
      private function initTask() : void
      {
         this._npc = MobileManager.getMobile(180,MobileType.NPC);
         if(QuestManager.isAccepted(10146))
         {
            DisplayUtil.removeForParent(this._npc);
         }
         else
         {
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(180,"金",[[0,"我这里有的是财宝，当然，这些只属于那些勇敢而强大的赛尔！也许你可以继续我的脚步！做一名真正的赏金猎人！"]],["只是路过 ","领取赏金卡"],[null,function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
            QuestManager.accept(10146);
         }]);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         DisplayUtil.removeForParent(this._npc);
         SceneManager.changeScene(SceneType.LOBBY,730);
      }
      
      private function initVipBtn() : void
      {
      }
      
      private function onVip(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("VipNitisiNewPanel"),"正在打开...");
      }
      
      private function initNewQuest() : void
      {
         Quest53Processor.checkQuest();
      }
      
      private function addChrismasNpc() : void
      {
         if(DateUtil.isInTime(new Date(2012,11,21,10,0,0,0),new Date(2012,11,24,21,0,0,0)))
         {
            if(Boolean(this._saleNpc) && Boolean(this._saleNpc.parent))
            {
               DisplayUtil.removeForParent(this._saleNpc);
               this._saleNpc = null;
            }
            this._saleNpc = new Mobile();
            this._saleNpc.resourceUrl = URLUtil.getNpcSwf(176);
            this._saleNpc.x = 471;
            this._saleNpc.y = 258;
            this._saleNpc.buttonMode = true;
            TooltipManager.addCommonTip(this._saleNpc,"圣诞特卖，绝版回归");
            MobileManager.addMobile(this._saleNpc,MobileType.NPC);
            this._saleNpc.addEventListener(MouseEvent.CLICK,this.onSaleNpcClick);
         }
      }
      
      private function firstChargeSetInit() : void
      {
         this.addFirstNpc();
      }
      
      private function addFirstNpc() : void
      {
         this._firstNpc = new Mobile();
         this._firstNpc.resourceUrl = URLUtil.getNpcSwf(327);
         this._firstNpc.x = 607;
         this._firstNpc.y = 500;
         this._firstNpc.buttonMode = true;
         TooltipManager.addCommonTip(this._firstNpc,"星神降临");
         MobileManager.addMobile(this._firstNpc,MobileType.NPC);
         this._firstNpc.addEventListener(MouseEvent.CLICK,this.onFirstNpc);
      }
      
      private function onFirstNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         SwapManager.swapItem(2428,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
         });
      }
      
      private function firstChargeSetDispose() : void
      {
         if(this._firstNpc)
         {
            this._firstNpc.removeEventListener(MouseEvent.CLICK,this.onFirstNpc);
            DisplayUtil.removeForParent(this._firstNpc);
            this._firstNpc = null;
         }
      }
      
      private function onSaleNpcClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("ChrismasSalePanel"),"正在打开圣诞特卖面板...");
      }
      
      private function initNpc() : void
      {
         var _loc1_:Mobile = MobileManager.getMobile(156,MobileType.NPC);
         var _loc2_:Mobile = MobileManager.getMobile(157,MobileType.NPC);
         var _loc3_:Mobile = MobileManager.getMobile(152,MobileType.NPC);
         var _loc4_:Mobile = MobileManager.getMobile(158,MobileType.NPC);
         var _loc5_:Mobile = MobileManager.getMobile(333,MobileType.NPC);
         var _loc6_:Mobile = MobileManager.getMobile(332,MobileType.NPC);
         var _loc7_:Mobile = MobileManager.getMobile(389,MobileType.NPC);
         var _loc8_:Mobile = MobileManager.getMobile(390,MobileType.NPC);
         var _loc9_:Mobile = MobileManager.getMobile(391,MobileType.NPC);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClickAHandler,false,100);
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClickBHandler);
         _loc3_.addEventListener(MouseEvent.CLICK,this.onClickCHandler);
         _loc4_.addEventListener(MouseEvent.CLICK,this.onClickDHandler);
         _loc5_.addEventListener(MouseEvent.CLICK,this.onMobile333);
         _loc6_.addEventListener(MouseEvent.CLICK,this.onMobile332);
         _loc7_.addEventListener(MouseEvent.CLICK,this.onmobile7);
         _loc8_.addEventListener(MouseEvent.CLICK,this.onmobile8);
         _loc9_.addEventListener(MouseEvent.CLICK,this.onmobile9);
      }
      
      private function onmobile7(param1:MouseEvent) : void
      {
         StatisticsManager.newSendNovice("装置点击数","389号装置点击","人数、人次");
      }
      
      private function onmobile8(param1:MouseEvent) : void
      {
         StatisticsManager.newSendNovice("装置点击数","390号装置点击","人数、人次");
      }
      
      private function onmobile9(param1:MouseEvent) : void
      {
         StatisticsManager.newSendNovice("装置点击数","391号装置点击","人数、人次");
      }
      
      private function onmobile10(param1:MouseEvent) : void
      {
         StatisticsManager.newSendNovice("装置点击数","406号装置点击","人数、人次");
      }
      
      private function onmobile11(param1:MouseEvent) : void
      {
         StatisticsManager.newSendNovice("装置点击数","407号装置点击","人数、人次");
      }
      
      private function onMobile333(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_211);
      }
      
      private function onMobile332(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_212);
      }
      
      private function onMobile330(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_213);
      }
      
      private function initMikaMail() : void
      {
         _map.content["mikasnow"].visible = true;
         _map.content["mikasnow"].addEventListener(MouseEvent.CLICK,this.mikaMailHandler);
      }
      
      private function mikaMailHandler(param1:MouseEvent) : void
      {
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         if((_loc2_.month == 0 || _loc2_.month == 1 && _loc2_.date <= 13) && _loc2_.hours == 13)
         {
            TorchRelayorToolbar.playFullMovie();
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_110);
         }
         else
         {
            AlertManager.showAlert("活动还没开始，每天13:00-14:00米咔在【米咔的雪娃娃】中和你不见不散");
         }
      }
      
      private function onClickAHandler(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_103);
      }
      
      private function onClickBHandler(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_104);
      }
      
      private function onClickCHandler(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_105);
      }
      
      private function onClickDHandler(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_106);
      }
      
      private function initActivity() : void
      {
      }
      
      private function onClickBoy(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SwapManager.swapItem(669,1,function(param1:IDataInput):void
         {
            MorphUpdate.updateMorph();
         });
      }
      
      private function initGift() : void
      {
         this._giftMachine = new GiftMachine(0);
      }
      
      private function initUI() : void
      {
         this._leftBtn = _map.content["ad_0"];
         this._rightBtn = _map.content["ad_1"];
         TooltipManager.addCommonTip(this._leftBtn,"星际快报");
         TooltipManager.addCommonTip(this._rightBtn,"星际排行");
         this._leftBtn.addEventListener(MouseEvent.CLICK,this.onMouseLeftBtn);
         this._rightBtn.addEventListener(MouseEvent.CLICK,this.onMouseRightBtn);
      }
      
      private function onMouseLeftBtn(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("StarcraftReportPanel"),"正在打开星际快报...");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_203);
      }
      
      private function onMouseRightBtn(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("StarcraftRankPanel"),"正在打开星际排行榜...");
      }
      
      private function initXegg() : void
      {
         var _loc1_:Mobile = MobileManager.getMobile(157,MobileType.NPC);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClickXeggHandler);
      }
      
      private function onClickXeggHandler(param1:MouseEvent) : void
      {
      }
      
      private function xeggTalk() : void
      {
         var myself:Actor = null;
         var id:int = 0;
         if(DateUtil.inInDateScope(6,13,31,14,1))
         {
            myself = ActorManager.getActor();
            id = int(ActorManager.actorInfo.morphInfo.morphId);
            if(id == 3001)
            {
               if(this._flag1 == 2 || this._flag2 == 2 || this._flag3 == 1)
               {
                  NpcDialog.show(522,"X龙蛋",[[0,"我是蛋，但我不是傻蛋！你刚才不是兑换过了吗？怎么又来了……哼！"]],["……囧……"],[]);
               }
               else
               {
                  NpcDialog.show(522,"X龙蛋",[[0,"喂！哥们！你看到场景里老巫婆做的那锅汤了吗？如果你能变成个女蛋，我想我会愿意拿一切来跟你交换！（仅限10月27日13:30-14:00）"]],["先验验你有什么东西（看看）"],[function():void
                  {
                     ModuleManager.showModule(URLUtil.getAppModule("HalloweenXeggPanel"),"正在打开面板...");
                  }]);
               }
            }
            else
            {
               AlertManager.showAlert("你不是女龙蛋，走开！");
            }
         }
         else
         {
            NpcDialog.show(522,"X龙蛋",[[0,"拜托……你这招美蛋计对我不管用！都不是时间点了呢！下次！下次再来吧！"]],["我倒…………"],[]);
         }
      }
      
      private function clearOpenSchool() : void
      {
      }
      
      override public function dispose() : void
      {
         var _loc1_:Mobile = null;
         OptimizeManager.dispose();
         for each(_loc1_ in MobileManager.getMobileVec(MobileType.NPC))
         {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onNpcOver);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onNpcOut);
         }
         super.dispose();
         this.broadClickDispose();
      }
   }
}
