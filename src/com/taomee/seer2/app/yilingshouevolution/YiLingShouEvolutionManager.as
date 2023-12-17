package com.taomee.seer2.app.yilingshouevolution
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.scene.LobbyPanel;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DomainUtil;
   
   public class YiLingShouEvolutionManager
   {
      
      private static var fightID:int = 1576;
      
      private static var fightBOSSID:int = 1575;
      
      private static var _npc815:Mobile;
      
      private static var _npc307:Mobile;
      
      private static var _mouseObj:MouseClickHintSprite;
      
      private static var _resLib:ApplicationDomain;
      
      private static var _uiPanel:MovieClip;
      
      private static var _map:MapModel;
      
      private static var startMc:MovieClip;
      
      private static var _mc1:MovieClip;
      
      private static var BarMc:MovieClip;
      
      private static var oneKeyPass:SimpleButton;
      
      private static var passList:Vector.<MovieClip>;
      
      private static var swapBtnList:Vector.<SimpleButton>;
      
      private static var markMc:MovieClip;
      
      private static var exitBtn:SimpleButton;
      
      private static var pingBtn:SimpleButton;
      
      private static var itemMcList:Vector.<MovieClip>;
      
      private static var FOR_LIST:Array = [250092,250093,250094,250095];
      
      private static var DAY_LIST:int = 5048;
      
      private static var BUY_BOSS_COUNT:int = 605714;
      
      private static var passBossNums:int;
      
      private static var dreamValues:int;
      
      private static var numCont:int;
      
      private static var fightBossCount:int;
      
      private static var buyCount:int;
      
      private static var tipArr:Array = ["8W赛尔豆","精元晶石*10","进化芯片"];
       
      
      public function YiLingShouEvolutionManager()
      {
         super();
      }
      
      public static function setup(param1:MapModel) : void
      {
         _map = param1;
         LobbyPanel.instance.hide();
         getURL();
      }
      
      private static function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("yilingshouAct/yilingshouAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            initMc();
         });
      }
      
      private static function getMovie(param1:String) : DisplayObject
      {
         if(_resLib)
         {
            return DomainUtil.getDisplayObject(param1,_resLib);
         }
         return null;
      }
      
      private static function initMc() : void
      {
         var i:int;
         pingBtn = _map.content["pingBtn"];
         pingBtn.addEventListener(MouseEvent.CLICK,onPing);
         _uiPanel = _map.front["uiPanel"];
         _uiPanel.visible = false;
         markMc = _uiPanel["markMc"];
         markMc.visible = false;
         startMc = _uiPanel["startMc"];
         startMc.buttonMode = true;
         BarMc = _uiPanel["barMc"];
         oneKeyPass = _uiPanel["oneKeyPass"];
         oneKeyPass.addEventListener(MouseEvent.CLICK,onOneKeyFire);
         startMc.addEventListener(MouseEvent.CLICK,onStart);
         exitBtn = _uiPanel["exitBtn"];
         exitBtn.addEventListener(MouseEvent.CLICK,onExit);
         passList = new Vector.<MovieClip>();
         swapBtnList = new Vector.<SimpleButton>();
         itemMcList = new Vector.<MovieClip>();
         i = 0;
         while(i < 6)
         {
            passList.push(_uiPanel["passMcList" + i]);
            passList[i].visible = false;
            if(i < 3)
            {
               swapBtnList.push(_uiPanel["swapBtn" + i]);
               DisplayObjectUtil.disableButton(swapBtnList[i]);
               swapBtnList[i].addEventListener(MouseEvent.CLICK,onSwap);
               itemMcList.push(_uiPanel["itemMc" + i]);
            }
            i++;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(fightID == FightManager.currentFightRecord.initData.positionIndex)
            {
               NpcDialog.show(113,"超级NONO",[[0,"停，停一下，你去看看那个瓶子，说不定能有用！"]],["好的!"],[function():void
               {
                  pingBtn.visible = true;
                  _mouseObj = new MouseClickHintSprite();
                  _mouseObj.x = pingBtn.x + 20;
                  _mouseObj.y = pingBtn.y - 15;
                  _map.content.addChild(_mouseObj);
               }]);
            }
            if(fightBOSSID == FightManager.currentFightRecord.initData.positionIndex)
            {
               _uiPanel.visible = true;
               LobbyPanel.instance.hide();
            }
            if(1574 == FightManager.currentFightRecord.initData.positionIndex)
            {
               _uiPanel.visible = true;
               pingBtn.visible = false;
            }
            updateDate();
         }
         else
         {
            pingBtn.visible = false;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               passBossNums = par.infoVec[0];
               if(passBossNums == 0)
               {
                  _mc1 = getMovie("Mc1") as MovieClip;
                  _map.front.addChild(_mc1);
                  _mc1.gotoAndStop(1);
                  MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
                  {
                     _map.front.removeChild(_mc1);
                     _mc1 = null;
                     creatNPC815();
                  },true);
               }
               else
               {
                  _uiPanel.visible = true;
                  LobbyPanel.instance.hide();
                  updateDate();
               }
            });
         }
      }
      
      private static function onSwap(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var idx:int = swapBtnList.indexOf(e.currentTarget as SimpleButton);
         SwapManager.swapItem(3883,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            updateDate();
         },null,new SpecialInfo(1,idx + 1));
      }
      
      private static function onExit(param1:MouseEvent) : void
      {
         _uiPanel.visible = false;
         LobbyPanel.instance.show();
         pingBtn.visible = true;
         if(_mouseObj)
         {
            _mouseObj.visible = true;
         }
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private static function onPing(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         pingBtn.visible = false;
         ServerBufferManager.getServerBuffer(ServerBufferType.YILingShouEvolution_FIRST_PLAY,function(param1:ServerBuffer):void
         {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
            if(!_isPlay)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.YILingShouEvolution_FIRST_PLAY,1,1);
               _mc1 = getMovie("Mc2") as MovieClip;
               _map.front.addChild(_mc1);
               _mc1.gotoAndStop(1);
               MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
               {
                  _map.front.removeChild(_mc1);
                  _mc1 = null;
                  showUI();
               },true);
            }
            else
            {
               showUI();
            }
         });
      }
      
      private static function showUI() : void
      {
         _uiPanel.visible = true;
         LobbyPanel.instance.hide();
         if(_mouseObj)
         {
            _mouseObj.visible = false;
         }
         updateDate();
      }
      
      private static function onOneKeyFire(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ShopManager.buyItemForId(605712,function(param1:*):void
         {
            updateDate();
         });
      }
      
      private static function removeEvent() : void
      {
         oneKeyPass.removeEventListener(MouseEvent.CLICK,onOneKeyFire);
         startMc.removeEventListener(MouseEvent.CLICK,onStart);
      }
      
      private static function onStart(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if((e.currentTarget as MovieClip).currentFrame == 1)
         {
            ModuleManager.showAppModule("YiLingShouEvolutionFightPanel");
         }
         else if((e.currentTarget as MovieClip).currentFrame == 2)
         {
            if(fightBossCount <= 0)
            {
               ShopManager.buyItemForId(BUY_BOSS_COUNT,function(param1:*):void
               {
                  updateDate();
               });
            }
            else
            {
               firstPlayFullScreen(function():void
               {
                  pingBtn.visible = false;
                  _uiPanel.visible = false;
                  createNPC307();
               });
            }
         }
      }
      
      private static function createNPC307() : void
      {
         _npc307 = new Mobile();
         _npc307.setPostion(new Point(550,350));
         _npc307.resourceUrl = URLUtil.getNpcSwf(894);
         _npc307.labelPosition = MobileLabelPosition.OVER_HEAD;
         _npc307.label = "翼灵神";
         _npc307.buttonMode = true;
         MobileManager.addMobile(_npc307,MobileType.NPC);
         _npc307.addEventListener(MouseEvent.CLICK,onNpc307Click);
         _mouseObj = new MouseClickHintSprite();
         _mouseObj.x = 0;
         _mouseObj.y = -120;
         _npc307.addChild(_mouseObj);
      }
      
      private static function onNpc307Click(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(894,"翼灵神",[[0,"再也没有人可以阻止我了，再也没有！"]],["让我来！","哎哟妈呀，太猛了！"],[function():void
         {
            FightManager.startFightWithWild(fightBOSSID);
         }]);
      }
      
      private static function firstPlayFullScreen(param1:Function = null) : void
      {
         var callBack:Function = param1;
         ServerBufferManager.getServerBuffer(ServerBufferType.YILingShouEvolution_FIRST,function(param1:ServerBuffer):void
         {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
            if(!_loc2_)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.YILingShouEvolution_FIRST,1,1);
               MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("YiLingShouEvolutionFull"),callBack,true,true,2,true);
            }
            else if(callBack != null)
            {
               callBack();
            }
         });
      }
      
      private static function updateDate() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            passBossNums = par.infoVec[0];
            dreamValues = par.infoVec[1];
            numCont = par.infoVec[2];
            buyCount = par.infoVec[3];
            DayLimitManager.getDoCount(DAY_LIST,function(param1:int):void
            {
               if(ActorManager.actorInfo.vipInfo.isVip())
               {
                  fightBossCount = ActsHelperUtil.getCanNum(param1,buyCount,2);
               }
               else
               {
                  fightBossCount = ActsHelperUtil.getCanNum(param1,buyCount,1);
               }
               updateShow();
            });
         });
      }
      
      private static function updateShow() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < passBossNums)
         {
            passList[_loc1_].visible = true;
            _loc1_++;
         }
         if(numCont >= 50)
         {
            DisplayObjectUtil.enableButton(swapBtnList[0]);
         }
         else
         {
            DisplayObjectUtil.disableButton(swapBtnList[0]);
         }
         if(numCont >= 100)
         {
            DisplayObjectUtil.enableButton(swapBtnList[1]);
         }
         else
         {
            DisplayObjectUtil.disableButton(swapBtnList[1]);
         }
         if(numCont >= 200)
         {
            DisplayObjectUtil.enableButton(swapBtnList[2]);
         }
         else
         {
            DisplayObjectUtil.disableButton(swapBtnList[2]);
         }
         if(passBossNums == 6)
         {
            startMc.gotoAndStop(2);
            oneKeyPass.visible = false;
         }
         else
         {
            startMc.gotoAndStop(1);
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TooltipManager.addCommonTip(itemMcList[_loc1_],tipArr[_loc1_]);
            _loc1_++;
         }
         BarMc.gotoAndStop(int(numCont / 200 * 100) + 1);
         TooltipManager.addCommonTip(BarMc,numCont.toString());
         if(dreamValues)
         {
            markMc.visible = true;
            DisplayObjectUtil.disableButton(swapBtnList[2]);
         }
      }
      
      private static function creatNPC815() : void
      {
         _npc815 = new Mobile();
         _npc815.setPostion(new Point(360,367));
         _npc815.resourceUrl = URLUtil.getNpcSwf(893);
         _npc815.labelPosition = MobileLabelPosition.OVER_HEAD;
         _npc815.label = "坠天";
         _npc815.buttonMode = true;
         MobileManager.addMobile(_npc815,MobileType.NPC);
         _npc815.addEventListener(MouseEvent.CLICK,onNpcClick);
         _mouseObj = new MouseClickHintSprite();
         _mouseObj.x = 0;
         _mouseObj.y = -170;
         _npc815.addChild(_mouseObj);
      }
      
      private static function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(893,"坠天",[[0,"你敢点我？小心下一颗陨石就掉在你身上！"]],["坠天？！"],[function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"怎么会是你？"]],["（NONO，我们怎么办？）"],[function():void
            {
               NpcDialog.show(893,"坠天",[[0,"制霸天空，是我毕生的梦想，只要控制住了它就离梦想不远了！"]],["不可能！"],[function():void
               {
                  FightManager.startFightWithWild(fightID);
               }]);
            }]);
         }]);
      }
      
      public static function dispose() : void
      {
         if(_npc815)
         {
            _npc815.removeEventListener(MouseEvent.CLICK,onNpcClick);
            MobileManager.removeMobile(_npc815,MobileType.NPC);
            _npc815 = null;
         }
         if(_npc307)
         {
            _npc307.removeEventListener(MouseEvent.CLICK,onNpcClick);
            MobileManager.removeMobile(_npc307,MobileType.NPC);
            _npc307 = null;
         }
         if(_mouseObj)
         {
            DisplayObjectUtil.removeFromParent(_mouseObj);
            _mouseObj = null;
         }
         removeEvent();
      }
   }
}
