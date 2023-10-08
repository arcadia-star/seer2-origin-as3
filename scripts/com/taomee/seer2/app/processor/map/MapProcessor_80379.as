package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_80379 extends MapProcessor
   {
       
      
      public var _mc:MovieClip;
      
      public var _callBack:Function = null;
      
      private var _npc:Mobile;
      
      private var fightID:Array;
      
      private var _kingMc:MovieClip;
      
      public function MapProcessor_80379(param1:MapModel)
      {
         this.fightID = [1413];
         super(param1);
      }
      
      override public function init() : void
      {
         RightToolbarConter.instance.hide();
         this.LoadSource(this.initMc);
         this.createNpc();
      }
      
      public function LoadSource(param1:Function = null) : void
      {
         this._callBack = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("silverriver"),LoadType.SWF,this.onLoadComplete);
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this._mc = param1.content as MovieClip;
         if(this._callBack != null)
         {
            this._callBack();
         }
      }
      
      private function initMc() : void
      {
         this._kingMc = this.getMc("kingMc");
         if(_map.front != null)
         {
            _map.front.addChild(this._kingMc);
         }
         if(VipManager.vipInfo.isVip())
         {
            MovieClip(this._kingMc.vipTip).gotoAndStop(2);
            this._kingMc.openVip.visible = false;
         }
         else
         {
            MovieClip(this._kingMc.vipTip).gotoAndStop(1);
            this._kingMc.openVip.visible = true;
         }
         SimpleButton(this._kingMc["buyPassBtn"]).addEventListener(MouseEvent.CLICK,this.onBuyPass);
         SimpleButton(this._kingMc["openVip"]).addEventListener(MouseEvent.CLICK,this.onOpenVip);
      }
      
      private function onOpenVip(param1:MouseEvent) : void
      {
         ModuleManager.closeForInstance(this);
         ModuleManager.showAppModule("VipRechargeBasePanel");
      }
      
      private function onBuyPass(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ShopManager.buyItemForId(605310,function(param1:*):void
         {
            RightToolbarConter.instance.show();
            SceneManager.changeScene(SceneType.LOBBY,70);
            ModuleManager.showAppModule("SilverRiverOutputPanel");
         });
      }
      
      public function getMc(param1:String) : MovieClip
      {
         return this._mc[param1];
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(600,400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(833);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onFight);
         }
      }
      
      private function onFight(param1:MouseEvent) : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchCompleted);
         FightManager.startFightWithWild(this.fightID[0]);
      }
      
      private function onSwitchCompleted(param1:SceneEvent) : void
      {
         var _loc2_:uint = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchCompleted);
            if(this.fightID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
            {
               _loc2_ = FightManager.fightWinnerSide;
               if(_loc2_ == FightSide.RIGHT)
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  ModuleManager.showAppModule("SilverRiverOutputFightPanel");
               }
               else if(_loc2_ == FightSide.LEFT)
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  ModuleManager.showAppModule("SilverRiverOutputPanel");
               }
               RightToolbarConter.instance.show();
            }
         }
      }
      
      override public function dispose() : void
      {
         RightToolbarConter.instance.show();
      }
   }
}
