package com.taomee.seer2.app.processor.activity.rainOfSunAct
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class RainOfSunActOne
   {
       
      
      private const FIGHT_INDEX:int = 571;
      
      private const NPC_RES_ID:int = 209;
      
      private var _map:MapModel;
      
      private var _npc:Mobile;
      
      private const TIME_REGION:Array = [[0,0],[9,59]];
      
      public function RainOfSunActOne(param1:MapModel)
      {
         super();
         this._map = param1;
         this.init();
      }
      
      private function init() : void
      {
         this._npc = MobileManager.getMobile(this.NPC_RES_ID,MobileType.NPC);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(this.FIGHT_INDEX);
      }
      
      private function removeNpc() : void
      {
         if(this._npc)
         {
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      public function dispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         this.removeNpc();
      }
   }
}
