package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80313 extends MapProcessor
   {
       
      
      private var numTxt:TextField;
      
      private var skipBtn:SimpleButton;
      
      private var _gameCount:int;
      
      private var foreverLimit:Array;
      
      private var fightSecondID:Array;
      
      private var _buyCount:int;
      
      private var fightStep1:Boolean;
      
      private var fightStep2:Boolean;
      
      private var canFightNum:int;
      
      private var _npc:Mobile;
      
      public function MapProcessor_80313(param1:MapModel)
      {
         this.foreverLimit = [204742,204793];
         this.fightSecondID = [1224,1225];
         super(param1);
      }
      
      public static function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
      
      override public function init() : void
      {
         this.numTxt = _map.content["numTxt"];
         this.skipBtn = _map.content["skipBtn"];
         this.skipBtn.addEventListener(MouseEvent.CLICK,this.onSkip);
         this.initAct();
         this.checkState();
      }
      
      private function checkState() : void
      {
         ActiveCountManager.requestActiveCountList(this.foreverLimit,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            _buyCount = par.infoVec[0];
            fightStep1 = Boolean(BitUtil.getBit(par.infoVec[1],0));
            fightStep2 = Boolean(BitUtil.getBit(par.infoVec[1],1));
            DayLimitManager.getDoCount(1341,function(param1:int):void
            {
               var count:int = param1;
               if(ActorManager.actorInfo.vipInfo.isVip())
               {
                  canFightNum = getCanNum(count,_buyCount,2);
               }
               else
               {
                  canFightNum = getCanNum(count,_buyCount,1);
               }
               if(canFightNum > 0)
               {
                  initAct();
               }
               else
               {
                  TweenNano.delayedCall(3,function():void
                  {
                     ServerMessager.addMessage("今日免费挑战次数已用完！");
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     TweenNano.delayedCall(3,function():void
                     {
                        ModuleManager.showAppModule("MiuSiSuperStrengthenPanel");
                     });
                  });
               }
               numTxt.text = canFightNum.toString();
            });
         });
      }
      
      private function initAct() : void
      {
         this.createNpc();
      }
      
      private function onActDispose() : void
      {
         this.clearNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 200;
            this._npc.setPostion(new Point(460,400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(404);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(750,"超煞",[[0,"居然跑到奥林匹斯山了！你们这帮铁皮为了找魔石真是肯下功夫啊！ "]],["魔石在哪里？ ","我晕了"],[function():void
         {
            NpcDialog.show(752,"潘多拉",[[0,"在我这里，不过能不能拿走还要看你们的本事了！ "]],["好啊，那就来吧！  "],[function():void
            {
               NpcDialog.show(750,"超煞",[[0,"打败我们，魔石归你！ "]],["一言为定！  "],[function():void
               {
                  if(fightStep1 == false && fightStep2 == false)
                  {
                     SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchMap);
                     FightManager.startFightWithWild(fightSecondID[0]);
                  }
                  if(fightStep1 == true && fightStep2 == false)
                  {
                     SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchMap);
                     FightManager.startFightWithWild(fightSecondID[1]);
                  }
               }]);
            }]);
         }]);
      }
      
      private function onSwitchMap(param1:SceneEvent) : void
      {
         var result:uint = 0;
         var e:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA && this.fightSecondID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
         {
            if(this.fightSecondID[1] == FightManager.currentFightRecord.initData.positionIndex)
            {
               result = FightManager.fightWinnerSide;
               if(result == FightSide.LEFT)
               {
                  MovieClipUtil.playNpcTalkNew(URLUtil.getActivityFullScreen("MiuSiSuperStrengthen2"),2,[[1,0]],function():void
                  {
                     ServerMessager.addMessage("恭喜通关喽!");
                  });
               }
            }
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(3,function():void
            {
               ModuleManager.showAppModule("MiuSiSuperStrengthenPanel");
            });
         }
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
      
      private function onSkip(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ShopManager.buyItemForId(604195,function(param1:*):void
         {
            var p:* = param1;
            ServerMessager.addMessage("恭喜通关喽!");
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(3,function():void
            {
               ModuleManager.showAppModule("MiuSiSuperStrengthenPanel");
            });
         });
      }
   }
}
