package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.activity.fightVsBarry.FightVsHello;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.events.MouseEvent;
   
   public class MapProcessor_3812 extends MapProcessor
   {
      
      private static const XiYaFightId:int = 733;
       
      
      private var _xiYa:Mobile;
      
      private var _fighVsHello:FightVsHello;
      
      public function MapProcessor_3812(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._fighVsHello = new FightVsHello(_map);
         this._xiYa = MobileManager.getMobile(663,MobileType.NPC);
         this._xiYa.buttonMode = true;
         this._xiYa.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(663,"希雅",[[0,"竟敢来妨碍老娘，活腻了吗？"]],["我不怕你（可捕捉）","啊~真凶，我们走吧"],[function():void
         {
            FightManager.startFightWithWild(XiYaFightId);
         }]);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._fighVsHello)
         {
            this._fighVsHello.dispose();
            this._fighVsHello = null;
         }
         if(this._xiYa)
         {
            this._xiYa.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
   }
}
