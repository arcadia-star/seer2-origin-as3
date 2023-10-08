package com.taomee.seer2.app.processor.quest.handler.main.quest102
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_102_80515 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_102_80515(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(!QuestManager.isAccepted(_quest.id))
         {
            this.initStep0();
         }
      }
      
      private function initStep0() : void
      {
         var dialog:Array;
         var npc:MovieClip = _processor.resLib.getMovieClip("npc");
         SceneManager.active.mapModel.front.addChild(npc);
         npc.mouseChildren = false;
         dialog = [[-1,"",[[0,"【通讯器突然闪动起来……】"]],["......"]],[-1,"？？？",[[0,"呲啦呲啦……暗影氏族……是个有趣的地方吧？桀桀桀……不过，我这里也许有更加有趣的东西……来神秘研究所吧，如果你想知道的话。呲啦呲啦……"]],["......"]],[400,"小赛尔",[[0,"这种神秘的感觉，这个奇怪的声音……（大惊）是斯坦因！他来找我，而偏偏是在这个关头……难道他知道暗影氏族的内幕？虽然可能会有危险，但是我现在已经陷入了疑惑之中，我总感觉有什么不对劲……"]],["也许，斯坦因能给我一些线索？"]],[10,"巴蒂",[[0,"队长你不傻吗？斯坦因突然出现，其中必有蹊跷，这很有可能是一个陷阱！"]],["......"]],[11,"多罗",[[0,"是啊队长！我们应该以……以什么？对了！以不变应万变！"]],["看起来很眼熟的样子。"]],[400,"小赛尔",[[0,"是的，其中必有蹊跷，但是这蹊跷就是我要探明的东西。虽然只是那一瞬间的回响，但是我认为它事关重大，这样的时刻，我不能耽搁。"]],["更何况，斯坦因应该比我们知道得多。"]],[10,"巴蒂",[[0,"队长你真是死脑筋啊，不过你这么有责任感，我也不好意思拦你了。那么这次我就不去了，队长你保重啊！"]],["......"]],[11,"多罗",[[0,"是啊……队长保重！亮晶晶……亮晶晶小队永远在你身后！"]],["......"]],[400,"小赛尔",[[0,"(你们说这些话用意何在……)好的，那么我出发了。还未明了的东西，隐藏在黑暗中的东西，我一定要把它们弄个明白！"]],["前往神秘研究院！  "]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY,80516);
         });
      }
   }
}
