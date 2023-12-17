package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.BitUtil;
   
   public class MapProcessor_80318 extends MapProcessor
   {
       
      
      private var _npc:Mobile;
      
      private var NPCID:int = 818;
      
      private var fightBossID:Array;
      
      private var mark:InProgressMark;
      
      private var passBossNums:int;
      
      private var dreamValues:int;
      
      private var BuyBit:int;
      
      private var fightCount:int;
      
      private var buyCount:int;
      
      private var BUY_COUNT_ID:int = 604243;
      
      private var bar:MovieClip;
      
      private var exitBtn:SimpleButton;
      
      private var swapList:Vector.<SimpleButton>;
      
      private var hasEvent:Boolean;
      
      public function MapProcessor_80318(param1:MapModel)
      {
         this.fightBossID = [1269];
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
         this.bar = _map.front["bar"];
         this.exitBtn = _map.front["exitBtn"];
         this.swapList = new Vector.<SimpleButton>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.swapList.push(_map.front["swap" + _loc1_]);
            this.setBtnEnable(this.swapList[_loc1_],false);
            _loc1_++;
         }
         this.checkStates();
      }
      
      private function checkStates() : void
      {
         ActiveCountManager.requestActiveCountList([204820,204821,204822,204823],this.onActiveCount);
      }
      
      private function onActiveCount(param1:Parser_1142) : void
      {
         var par:Parser_1142 = param1;
         this.passBossNums = par.infoVec[0];
         this.dreamValues = par.infoVec[1];
         this.BuyBit = par.infoVec[2];
         this.buyCount = par.infoVec[3];
         DayLimitManager.getDoCount(1359,function(param1:int):void
         {
            if(ActorManager.actorInfo.vipInfo.isVip())
            {
               fightCount = getCanNum(param1,buyCount,2);
            }
            else
            {
               fightCount = getCanNum(param1,buyCount,1);
            }
            createNpc();
            updateShow();
            addEvent();
         });
      }
      
      private function addEvent() : void
      {
         if(this.hasEvent == true)
         {
            return;
         }
         this.hasEvent = true;
         this.exitBtn.addEventListener(MouseEvent.CLICK,this.onExit);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.swapList[_loc1_].addEventListener(MouseEvent.CLICK,this.onSwap);
            _loc1_++;
         }
      }
      
      private function onExit(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(1,function():void
         {
            ModuleManager.showAppModule("HuanLingShouSuperStrengthenPanel");
         });
      }
      
      private function removeEvent() : void
      {
         this.hasEvent = false;
         this.exitBtn.removeEventListener(MouseEvent.CLICK,this.onExit);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.swapList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onSwap);
            _loc1_++;
         }
      }
      
      private function onSwap(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var idx:int = this.swapList.indexOf(e.target as SimpleButton);
         SwapManager.swapItem(3223,1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(1,function():void
            {
               SceneManager.changeScene(SceneType.COPY,80318);
            });
            checkStates();
         },null,new SpecialInfo(1,idx));
      }
      
      override public function dispose() : void
      {
         this.removeEvent();
      }
      
      private function updateShow() : void
      {
         if(this.dreamValues > 200)
         {
            this.dreamValues = 200;
         }
         this.bar.scaleY = this.dreamValues / 200;
         if(this.dreamValues >= 50 && this.dreamValues < 100)
         {
            this.setBtnEnable(this.swapList[0],true);
         }
         else if(this.dreamValues >= 100 && this.dreamValues < 200)
         {
            this.setBtnEnable(this.swapList[0],true);
            this.setBtnEnable(this.swapList[1],true);
         }
         else if(this.dreamValues >= 200)
         {
            this.setBtnEnable(this.swapList[0],true);
            this.setBtnEnable(this.swapList[1],true);
            this.setBtnEnable(this.swapList[2],true);
         }
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            if(BitUtil.getBit(this.BuyBit,_loc1_))
            {
               this.setBtnEnable(this.swapList[_loc1_],false);
            }
            _loc1_++;
         }
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 200;
            this._npc.setPostion(new Point(650,300));
            this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this.mark = new InProgressMark();
            this.mark.y = -70;
            this._npc.addEventListener(MouseEvent.CLICK,this.onMark);
            this._npc.addChild(this.mark);
         }
      }
      
      private function onMark(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(818,"幻灵神",[[0,"就在幻灵的火焰中唤醒我的究极力量吧！（你今天还有" + this.fightCount + "次挑战机会，挑战获得幻灵，它可以兑换幻灵之芯）"]],["我会帮助你！"," 我……我办不到啊~"],[function():void
         {
            if(fightCount <= 0)
            {
               ShopManager.buyItemForId(BUY_COUNT_ID,function(param1:*):void
               {
                  checkStates();
               });
            }
            else
            {
               FightManager.startFightWithWild(fightBossID[0]);
            }
         }]);
      }
      
      private function setBtnEnable(param1:SimpleButton, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [];
         }
         else
         {
            ColorFilter.setGrayscale(param1);
         }
         param1.mouseEnabled = param2;
      }
   }
}
