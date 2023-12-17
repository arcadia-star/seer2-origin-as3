package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80439 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [1672,1673];
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1544,1545,1546,1547,1548]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1,1]);
      
      private static const NPC_NAME_LIST:Vector.<String> = Vector.<String>(["奥德曼","菲利亚斯","阿吒婆拘","温柏","拉达曼迪"]);
      
      private static const NPC_RES_LIST:Vector.<int> = Vector.<int>([883,851,886,884,885]);
      
      private static const NPC_WH_LIST:Array = [[100,160],[100,160],[100,160],[100,160],[100,160]];
      
      private static const NPC_POS_LIST:Vector.<Point> = Vector.<Point>([new Point(225,425),new Point(420,465),new Point(632,495),new Point(840,473),new Point(454,467)]);
      
      private static const TIP_POS:Vector.<Point> = Vector.<Point>([new Point(235,255),new Point(415,264),new Point(629,305),new Point(838,286),new Point(464,287)]);
      
      private static var _info:DayLimitListInfo;
      
      private static var _playSceneState:Vector.<int> = Vector.<int>([0,0]);
       
      
      private var _fightNum:TextField;
      
      private var _npcList:Vector.<Mobile>;
      
      private var _boss:Mobile;
      
      private var _killedEffectList:Vector.<MovieClip>;
      
      private var _canFightNum:int;
      
      private var _curIndex:int;
      
      public function MapProcessor_80439(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         this.initKilledEffect();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this._curIndex = FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex);
            if(this._curIndex != -1)
            {
               this.getDataHandleFromBattle();
            }
         }
         else
         {
            this.getDataHandleNormal();
         }
      }
      
      private function getDataHandleNormal() : void
      {
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            _info = param1;
            _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),0,VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
            initSet();
         });
      }
      
      private function getDataHandleFromBattle() : void
      {
         if(FightManager.fightWinnerSide == FightSide.LEFT)
         {
            if(this._curIndex <= 3)
            {
               this.playKilledEffect();
            }
         }
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            _info = info;
            _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),0,VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
            if(_canFightNum > 0)
            {
               initSet();
            }
            else
            {
               ServerMessager.addMessage("今日免费挑战次数已用完了！");
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(3,function():void
               {
                  ModuleManager.showAppModule("HaDiSiActPanel");
               });
            }
         });
      }
      
      private function initSet() : void
      {
         this.hideLobbyMenu();
         this._fightNum = _map.front["fightNum"];
         this._fightNum.text = this._canFightNum.toString();
         this.updateBossState();
      }
      
      private function initKilledEffect() : void
      {
         this._killedEffectList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this._killedEffectList.push(_map.content["killedEffect" + _loc1_]);
            this._killedEffectList[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function playKilledEffect() : void
      {
         this._killedEffectList[this._curIndex].visible = true;
         MovieClipUtil.playMc(this._killedEffectList[this._curIndex],2,this._killedEffectList[this._curIndex].totalFrames,function():void
         {
            if(_killedEffectList)
            {
               _killedEffectList[_curIndex].gotoAndStop(1);
               _killedEffectList[_curIndex].visible = false;
            }
         });
      }
      
      private function updateBossState() : void
      {
         if(_info.getCount(DAY_LIST[1]) != 15)
         {
            if(_info.getCount(DAY_LIST[1]) == 0)
            {
               if(_playSceneState[0] == 0)
               {
                  _playSceneState[0] = 1;
                  this.playSceneMC("haDiSiAct/HaDiSiAct7",function():void
                  {
                     addSmallBoss();
                  });
               }
               else
               {
                  this.addSmallBoss();
               }
            }
            else
            {
               this.addSmallBoss();
            }
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this._curIndex = FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex);
            if(this._curIndex <= 3 && _playSceneState[1] == 0)
            {
               _playSceneState[1] = 1;
               TweenNano.delayedCall(2,function():void
               {
                  playSceneMC("haDiSiAct/HaDiSiAct8",function():void
                  {
                     addBigBoss();
                  });
               });
            }
            else
            {
               this.addBigBoss();
            }
         }
         else
         {
            this.addBigBoss();
         }
      }
      
      private function addSmallBoss() : void
      {
         var _loc1_:Mobile = null;
         this._npcList = Vector.<Mobile>([null,null,null,null]);
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(!BitUtil.getBit(_info.getCount(DAY_LIST[1]),_loc2_))
            {
               _loc1_ = this.createNpc(NPC_RES_LIST[_loc2_],NPC_POS_LIST[_loc2_],NPC_NAME_LIST[_loc2_],NPC_WH_LIST[_loc2_]);
               this._npcList[_loc2_] = _loc1_;
               _loc1_.addEventListener(MouseEvent.CLICK,this.onNpcClick);
               SeatTipsManager.registerSeat(TIP_POS[_loc2_],_map.id);
            }
            _loc2_++;
         }
      }
      
      private function addBigBoss() : void
      {
         if(!this._boss)
         {
            this._boss = this.createNpc(NPC_RES_LIST[4],NPC_POS_LIST[4],NPC_NAME_LIST[4],NPC_WH_LIST[4]);
            this._boss.addEventListener(MouseEvent.CLICK,this.onBossClick);
            SeatTipsManager.registerSeat(TIP_POS[4],_map.id);
         }
      }
      
      private function clearBoss() : void
      {
         this._boss.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         DisplayUtil.removeForParent(this._boss);
         SeatTipsManager.removeSeat(TIP_POS[4],_map.id);
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
      
      private function createNpc(param1:int, param2:Point, param3:String, param4:Array) : Mobile
      {
         var _loc5_:Mobile;
         (_loc5_ = new Mobile()).width = param4[0];
         _loc5_.height = param4[1];
         _loc5_.setPostion(param2);
         _loc5_.resourceUrl = URLUtil.getNpcSwf(param1);
         _loc5_.labelPosition = MobileLabelPosition.OVER_HEAD;
         _loc5_.label = param3;
         _loc5_.labelImage.y = -_loc5_.height - 10;
         _loc5_.buttonMode = true;
         MobileManager.addMobile(_loc5_,MobileType.NPC);
         return _loc5_;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var _loc2_:int = this._npcList.indexOf(param1.currentTarget as Mobile);
         FightManager.startFightWithWild(FIGHT_INDEX_LIST[_loc2_]);
      }
      
      private function clearNpc() : void
      {
         var _loc1_:int = 0;
         if(this._npcList)
         {
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(this._npcList[_loc1_])
               {
                  this._npcList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onNpcClick);
                  DisplayUtil.removeForParent(this._npcList[_loc1_]);
                  SeatTipsManager.removeSeat(TIP_POS[_loc1_],_map.id);
               }
               _loc1_++;
            }
            this._npcList = null;
         }
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
         this.clearNpc();
         this._fightNum = null;
         this._npcList = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
