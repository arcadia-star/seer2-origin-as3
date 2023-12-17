package com.taomee.seer2.app.processor.quest.handler.activity.quest30056
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
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
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30056_213 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_30056_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._npc = MobileManager.getMobile(27,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc,false,1);
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
         ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL,this.onQuest);
      }
      
      private function onQuest(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var count:uint = uint(server.readDataAtPostion(6));
         if(count < 1)
         {
            count += 1;
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL,6,count);
            NpcDialog.show(27,"占卜婆婆",[[0,"你们不来找我占卜一下谁是冠军吗？不把我老太婆放在眼里啊！"]],["知道结果就不好玩了，婆婆还是谢谢你！"],[function():void
            {
               ServerMessager.addMessage("得到婆婆的碎片礼物");
               if(server.readDataAtPostion(5) >= 1 && server.readDataAtPostion(8) >= 1 && server.readDataAtPostion(7) >= 1)
               {
                  QuestManager.completeStep(_quest.id,1);
                  AlertManager.showAlert("舒尔、占卜婆婆、玛妈和汪总管都太给力啦",function():void
                  {
                     StatisticsManager.newSendNovice("2014活动","帝王战袍","完成战靴制作");
                     ModuleManager.showAppModule("MakeTabardPanel");
                  });
               }
               else
               {
                  ModuleManager.showAppModule("MakeTabardBootsPanel");
               }
            }]);
         }
      }
   }
}
