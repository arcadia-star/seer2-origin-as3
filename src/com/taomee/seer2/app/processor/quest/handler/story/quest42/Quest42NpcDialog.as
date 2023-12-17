package com.taomee.seer2.app.processor.quest.handler.story.quest42
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class Quest42NpcDialog
   {
      
      private static const npcIdList:Vector.<uint> = Vector.<uint>([16,23,31,55,56,49,107]);
      
      private static var _res:ResourceLibrary;
       
      
      public function Quest42NpcDialog()
      {
         super();
      }
      
      public static function showDialog(param1:uint, param2:ResourceLibrary) : void
      {
         var npcId:uint = param1;
         var res:ResourceLibrary = param2;
         if(npcId == 16)
         {
            NpcDialog.show(16,"神目酋长",[[0,"嗯……守护草木氏族的神兽，目灵兽，象征着精灵王的双眼。"]],["嗯嗯。"],[function():void
            {
               NpcDialog.show(16,"神目酋长",[[0,"自精灵王一役之后，目灵兽的精元养育了这一片土地，这才有了我们草木氏族的存在。"]],["嗯嗯。"],[function():void
               {
                  NpcDialog.show(16,"神目酋长",[[0,"据说，从我族诞生起，神目所饱览的历史都被记载在一块神秘的石碑上。这块石碑就在作为星球之心的能源之树上。"]],["哦？看来是充满秘密的石碑呢。"],[function():void
                  {
                     NpcDialog.show(16,"神目酋长",[[0,"精灵王……目灵兽……这些关键的资料，都由一个守护者守护着，不被恶意侵犯。"]],["能源之树，石碑，守护者……"],[function():void
                     {
                        _res = res;
                        setQuestBuf(npcIdList.indexOf(npcId));
                     }]);
                  }]);
               }]);
            }]);
         }
         if(npcId == 23)
         {
            NpcDialog.show(23,"神谕祭司",[[0,"说起脉灵兽，它象征着精灵王的血液，在精灵王一役后，孕育了水脉一族。"]],["嗯嗯。"],[function():void
            {
               NpcDialog.show(23,"神谕祭司",[[0,"血液——生灵之间的羁绊。我一直相信着，星球各族人间会有一根无形的纽带，让我们的命运受到彼此的牵绊和影响。"]],["嗯，的确是。"],[function():void
               {
                  NpcDialog.show(23,"神谕祭司",[[0,"据说在能源之树的净土上，守护者常年守护着一件珍宝，它能够将各个氏族再一次维系起来、凝聚起来。"]],["能源之树，珍宝，守护者……"],[function():void
                  {
                     _res = res;
                     setQuestBuf(npcIdList.indexOf(npcId));
                  }]);
               }]);
            }]);
         }
         if(npcId == 31)
         {
            NpcDialog.show(31,"巴尔卡",[[0,"幻灵兽？是，父王曾告诉过我，它象征着精灵王的体魄。它的强健孕育了火幻氏族，是以族人全都是一等一的角斗士！"]],["嗯嗯。"],[function():void
            {
               NpcDialog.show(31,"巴尔卡",[[0,"父王还告诉过我这样一个传说，火幻氏族的战士们去世后，灵魂都会长眠在一棵叫做能源之树的地方。"]],["哦？"],[function():void
               {
                  NpcDialog.show(31,"巴尔卡",[[0,"据说那里明亮而灼热，先祖们在那里继续博弈。守护者在那里保证他们的战斗不被打扰，并且能够永远进行下去……"]],["能源之树，先祖，守护者……"],[function():void
                  {
                     _res = res;
                     setQuestBuf(npcIdList.indexOf(npcId));
                  }]);
               }]);
            }]);
         }
         if(npcId == 55)
         {
            NpcDialog.show(55,"神月老大",[[0,"月灵兽象征着精灵王的犄角！洒家甚为满意啊！不愧是月灵兽孕育的氏族，实在比那些财奴有着更高的眼界啊~"]],["时刻都不忘记抬杠啊……"],[function():void
            {
               NpcDialog.show(55,"神月老大",[[0,"说起能源之树，洒家听过一些传闻……据说在那里，沙爪和地月合为一体……是我二族最初也是最后的形态。"]],["哦？"],[function():void
               {
                  NpcDialog.show(55,"神月老大",[[0,"那里的守护者非常强大，同时兼备二族的最强力量……洒家也想同它比试比试！"]],["能源之树，联合，守护者……"],[function():void
                  {
                     _res = res;
                     setQuestBuf(npcIdList.indexOf(npcId));
                  }]);
               }]);
            }]);
         }
         if(npcId == 56)
         {
            NpcDialog.show(56,"神爪财团老板",[[0,"爪灵兽，精灵王之利爪，也正是它孕育了我沙爪氏族。灵敏尖锐，无论是体魄还是智慧看起来都更胜那些粗鬼一筹！"]],["时刻都不忘记抬杠啊……"],[function():void
            {
               NpcDialog.show(56,"神爪财团老板",[[0,"说起能源之树……据说在那里，沙爪和地月合为一体……是我二族最初也是最后的形态。"]],["哦？"],[function():void
               {
                  NpcDialog.show(56,"神爪财团老板",[[0,"那里的守护者非常强大，同时兼备二族的最强力量……假设它能光临我族，一定会蓬荜生辉啊！"]],["能源之树，联合，守护者……"],[function():void
                  {
                     _res = res;
                     setQuestBuf(npcIdList.indexOf(npcId));
                  }]);
               }]);
            }]);
         }
         if(npcId == 49)
         {
            NpcDialog.show(49,"神沁酋长",[[0,"精灵王的心脏，沁灵兽，如寒冰般坚毅、高傲、孤独……"]],["嗯嗯。"],[function():void
            {
               NpcDialog.show(49,"神沁酋长",[[0,"祖先曾说，在能源之树上有一块被冰封的区域，回响着一首千年不老的歌谣。"]],["哦？"],[function():void
               {
                  NpcDialog.show(49,"神沁酋长",[[0,"那段歌谣不能停歇下来，一旦它的节奏被打破，人心就会散乱。不过，强大的守护者不会让它发生。"]],["能源之树，联合，守护者……"],[function():void
                  {
                     _res = res;
                     setQuestBuf(npcIdList.indexOf(npcId));
                  }]);
               }]);
            }]);
         }
         if(npcId == 107)
         {
            NpcDialog.show(107,"神翼总督",[[0,"象征自由的翼灵兽，自精灵王一役后，一直守护着飞翼氏族。"]],["嗯嗯。"],[function():void
            {
               NpcDialog.show(107,"神翼总督",[[0,"能源之树的顶端，记载着飞翼氏族离开地面的真正原因……"]],["哦？"],[function():void
               {
                  NpcDialog.show(107,"神翼总督",[[0,"据说那里是能源之树的最后一站，到达那里的勇士将成为星球的希望之光，带着最后的秘宝，开启星球的未来。"]],["能源之树，秘宝，未来……"],[function():void
                  {
                     _res = res;
                     setQuestBuf(npcIdList.indexOf(npcId));
                  }]);
               }]);
            }]);
         }
      }
      
      private static function setQuestBuf(param1:uint) : void
      {
         ServerBufferManager.updateServerBuffer(ServerBufferType.QUEST_BUF_42,param1,1);
         ServerBufferManager.getServerBuffer(ServerBufferType.QUEST_BUF_42,getServerBuf,false);
      }
      
      private static function getServerBuf(param1:ServerBuffer) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < 7)
         {
            if(param1.readDataAtPostion(_loc3_) != 1)
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            new Panel42(_res);
         }
         else
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(42,1);
         }
      }
      
      private static function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
         if(param1.questId == 42)
         {
            SceneManager.changeScene(SceneType.LOBBY,10);
         }
      }
   }
}
