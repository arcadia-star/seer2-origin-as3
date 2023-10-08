package com.taomee.seer2.app.processor.quest.handler.branch.quest10220
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10220_80136 extends QuestMapHandler
   {
       
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      private var _mc6:MovieClip;
      
      public function QuestMapHandler_10220_80136(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10220) && QuestManager.isStepComplete(10220,2) == false)
         {
            this.initStep2();
         }
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10220_1"),function():void
         {
            _mc4 = _processor.resLib.getMovieClip("mc4");
            _map.front.addChild(_mc4);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"斯坦因，原来你也在，赶快住手！"]],["住手……"],[function():void
            {
               NpcDialog.show(106,"斯坦因博士",[[1,"哈哈哈，哪里有我需要的东西，我就在哪里~"]],["可恶。"],[function():void
               {
                  NpcDialog.show(349,"继承者",[[0,"能够找到这里，算你们有本事，可惜已经晚了，哈哈哈……"]],["晚了？"],[function():void
                  {
                     NpcDialog.show(106,"斯坦因博士",[[1,"是的，我的实验终于成功了，接下来，就是测试实验结果的时候了。"]],["什么结果？你们把雷伊怎么了？"],[function():void
                     {
                        _mc4["actor0"].visible = false;
                        _mc4["actor1"].visible = false;
                        _mc5 = _processor.resLib.getMovieClip("mc5");
                        _map.front.addChild(_mc5);
                        MovieClipUtil.playMc(_mc5,2,_mc5.totalFrames,function():void
                        {
                           DisplayUtil.removeForParent(_mc5);
                           NpcDialog.show(14,"S",[[0,"可恶，他们去哪了？"]],["赶快去救雷伊吧！"],[function():void
                           {
                              _processor.showMouseHintAt(144,254);
                              _mc4["actor"].buttonMode = true;
                              _mc4["actor"].addEventListener(MouseEvent.CLICK,onActor);
                           }]);
                        },true);
                     }]);
                  }]);
               }]);
            }]);
         },true,true);
      }
      
      private function onActor(param1:MouseEvent) : void
      {
         this._mc4["actor"].removeEventListener(MouseEvent.CLICK,this.onActor);
         this._mc6 = _processor.resLib.getMovieClip("mc6");
         _map.front.addChild(this._mc6);
         this._mc6.visible = true;
         Quest10220Game.setMC(this._mc6,this.onCom);
      }
      
      private function onCom(param1:Boolean) : void
      {
         var b:Boolean = param1;
         if(b)
         {
            _processor.hideMouseClickHint();
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10220_2"),function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(10220,2);
            },true,true);
         }
         else
         {
            AlertManager.showConfirm("啊呀，一不小心失败了哦，再来一次吧！",function():void
            {
               _mc6.visible = true;
               Quest10220Game.setMC(_mc6,onCom);
            });
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         this._mc4["actor"].removeEventListener(MouseEvent.CLICK,this.onActor);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mc5);
         DisplayUtil.removeForParent(this._mc6);
      }
   }
}
