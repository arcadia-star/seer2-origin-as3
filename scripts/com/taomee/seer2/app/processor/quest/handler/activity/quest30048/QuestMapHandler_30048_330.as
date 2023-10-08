package com.taomee.seer2.app.processor.quest.handler.activity.quest30048
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30048_330 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_30048_330(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._npc = MobileManager.getMobile(43,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc,false,1);
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
         ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL,this.onQuest);
      }
      
      private function onQuest(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var count:uint = uint(server.readDataAtPostion(8));
         if(count < 1)
         {
            count += 1;
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL,8,count);
            NpcDialog.show(43,"汪总管",[[0,"除了米共饲料，我最爱的就是你们了！2周年快乐！"]],["大总管谢谢了！"],[function():void
            {
               ServerMessager.addMessage("得到汪总管的祝福");
               if(server.readDataAtPostion(5) >= 1 && server.readDataAtPostion(6) >= 1 && server.readDataAtPostion(7) >= 1)
               {
                  QuestManager.completeStep(_quest.id,1);
                  AlertManager.showAlert("舒尔、占卜婆婆、玛妈和汪总管都太给力啦",function():void
                  {
                     ModuleManager.toggleModule(URLUtil.getAppModule("MakeBattleSuitPanel"),"");
                  });
               }
               else
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("MakeSuitFourPanel"),"");
               }
            }]);
         }
      }
   }
}
