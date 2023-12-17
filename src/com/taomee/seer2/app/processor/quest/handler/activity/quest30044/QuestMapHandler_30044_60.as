package com.taomee.seer2.app.processor.quest.handler.activity.quest30044
{
   import com.taomee.seer2.app.dialog.NpcDialog;
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
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30044_60 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_30044_60(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._npc = MobileManager.getMobile(6,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc,false,1);
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
         ServerBufferManager.getServerBuffer(ServerBufferType.OPEN_SCROOL,this.onQuest);
      }
      
      private function onQuest(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var count:uint = uint(server.readDataAtPostion(8));
         if(count < 1)
         {
            count++;
            ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL,8,count);
            NpcDialog.show(6,"克拉克",[[0,"赛尔！我的战士！新的一年你准备创下什么辉煌的战绩呢！相信你新一年会带来更多的荣耀！"]],["是的！教官！敬礼！！！"],[function():void
            {
               var data:* = new Object();
               data.index = 3;
               ModuleManager.toggleModule(URLUtil.getAppModule("OpenSchoolPanel"),"正在打开面板...",data);
               ServerMessager.addMessage("得到克拉克的祝福");
               if(server.readDataAtPostion(5) >= 1 && server.readDataAtPostion(6) >= 1 && server.readDataAtPostion(7) >= 1)
               {
                  QuestManager.completeStep(30044,1);
                  NpcDialog.show(113,"NONO",[[0,"船长、伊娃、克拉克和娜威拉都太给力啦！哈哈！我们回去看看小屋装修成什么样子了吧！"]],["走！"],[function():void
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                  }]);
               }
            }]);
         }
      }
   }
}
