package com.taomee.seer2.app.processor.quest.handler.activity.quest30029
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30029_20 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_30029_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._npc = MobileManager.getMobile(2,MobileType.NPC);
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
         var count:uint = uint(server.readDataAtPostion(6));
         if(count < 1)
         {
            count++;
            ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL,6,count);
            NpcDialog.show(2,"伊娃",[[0,"努力学习，拼命玩！哈哈！"]],["酷！！伊娃，我爱你！"],[function():void
            {
               var data:* = new Object();
               data.index = 3;
               ModuleManager.toggleModule(URLUtil.getAppModule("OpenSchoolPanel"),"正在打开面板...",data);
               ServerMessager.addMessage("得到伊娃博士的祝福");
               if(server.readDataAtPostion(5) >= 1 && server.readDataAtPostion(8) >= 1 && server.readDataAtPostion(7) >= 1)
               {
                  QuestManager.completeStep(30029,1);
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"船长、伊娃、克拉克和娜威拉都太给力啦！哈哈！"]],["返回传送室！"],[function():void
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                  }]);
               }
            }]);
         }
      }
   }
}
