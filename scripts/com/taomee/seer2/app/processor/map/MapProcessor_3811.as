package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.activity.fightVsBarry.FightVsBarry;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.events.MouseEvent;
   
   public class MapProcessor_3811 extends MapProcessor
   {
       
      
      private var _npc:Mobile;
      
      private var _fighVsBarry:FightVsBarry;
      
      public function MapProcessor_3811(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._npc = MobileManager.getMobile(647,MobileType.NPC);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
         this._fighVsBarry = new FightVsBarry(_map);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(647,"路奇",[[0,"谁谁抢走了我的猎物？拿命来~呀呀呀！！！"]],["我要收了你这妖怪！(可捕捉)","啊~好可怕，我们赶快走吧！"],[function():void
         {
            FightManager.startFightWithWild(698);
         }]);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
         }
         if(this._fighVsBarry)
         {
            this._fighVsBarry.dispose();
            this._fighVsBarry = null;
         }
      }
   }
}
