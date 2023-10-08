package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.yiteFight.YiteFight;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_500 extends MapProcessor
   {
       
      
      private var _npc:Mobile;
      
      private var _yiteFight:YiteFight;
      
      private var book:MovieClip;
      
      private var arrow:MovieClip;
      
      private var _inte2:MovieClip;
      
      public function MapProcessor_500(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initInte2();
         this.initNpc();
         this.initYiteFight();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_153);
         this.book = _map.content["book"];
         if(this.book)
         {
            this.book.stop();
            this.book.visible = false;
         }
         this.arrow = _map.content["arrow"];
         if(this.arrow)
         {
            this.arrow.stop();
            this.arrow.visible = false;
         }
      }
      
      private function initYiteFight() : void
      {
         this._yiteFight = new YiteFight(_map);
      }
      
      private function initNpc() : void
      {
         this._npc = MobileManager.getMobile(429,MobileType.NPC);
         if(QuestManager.isAccepted(13) && QuestManager.isComplete(13) == false)
         {
            this._npc.visible = false;
         }
      }
      
      private function initInte2() : void
      {
         this._inte2 = _map.content["inte2"];
         this._inte2.addEventListener(MouseEvent.CLICK,this.onInte2Click);
      }
      
      private function onInte2Click(param1:MouseEvent) : void
      {
         this._inte2.removeEventListener(MouseEvent.CLICK,this.onInte2Click);
         if(SwapManager.isSwapNumberMax(91))
         {
            SwapManager.entrySwap(91);
         }
      }
      
      override public function dispose() : void
      {
         this._inte2.removeEventListener(MouseEvent.CLICK,this.onInte2Click);
         this._inte2 = null;
         this._npc = null;
         if(this._yiteFight)
         {
            this._yiteFight.dispose();
         }
         this._yiteFight = null;
         super.dispose();
      }
   }
}
