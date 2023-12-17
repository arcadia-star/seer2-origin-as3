package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class FightBoDeAct
   {
      
      private static var _instance:FightBoDeAct;
       
      
      private var _npc:Mobile;
      
      public function FightBoDeAct()
      {
         super();
      }
      
      public static function get instance() : FightBoDeAct
      {
         if(!_instance)
         {
            _instance = new FightBoDeAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(QuestManager.isComplete(10212))
         {
            this.createBode();
         }
      }
      
      public function dispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function createBode() : void
      {
         this._npc = new Mobile();
         this._npc.width = 100;
         this._npc.height = 160;
         this._npc.setPostion(new Point(460,325));
         this._npc.resourceUrl = URLUtil.getNpcSwf(676);
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.label = "伯德";
         this._npc.labelImage.y = -this._npc.height - 10;
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      protected function onNpcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(664,"伯德",[[0,"哼哼~小心我一炮轰趴你。"]],["你的导弹打不到我（可捕捉） "," 啊~大炮，快撤退！"],[function():void
         {
            FightManager.startFightWithWild(739);
         }]);
      }
   }
}
