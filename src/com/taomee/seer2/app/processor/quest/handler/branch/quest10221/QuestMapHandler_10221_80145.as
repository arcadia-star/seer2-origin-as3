package com.taomee.seer2.app.processor.quest.handler.branch.quest10221
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10221_80145 extends QuestMapHandler
   {
       
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      private var _mc6:MovieClip;
      
      public function QuestMapHandler_10221_80145(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10221) && QuestManager.isStepComplete(10221,4) == false)
         {
            this.initStep4();
         }
      }
      
      private function initStep4() : void
      {
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         _map.content.addChild(this._mc4);
         this._mc4["actor"].visible = false;
         NpcDialog.show(349,"继承者",[[0,"哈哈哈，终于等到你们了，我还以为你们不敢来呢！"]],["卑鄙的小人，快还我们王魄！"],[function():void
         {
            NpcDialog.show(349,"继承者",[[0,"能不能要回去就看你们本事了，哼哼，来人！"]],["糟糕……"],[function():void
            {
               _mc4.visible = false;
               _mc5 = _processor.resLib.getMovieClip("mc5");
               _map.content.addChild(_mc5);
               MovieClipUtil.playMc(_mc5,2,_mc5.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_mc5);
                  _mc4.visible = true;
                  _mc4["actor"].visible = true;
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10221_3"),function():void
                  {
                     NpcDialog.show(349,"继承者",[[0,"发生了什么事？"]],["王魄到底怎么了？"],[function():void
                     {
                        NpcDialog.show(349,"继承者",[[0,"冥皓、黑天马，快住手！"]],["缪斯、圣兽天尊，你们也住手吧！"],[function():void
                        {
                           DisplayUtil.removeForParent(_mc4);
                           _mc6 = _processor.resLib.getMovieClip("mc6");
                           _map.content.addChild(_mc6);
                           MovieClipUtil.playMc(_mc6,2,_mc6.totalFrames,function():void
                           {
                              MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10221_4"),function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                                 QuestManager.completeStep(10221,4);
                              },true,true);
                           },true);
                        }]);
                     }]);
                  },true,true);
               },true);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mc5);
         DisplayUtil.removeForParent(this._mc6);
      }
   }
}
