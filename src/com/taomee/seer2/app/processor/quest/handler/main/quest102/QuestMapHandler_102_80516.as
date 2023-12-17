package com.taomee.seer2.app.processor.quest.handler.main.quest102
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_102_80516 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_102_80516(param1:QuestProcessor)
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
         if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         var dialog1:Array = null;
         var dialog2:Array = null;
         var movie1:MovieClip = null;
         var dialog0:Array = [[106,"斯坦因",[[0,"（似乎在阴森地笑）你果然来了。"]],["......"]],[400,"小赛尔",[[0,"说吧，你想告诉我些什么？"]],["......"]],[106,"斯坦因",[[0,"桀桀桀，先别那么心急嘛。在暗影氏族见到了“故人”，感觉怎么样"]],["......"]],[400,"小赛尔",[[0,"感觉很复杂，而且这“故人”究竟是什么立场，我很疑惑。"]],["......"]],[106,"斯坦因",[[0,"（笑）比暗影更难看穿的，是真相。对于他，我知道的也许还不如你多。不过在这之前……{向回廊尽头走去，站在了那个巨大的圆形平台上面}知道这里吗？"]],["......"]],[400,"小赛尔",[[0,"（疑惑）你是说……？"]],["......"]],[106,"斯坦因",[[0,"那么，我再提醒一下……"]],["......"]]];
         dialog1 = [[400,"小赛尔",[[0,"（恍然大悟）我想到了！是你！在我们的南半球行程……走到风刃氏族的这个研究院的时候……巴蒂中了你的埋伏，在救她的时候，我们被你推了下去！"]],["......"]],[400,"小赛尔",[[0,"（冷静下来）是的，我应该见过这个机关……在什么时候？我看见了它的运作……？"]],["......"]]];
         dialog2 = [[400,"小赛尔",[[0,"说吧，你想告诉我些什么？"]],["......"]],[106,"斯坦因",[[0,"（从远处传来的声音……）桀桀桀，不错，想起来了啊。那么，那之后发生了什么呢？……"]],["......"]],[400,"小赛尔",[[0,"那之后……快去御风中枢看看！！"]],["前往御风中枢"]]];
         movie1 = _processor.resLib.getMovieClip("movie");
         _map.front.addChild(movie1);
         movie1.mouseChildren = false;
         NpcDialog.showDialogs(dialog0,function():void
         {
            MovieClipUtil.playMc(movie1,2,movie1.totalFrames,function():void
            {
               NpcDialog.showDialogs(dialog1,function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("59_2"),function():void
                  {
                     NpcDialog.showDialogs(dialog2,function():void
                     {
                        QuestManager.completeStep(_quest.id,1);
                        SceneManager.changeScene(SceneType.COPY,80517);
                     });
                  });
               });
            });
         });
      }
   }
}
