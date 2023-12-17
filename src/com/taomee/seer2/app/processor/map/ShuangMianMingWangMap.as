package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.NumberCountForJimmy;
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
   import flash.events.MouseEvent;
   
   public class ShuangMianMingWangMap extends MapProcessor
   {
       
      
      private const map_id:Array = [80194,80195,80196,80197,80198,80199,80200];
      
      private const npc_id:Array = [653,654,655,656,657,658,659];
      
      private const fight_id:Array = [955,956,957,958,959,960,961];
      
      private const buy_chance_id:int = 603808;
      
      private var npc:Mobile;
      
      private var index:int;
      
      private var leftChance:int;
      
      private var buyChance:int;
      
      private var level:int;
      
      private var haveFight:int;
      
      private const lianCompleteLimit:int = 204136;
      
      private const buy_fight_level:int = 204140;
      
      private const have_fight_level:int = 1101;
      
      public function ShuangMianMingWangMap(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.index = this.map_id.indexOf(this._map.id);
         this.npc = MobileManager.getMobile(this.npc_id[this.index],MobileType.NPC);
         this.npc.buttonMode = true;
         this.npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ActiveCountManager.requestActiveCountList([this.buy_fight_level,this.lianCompleteLimit],function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            buyChance = par.infoVec[0];
            level = par.infoVec[1];
            DayLimitManager.getDoCount(have_fight_level,function(param1:uint):void
            {
               haveFight = param1;
               if(level > index)
               {
                  ModuleManager.showModule(URLUtil.getAppModule("ShuangMianMingWangMainPanel"),"",{
                     "show1":true,
                     "show2":true,
                     "show3":true
                  });
               }
               else
               {
                  if(ActorManager.actorInfo.vipInfo.isVip())
                  {
                     leftChance = NumberCountForJimmy.countLeftNum(haveFight,buyChance,4);
                  }
                  else
                  {
                     leftChance = NumberCountForJimmy.countLeftNum(haveFight,buyChance,3);
                  }
                  if(leftChance > 0)
                  {
                     fightNpc();
                  }
                  else
                  {
                     buyFight();
                  }
               }
            });
         });
      }
      
      private function buyFight() : void
      {
         var info:BuyPropInfo = new BuyPropInfo();
         info.itemId = this.buy_chance_id;
         ShopManager.buyVirtualItem(info);
         info.buyComplete = function(param1:*):void
         {
            fightNpc();
         };
      }
      
      private function fightNpc() : void
      {
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.onFightOver);
         FightManager.startFightWithBoss(this.fight_id[this.index]);
      }
      
      private function onFightOver(param1:FightStartEvent) : void
      {
         FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.onFightOver);
         if(FightManager.fightWinnerSide == FightSide.LEFT)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.changeScene);
            SceneManager.changeScene(SceneType.LOBBY,70);
         }
         else
         {
            ModuleManager.showModule(URLUtil.getAppModule("ShuangMianMingWangBuyPanel"),"",{"floor":this.level});
         }
      }
      
      private function changeScene(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.changeScene);
         ModuleManager.showModule(URLUtil.getAppModule("ShuangMianMingWangMainPanel"),"",{
            "show1":true,
            "show2":true,
            "show3":true
         });
      }
      
      override public function dispose() : void
      {
         this.npc.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.dispose();
      }
   }
}
