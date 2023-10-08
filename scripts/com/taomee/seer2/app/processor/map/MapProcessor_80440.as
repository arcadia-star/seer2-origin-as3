package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.popup.alert.IAlert;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.FightHelpUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80440 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [5024,5025];
      
      private static const FOR_LIST:Array = [250037,250038,250039,250040,250041,250043,250042];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3822]);
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1555,1556]);
      
      private static const FIGHT_SMALL_BOSS_RULE:Vector.<int> = Vector.<int>([3,3]);
      
      private static const FIGHT_BIG_BOSS_RULE:Vector.<int> = Vector.<int>([1,2]);
      
      private static const FIGHT_RES_LIST:Array = [[1128,430,95,897],[1129,430,95,897],[1127,378,559,616],[1351,378,559,616],[1250,646,893,660]];
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605600,605601,605602,605603,605604,605605,605610,605613,605606]);
      
      private static const TIP_POS:Vector.<Point> = Vector.<Point>([new Point(282,191),new Point(435,314),new Point(629,337),new Point(791,329),new Point(912,189),new Point(616,180)]);
      
      private static const BBS_ID:int = 150;
      
      private static var _info:DayLimitListInfo;
      
      private static var _par:Parser_1142;
       
      
      private var _fightNum:TextField;
      
      private var _fightHelpUtil:FightHelpUtil;
      
      private var _timeUI:MovieClip;
      
      private var _timeTxt:TextField;
      
      private var _miPass:SimpleButton;
      
      private var _fightList:Vector.<MovieClip>;
      
      private var _fightMiPassList:Vector.<SimpleButton>;
      
      private var _smallFightTip:MovieClip;
      
      private var _needWinNum:TextField;
      
      private var _callEffectList:Vector.<MovieClip>;
      
      private var _curSmallBossNum:int;
      
      private var _curBigBossNum:int;
      
      private var _leaveTime:int;
      
      private var _curIndex:int;
      
      public function MapProcessor_80440(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         this.initSet();
         this.initEvent();
         this.update();
      }
      
      private function setFuncDisable() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._fightList)
         {
            _loc1_.mouseEnabled = _loc1_.mouseChildren = false;
         }
      }
      
      private function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         this.setFuncDisable();
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               var i:int = 0;
               var item:MovieClip = null;
               var curBossIndex:int = 0;
               var info:DayLimitListInfo = param1;
               _info = info;
               _curSmallBossNum = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[0]),par.infoVec[0],VipManager.vipInfo.isVip() ? FIGHT_SMALL_BOSS_RULE[1] : FIGHT_SMALL_BOSS_RULE[0]);
               _curBigBossNum = ActsHelperUtil.getCanNum(par.infoVec[1],par.infoVec[5],VipManager.vipInfo.isVip() ? FIGHT_BIG_BOSS_RULE[1] : FIGHT_BIG_BOSS_RULE[0]);
               Tick.instance.removeRender(timeUpdate);
               clearAllTip();
               if(par.infoVec[2] < 5)
               {
                  Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
                  _smallFightTip.visible = true;
                  i = 0;
                  while(i < 5)
                  {
                     if(i <= par.infoVec[2] - 1)
                     {
                        _fightList[i].gotoAndStop(2);
                        _fightMiPassList[i].visible = false;
                        (_fightList[i]["winMark"] as MovieClip).visible = true;
                     }
                     else if(i == par.infoVec[2])
                     {
                        _curIndex = i;
                        SeatTipsManager.registerSeat(TIP_POS[_curIndex],_map.id);
                        curBossIndex = (FIGHT_RES_LIST[i] as Array).indexOf(par.infoVec[3]);
                        _fightList[i].gotoAndStop(curBossIndex + 2);
                        _fightMiPassList[i].visible = true;
                        if(_fightList[i].currentFrame == 2)
                        {
                           (_fightList[i]["winMark"] as MovieClip).visible = false;
                           _needWinNum.text = "0";
                        }
                        else
                        {
                           _needWinNum.text = (10 - par.infoVec[6]).toString();
                        }
                     }
                     else
                     {
                        _fightList[i].gotoAndStop(1);
                        _fightMiPassList[i].visible = false;
                     }
                     i++;
                  }
                  _fightList[5].gotoAndStop(1);
                  if(VipManager.vipInfo.isVip())
                  {
                     _timeUI.visible = false;
                  }
                  else if(TimeManager.getPrecisionServerTime() < info.getCount(DAY_LIST[1]))
                  {
                     _timeUI.visible = true;
                     _leaveTime = info.getCount(DAY_LIST[1]) - TimeManager.getPrecisionServerTime();
                     _timeTxt.text = DateUtil.getMS(_leaveTime);
                     Tick.instance.addRender(timeUpdate,1000);
                  }
                  else
                  {
                     _timeUI.visible = false;
                  }
                  _fightNum.text = _curSmallBossNum.toString();
               }
               else
               {
                  _fightNum.text = _curBigBossNum.toString();
                  _curIndex = 5;
                  SeatTipsManager.registerSeat(TIP_POS[_curIndex],_map.id);
                  _smallFightTip.visible = false;
                  _timeUI.visible = false;
                  _fightList[5].gotoAndStop(2);
                  if(Boolean(_par) && _par.infoVec[2] < 5)
                  {
                     setBossVisible(false);
                     clearAllTip();
                     setAlertVisible(false);
                     playSceneMC("KuBeiSaSuperProcessAct1",function():void
                     {
                        setBossVisible(true);
                        setAlertVisible(true);
                        SeatTipsManager.registerSeat(TIP_POS[5],_map.id);
                     });
                  }
                  i = 0;
                  while(i < 5)
                  {
                     _fightList[i].gotoAndStop(2);
                     _fightMiPassList[i].visible = false;
                     (_fightList[i]["winMark"] as MovieClip).visible = true;
                     i++;
                  }
                  if(par.infoVec[4] == 1 || par.infoVec[4] == 2)
                  {
                     _fightList[5].gotoAndStop(2);
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     TweenNano.delayedCall(2,function():void
                     {
                        ServerMessager.addMessage("恭喜挑战成功，赶快去超进化吧!");
                        ModuleManager.showAppModule("KuBeiSaSuperProcessPanel");
                     });
                  }
                  else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[1] && FightManager.fightWinnerSide == FightSide.RIGHT)
                  {
                     ModuleManager.showAppModule("KuBeiSaSuperProcessFailPanel");
                  }
               }
               _par = par;
               for each(item in _fightList)
               {
                  item.mouseEnabled = item.mouseChildren = true;
               }
               if(callBack != null)
               {
                  callBack();
               }
            });
         });
      }
      
      private function setAlertVisible(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < LayerManager.topLayer.numChildren)
         {
            _loc2_ = LayerManager.topLayer.getChildAt(_loc3_);
            if(_loc2_ is IAlert)
            {
               _loc2_.visible = param1;
            }
            _loc3_++;
         }
      }
      
      private function clearAllTip() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < TIP_POS.length)
         {
            SeatTipsManager.removeSeat(TIP_POS[_loc1_],_map.id);
            _loc1_++;
         }
      }
      
      private function timeUpdate(param1:uint) : void
      {
         --this._leaveTime;
         this._timeTxt.text = DateUtil.getMS(this._leaveTime);
         if(this._leaveTime <= 0)
         {
            Tick.instance.removeRender(this.timeUpdate);
            this._timeUI.visible = false;
            this.update();
         }
      }
      
      private function setBossVisible(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this._fightList)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function initSet() : void
      {
         this.hideLobbyMenu();
         this._fightNum = _map.front["fightNum"];
         this._fightHelpUtil = new FightHelpUtil(_map.front["petBag"],_map.front["getBlood"],_map.front["itemShop"],_map.front["goBBS"],{"bbsId":BBS_ID});
         this._timeUI = _map.front["timeUI"];
         this._timeUI.visible = false;
         this._timeTxt = this._timeUI["timeTxt"];
         this._miPass = this._timeUI["miPass"];
         this._fightList = new Vector.<MovieClip>();
         this._fightMiPassList = new Vector.<SimpleButton>();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            this._fightList.push(_map.content["fight" + _loc1_]);
            this._fightList[_loc1_].buttonMode = true;
            if(_loc1_ <= 4)
            {
               this._fightMiPassList.push(this._fightList[_loc1_]["miPass"] as SimpleButton);
            }
            _loc1_++;
         }
         this._smallFightTip = _map.front["smallFightTip"];
         this._needWinNum = this._smallFightTip["needWinNum"];
         this._smallFightTip.visible = false;
         this._callEffectList = new Vector.<MovieClip>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this._callEffectList.push(_map.content["callEffect" + _loc1_]);
            this._callEffectList[_loc1_].visible = this._callEffectList[_loc1_].mouseEnabled = this._callEffectList[_loc1_].mouseChildren = false;
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._fightList[_loc1_].addEventListener(MouseEvent.CLICK,this.onFightSmallBoss);
            this._fightMiPassList[_loc1_].addEventListener(MouseEvent.CLICK,this.onMiPass);
            _loc1_++;
         }
         this._fightList[5].addEventListener(MouseEvent.CLICK,this.onFightBigBoss);
         this._miPass.addEventListener(MouseEvent.CLICK,this.onCdMiPass);
      }
      
      private function onCdMiPass(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ShopManager.buyItemForId(MI_ID_LIST[8],function():void
         {
            update();
         });
      }
      
      private function onFightSmallBoss(param1:MouseEvent) : void
      {
         var curSmallBoss:MovieClip = null;
         var index:int = 0;
         var evt:MouseEvent = param1;
         if(this._timeUI.visible)
         {
            return;
         }
         curSmallBoss = evt.currentTarget as MovieClip;
         index = this._fightList.indexOf(curSmallBoss);
         if(this._curIndex != index)
         {
            return;
         }
         if(curSmallBoss.currentFrame == 1)
         {
            curSmallBoss.mouseEnabled = curSmallBoss.mouseChildren = false;
            SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               new SwapInfo(data);
               _callEffectList[index].visible = true;
               _map.content.setChildIndex(_callEffectList[index],_map.content.numChildren - 1);
               MovieClipUtil.playMc(_callEffectList[index],2,_callEffectList[index].totalFrames,function():void
               {
                  _callEffectList[index].visible = false;
                  _callEffectList[index].gotoAndStop(1);
                  update();
               });
            },function(param1:uint):void
            {
               curSmallBoss.mouseEnabled = curSmallBoss.mouseChildren = true;
            });
         }
         else
         {
            if(curSmallBoss.currentFrame == 2 && (curSmallBoss["winMark"] as MovieClip).visible)
            {
               return;
            }
            if(this._curSmallBossNum > 0)
            {
               FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
            }
            else
            {
               ShopManager.buyItemForId(MI_ID_LIST[5],function():void
               {
                  update(function():void
                  {
                     FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
                  });
               });
            }
         }
      }
      
      private function onMiPass(param1:MouseEvent) : void
      {
         var index:int;
         var curSmallBoss:MovieClip;
         var evt:MouseEvent = param1;
         evt.stopImmediatePropagation();
         index = this._fightMiPassList.indexOf(evt.currentTarget);
         curSmallBoss = (evt.currentTarget as SimpleButton).parent as MovieClip;
         if(curSmallBoss.currentFrame == 2 && (curSmallBoss["winMark"] as MovieClip).visible)
         {
            return;
         }
         ShopManager.buyItemForId(MI_ID_LIST[index],function():void
         {
            update();
         });
      }
      
      private function onFightBigBoss(param1:MouseEvent) : void
      {
         var curSmallBoss:MovieClip;
         var evt:MouseEvent = param1;
         if(this._curIndex != 5)
         {
            return;
         }
         curSmallBoss = evt.currentTarget as MovieClip;
         if(curSmallBoss.currentFrame == 1)
         {
            SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               update();
            });
         }
         else if(this._curBigBossNum > 0)
         {
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[1]);
         }
         else
         {
            ShopManager.buyItemForId(MI_ID_LIST[6],function():void
            {
               update(function():void
               {
                  FightManager.startFightWithWild(FIGHT_INDEX_LIST[1]);
               });
            });
         }
      }
      
      private function playSceneMC(param1:String, param2:Function) : void
      {
         var resName:String = param1;
         var afterFun:Function = param2;
         MovieClipUtil.getSwfContent(URLUtil.getActivityFullScreen(resName),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            LayerManager.topLayer.addChild(mc);
            MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(mc);
               mc.gotoAndStop(1);
               if(afterFun != null)
               {
                  afterFun(mc);
               }
            },true);
         });
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(FIGHT_INDEX_LIST[4]);
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function onActDispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._fightList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onFightSmallBoss);
            this._fightMiPassList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onMiPass);
            _loc1_++;
         }
         this._fightList[5].removeEventListener(MouseEvent.CLICK,this.onFightBigBoss);
         this._miPass.removeEventListener(MouseEvent.CLICK,this.onCdMiPass);
         Tick.instance.removeRender(this.timeUpdate);
         this._fightHelpUtil.dispose();
         this.clearAllTip();
         this._fightNum = null;
         this._fightHelpUtil = null;
         this._timeUI = null;
         this._timeTxt = null;
         this._fightList = null;
         this._fightMiPassList = null;
         this._miPass = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
