package com.taomee.seer2.app.processor.quest.handler.branch.quest10029
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10029_123 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_10029_123(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._npc = MobileManager.getMobile(20,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc,false,1);
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         NpcDialog.show(20,"舒尔",[[3,"这个……那个……这个是我写给哈瑞的道歉信……我……我不想失去这个好朋友！你能帮我把道歉信给哈瑞吗？"]],["（他在彩虹珊瑚湾）"]);
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var _loc2_:String = param1.params;
         if(_loc2_ == "10029_0")
         {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            ServerMessager.addMessage("已收集完成");
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
