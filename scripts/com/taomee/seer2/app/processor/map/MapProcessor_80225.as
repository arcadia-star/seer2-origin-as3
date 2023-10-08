package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_80225 extends MapProcessor
   {
       
      
      private const FIGHT_INDEX:uint = 1099;
      
      private const DAY_LIMIT_ID:uint = 1233;
      
      private const BUY_COUNT:uint = 204452;
      
      private const BUY_FIGHT_COUNT_ID:uint = 603949;
      
      private const BUY_PASS_ID:uint = 603950;
      
      private var npc:MovieClip;
      
      private var leftCount:int;
      
      public function MapProcessor_80225(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.npc = _map.content["eyePet"];
         this.npc.mouseChildren = false;
         this.npc.buttonMode = true;
         this.npc.addEventListener(MouseEvent.CLICK,this.onNpc);
         DayLimitManager.getDoCount(this.DAY_LIMIT_ID,this.onDay);
         SeatTipsManager.registerSeat(new Point(478,125),80225);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         SeatTipsManager.removeSeat(new Point(478,125),80225);
         this.npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function onDay(param1:uint) : void
      {
         this.leftCount = param1;
         ActiveCountManager.requestActiveCountList([this.BUY_COUNT],this.onActive);
      }
      
      private function onActive(param1:Parser_1142) : void
      {
         this.leftCount = this.getCanNum(this.leftCount,param1.infoVec[0],1);
      }
      
      public function getCanNum(param1:int, param2:int, param3:int) : int
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
      
      protected function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.leftCount != 0)
         {
            NpcDialog.show(113,"超级nono ",[[0,"击败愤怒的目灵神，即可得到目灵神进化芯片！每天1次挑战机会！"]],["确定 ","取消"],[function():void
            {
               startFight();
            }]);
         }
         else
         {
            NpcDialog.show(113,"超级nono ",[[0,"今天的挑战次数已经用尽，是否花费星钻立即挑战？"]],["开始挑战 ","准备一下"],[function():void
            {
               ShopManager.buyItemForId(BUY_FIGHT_COUNT_ID,onBuyFight);
            }]);
         }
      }
      
      private function onBuyFight(param1:*) : void
      {
         this.startFight();
      }
      
      private function startFight() : void
      {
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.onFightOver);
         FightManager.startFightWithBoss(this.FIGHT_INDEX);
      }
      
      protected function onFightOver(param1:FightStartEvent) : void
      {
         var event:FightStartEvent = param1;
         FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.onFightOver);
         if(!FightManager.isJustWinFight())
         {
            NpcDialog.show(113,"超级nono ",[[0,"差一点就获得目灵神进化芯片了！加油！"]],["好！ ","一键获得"],[null,function():void
            {
               ShopManager.buyItemForId(BUY_PASS_ID,onBuyChip);
            }]);
         }
         else
         {
            this.onBuyChip(null);
         }
      }
      
      private function onBuyChip(param1:*) : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onShow);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function onShow(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onShow);
         ModuleManager.showAppModule("EyeBeastEvolvePanel");
      }
   }
}
