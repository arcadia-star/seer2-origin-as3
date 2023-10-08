package com.taomee.seer2.app.processor.activity.dreamGift
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   
   public class DreamGiftAct
   {
      
      private static const DAY_LIST:Array = [1712,1713,1714];
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1600,1601,1602]);
      
      private static const CLICK_SWAP:int = 4001;
      
      private static const NUM_LIST:Vector.<int> = Vector.<int>([20,4,10]);
      
      public static var HANDLE:int;
      
      private static var _isClickItem:Boolean = false;
      
      private static var _clickIndexList:Vector.<int> = Vector.<int>([]);
      
      private static var _selectIndex:int;
       
      
      private var _clickTip:MovieClip;
      
      private var _getGift:MovieClip;
      
      private var _clickItemList:Vector.<MovieClip>;
      
      private var _boss:MovieClip;
      
      private var _petList:Vector.<SpawnedPet>;
      
      private var _map:MapModel;
      
      private var _resLib:ApplicationDomain;
      
      private var _info:DayLimitListInfo;
      
      public function DreamGiftAct(param1:MapModel)
      {
         super();
         this._map = param1;
         this.initSet();
         this.initEvent();
         this.update();
      }
      
      private function curHandleShow() : void
      {
         if(HANDLE == 0)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[0])
               {
                  _clickIndexList.push(_selectIndex);
                  this._clickTip.visible = false;
               }
            }
            else
            {
               this._clickTip.visible = true;
            }
            this.clickItemShow();
         }
         if(HANDLE == 1)
         {
            this._clickTip.visible = false;
            this._boss.visible = true;
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[1])
               {
                  if(FightManager.isWinWar())
                  {
                  }
               }
            }
         }
         if(HANDLE == 2)
         {
            this._clickTip.visible = false;
            this.createPet();
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[2])
               {
                  if(FightManager.isWinWar())
                  {
                  }
               }
            }
         }
         if(this._info.getCount(DAY_LIST[HANDLE]) >= NUM_LIST[HANDLE])
         {
            ServerMessager.addMessage("当前活动已完成!");
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(2,function():void
            {
               ModuleManager.showAppModule("DreamGiftGetPanel");
            });
         }
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function clickItemShow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = NUM_LIST[0] - this._info.getCount(DAY_LIST[0]);
         if(_clickIndexList.length == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < NUM_LIST[0])
            {
               if(_isClickItem)
               {
                  if(_loc2_ < _loc1_)
                  {
                     this._clickItemList[_loc2_].visible = true;
                  }
                  else
                  {
                     this._clickItemList[_loc2_].visible = false;
                  }
               }
               else
               {
                  this._clickItemList[_loc2_].visible = false;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = 0;
            _loc2_ = 0;
            while(_loc2_ < NUM_LIST[0])
            {
               if(_clickIndexList.indexOf(_loc2_) != -1)
               {
                  this._clickItemList[_loc2_].visible = false;
               }
               else
               {
                  _loc3_++;
                  if(_loc3_ <= _loc1_)
                  {
                     this._clickItemList[_loc2_].visible = true;
                  }
                  else
                  {
                     this._clickItemList[_loc2_].visible = false;
                  }
               }
               _loc2_++;
            }
         }
      }
      
      private function initSet() : void
      {
         this._clickTip = this._map.content["clickTip"];
         this._getGift = this._map.content["getGift"];
         this._clickItemList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            this._clickItemList.push(this._map.content["clickItem" + _loc1_]);
            this._clickItemList[_loc1_].buttonMode = true;
            this._clickItemList[_loc1_].visible = false;
            _loc1_++;
         }
         this._boss = this._map.content["boss"];
         this._boss.buttonMode = true;
         this._boss.visible = false;
      }
      
      private function initEvent() : void
      {
         var _loc1_:MovieClip = null;
         this._getGift.addEventListener(MouseEvent.CLICK,this.onGetGift);
         this._boss.addEventListener(MouseEvent.CLICK,this.onBoss);
         for each(_loc1_ in this._clickItemList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickItem);
         }
      }
      
      private function onClickItem(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         _selectIndex = this._clickItemList.indexOf(evt.currentTarget);
         var randomVal:int = ActsHelperUtil.getRandom(1,100);
         if(randomVal <= 80)
         {
            this.setClickItemDisable(false);
            SwapManager.swapItem(CLICK_SWAP,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               _clickIndexList.push(_selectIndex);
               update();
            });
         }
         else
         {
            this.setClickItemDisable(false);
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
         }
      }
      
      private function onBoss(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(FIGHT_INDEX_LIST[1]);
      }
      
      private function onGetGift(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         _isClickItem = true;
         this._clickTip.visible = true;
         this._getGift.removeEventListener(MouseEvent.CLICK,this.onGetGift);
         MovieClipUtil.playMc(this._getGift,2,this._getGift.totalFrames,function():void
         {
            _getGift.gotoAndStop(1);
            clickItemShow();
         });
      }
      
      private function getServerData(param1:Function = null) : void
      {
         var callBack:Function = param1;
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            _info = param1;
            if(callBack != null)
            {
               callBack();
            }
         });
      }
      
      private function setFuncDisable() : void
      {
         this.setClickItemDisable(false);
         this._boss.mouseEnabled = this._boss.mouseChildren = false;
      }
      
      private function setClickItemDisable(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this._clickItemList)
         {
            _loc2_.mouseEnabled = _loc2_.mouseChildren = param1;
         }
      }
      
      private function update() : void
      {
         this.setFuncDisable();
         this.getServerData(function():void
         {
            curHandleShow();
            setClickItemDisable(true);
            _boss.mouseEnabled = _boss.mouseChildren = true;
         });
      }
      
      private function createPet() : void
      {
         var _loc2_:SpawnedPet = null;
         this._petList = new Vector.<SpawnedPet>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new SpawnedPet(688,FIGHT_INDEX_LIST[2],20);
            _loc2_.name = "草莓猫";
            MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
            this._petList.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:MovieClip = null;
         if(this._getGift)
         {
            this._getGift.removeEventListener(MouseEvent.CLICK,this.onGetGift);
            this._getGift = null;
         }
         if(this._boss)
         {
            this._boss.removeEventListener(MouseEvent.CLICK,this.onBoss);
            this._boss = null;
         }
         if(this._clickItemList)
         {
            for each(_loc1_ in this._clickItemList)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickItem);
            }
            this._clickItemList = null;
         }
         this._clickTip = null;
         this._petList = null;
      }
   }
}
