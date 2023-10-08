package com.taomee.seer2.app.processor.quest.handler.main.quest106
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_106_80530 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_106_80530(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         if(!QuestManager.isAccepted(_quest.id))
         {
            return;
         }
         if(QuestManager.isStepComplete(_quest.id,1) == true && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initStep2();
         }
      }
      
      protected function initStep2() : void
      {
         var dialog:Array = null;
         dialog = [[511,"影灵的幻视",[[0,"恭候多时，三位。"]],["......"]],[11,"多罗",[[0,"妈呀！你不就是……。"]],["果然是他。"]],[10,"巴蒂",[[0,"你似乎已经等了很久？"]],["........"]],[400,"小赛尔",[[0,"你不是真正的影灵的幻视，对吗？"]],["......"]],[511,"影灵的幻视",[[0,"说话一针见血，不愧是星际使者。弗雷德能将这件事坦白，真是对汝等信任有加啊。准确的说，吾是影灵的幻视的投影。吾与本体共享一个灵魂，但没有它的力量。吾即影灵，也非影灵。"]],["......"]],[10,"巴蒂",[[0,"你给了我们一些线索，还在这里等我们，想必是有很重要的目的吧？"]],["....."]],[511,"影灵的幻视",[[0,"诚然如此"]],["........"]],[400,"小赛尔",[[0,"我们现在已经确定，我们的记忆被修改过。"]],["......"]],[511,"影灵的幻视",[[0,"（似乎饶有兴趣地说）除此之外呢？"]],["除此之外，是的，重头戏来了。"]],[400,"小赛尔",[[0,"镇静）就是在这里，我的头顶曾经悬浮着巨大而模糊的身影，我们都知道『它是什么』，对么？"]],["........"]],[511,"影灵的幻视",[[0,"对"]],["........"]],[11,"多罗",[[0,"对！就是那个大影子！"]],["神经大条的多罗……"]],[400,"小赛尔",[[0,"你当年亲自帮助萨伦帝国夺走了它所代表的“希望之光”。而“希望之光”是复活约瑟王的必要道具。"]],["........"]],[10,"巴蒂",[[0,"所以谁能解释一下，现在的【约瑟王】，究竟是什么？"]],["........"]],[511,"影灵的幻视",[[0,"（似乎笑了）不错……如今汝等已经找到了问题之所在。"]],["是这样的。"]],[400,"小赛尔",[[0,"所以你在这里，是为了给我们问题的答案？"]],["......"]],[511,"影灵的幻视",[[0,"也许会让汝等失望。吾只是来提供线索的。"]],["........"]],[400,"小赛尔",[[0,"并没有什么可失望的，有线索就够了！最重要的，难道不是追寻真相的意志吗？"]],["......"]],[511,"影灵的幻视",[[0,"很好。（似乎满意地微笑了一下）汝等失去了记忆，想必找过【回忆】的途径吧？"]],["......"]],[10,"巴蒂",[[0,"啧，说到这个，还是有点困难啊……"]],["等等，这样说下去不会泄密吗？"]],[511,"影灵的幻视",[[0,"飞翼氏族确实有一个地方，在那里，正确的历史还被以只言片语的形式保存着。汝等想必已经去过了？"]],["云海藏书？他知道那个地方？"]],[400,"小赛尔",[[0,"我想是的。"]],["......"]],[511,"影灵的幻视",[[0,"那个地方的建成，与回忆的力量有关，与漂浮于天空中俯视世间的逍遥灵魂有关。"]],["那是什么？"]],[400,"小赛尔",[[0,"回忆的力量，俯视世间的逍遥灵魂？"]],["........"]],[10,"巴蒂",[[0,"队长，我想我找到答案了！"]],["……是的，我似乎也想到了。"]],[511,"影灵的幻视",[[0,"很好。不过在你们踏上寻找真相的路途之前，我还要帮你们回忆一件事。"]],["......."]],[400,"小赛尔",[[0,"（感觉很怪，但是仍旧顺坡下了）那么，多谢你了。"]],["........"]],[511,"影灵的幻视",[[0,"当年，就在这里，那场战役想必你们还记忆犹新吧？"]],["那是当然。"]],[511,"影灵的幻视",[[0,"汝等接下来要面对的……是比那场战役有过之而无不及的挑战。那是历史已被湮没在岁月深处的秘密，是黑暗森林之中的微光，是命运残忍之中的救赎。。"]],["那是什么？"]],[511,"影灵的幻视",[[0,"汝等，做好准备了么？"]],["........"]],[400,"小赛尔",[[0,"我们做好准备了！"]],["......."]],[11,"多罗",[[0,"虽然听不太懂……但是亮晶晶小队最棒！"]],["......."]],[10,"巴蒂",[[0,"尽管来吧，最聪明的我接受挑战！"]],["........"]],[511,"影灵的幻视",[[0,"很好，那么再一次，为了汝等的【希望】和【未来】，战斗继续……"]],["......"]]];
         var npc:MovieClip = _processor.resLib.getMovieClip("duoLuoaa");
         npc.x -= 25;
         npc.y -= 268;
         SceneManager.active.mapModel.front.addChild(npc);
         npc.buttonMode = true;
         npc.mouseChildren = false;
         NpcDialog.showDialogs(dialog,function():void
         {
            QuestManager.completeStep(_quest.id,2);
            SceneManager.changeScene(SceneType.LOBBY,70);
         });
      }
   }
}
