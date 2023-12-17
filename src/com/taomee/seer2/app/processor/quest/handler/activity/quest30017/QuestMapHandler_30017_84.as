package com.taomee.seer2.app.processor.quest.handler.activity.quest30017
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.door.AtleticoDoor;
   import com.taomee.seer2.app.gameRule.door.atletico.AtleticoDoorSupport;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.FortQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   
   public class QuestMapHandler_30017_84 extends FortQuestMapHandler
   {
       
      
      public function QuestMapHandler_30017_84(param1:QuestProcessor)
      {
         npcId = 136;
         npcName = "六番队长";
         door = new AtleticoDoor(new SimpleButton(),DoorType.Door_NORMAL);
         _supportInstance = AtleticoDoorSupport.getInstance();
         battleScene = 408;
         npcTalkId = "30017_0";
         questId = 30017;
         super(param1);
      }
      
      override protected function toStep1Dia() : void
      {
         NpcDialog.show(npcId,npcName,[[0,"年轻人，战斗不能光凭蛮力，你还需要智慧。"]],["好吧！再来！"],[door.requestEntry]);
      }
      
      override protected function showNextQuestDia() : void
      {
         NpcDialog.show(npcId,npcName,[[0,"年轻人，看来你已经掌握了竞技的奥义。去下一层找5番队长接受更严酷的试炼吧！"]],["我一定会前去挑战的！","还是不要去了"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,85);
         }]);
      }
      
      override protected function toStep3Dia() : void
      {
         NpcDialog.show(npcId,npcName,[[0,"再挑战一次吧，这次给你更强的训练，如果通过我的试炼，你就明白了竞技的奥义！"]],["再来！我要成为真正的强者 ","我累了明天再说吧"],[door.requestEntry]);
      }
      
      override protected function showAcceptDia() : void
      {
         NpcDialog.show(npcId,npcName,[[0,"小子！你是来挑战吾等人的吗？但是你了解你的对手吗？"]],["说来听听","我才不敢兴趣"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation(npcTalkId),4,[[1,0]],function():void
            {
               NpcDialog.show(npcId,npcName,[[0,"所以才建造了英格瓦要塞，年轻人，你能承受住吾等给你准备的最强度训练吗？"]],["来吧！我要成为真正的强者 ","我走错地方了"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                  QuestManager.accept(_quest.id);
               }]);
            });
         }]);
      }
   }
}
