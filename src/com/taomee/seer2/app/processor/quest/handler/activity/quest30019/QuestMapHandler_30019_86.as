package com.taomee.seer2.app.processor.quest.handler.activity.quest30019
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.door.BinaryDoor;
   import com.taomee.seer2.app.gameRule.door.binary.BinaryDoorSupport;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.FortQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   
   public class QuestMapHandler_30019_86 extends FortQuestMapHandler
   {
       
      
      public function QuestMapHandler_30019_86(param1:QuestProcessor)
      {
         npcId = 67;
         npcName = "西贡";
         door = new BinaryDoor(new SimpleButton(),DoorType.Door_NORMAL);
         npcTalkId = "30019_0";
         _supportInstance = BinaryDoorSupport.getInstance();
         battleScene = 420;
         questId = 30019;
         super(param1);
      }
      
      override protected function toStep1Dia() : void
      {
         NpcDialog.show(npcId,npcName,[[0,"哈哈哈！弱者！"]],["再来！我不信赢不了你！"],[door.requestEntry]);
      }
      
      override protected function showAcceptDia() : void
      {
         NpcDialog.show(npcId,npcName,[[0,"你来这里做什么！难道也是想体味一下失败的滋味吗？吼吼吼！"]],["西贡这个人船长曾提起过"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation(npcTalkId),3,[[1,0]],function():void
            {
               NpcDialog.show(npcId,npcName,[[0,"你是要做我的敌人吗！吼吼吼！那就看看你能否战斗到我这里吧！不过结果都一样，你都会被打倒！"]],["看来这下非战不可了！","好恐怖！快跑！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                  QuestManager.accept(_quest.id);
               }]);
            });
         }]);
      }
   }
}
