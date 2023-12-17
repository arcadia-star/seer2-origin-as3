package com.taomee.seer2.app.processor.quest.handler.story.quest56
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_56_890 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_56_890(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,7) && QuestManager.isStepComplete(_quest.id,8) == false)
         {
            this.playFullMC();
         }
      }
      
      private function playFullMC() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("56_1"),function():void
         {
            _mc_0 = _processor.resLib.getMovieClip("mc_4");
            _map.front.addChild(_mc_0);
            _mc_0.buttonMode = true;
            _mc_0.addEventListener(MouseEvent.CLICK,npcTalkHandler);
         },true,false,2);
      }
      
      private function npcTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(137,"席德",[[0,"赛尔……【希望之光】……%￥%……&*……"]],["你知道赛尔和希望之光？"],[function():void
         {
            NpcDialog.show(137,"席德",[[0,"额，啊对，这件事情整个星球都沸沸扬扬。请问你是……？"]],["我就是赛尔……请问这里是……？"],[function():void
            {
               NpcDialog.show(137,"席德",[[1,"你就是赛尔？太好了，我已经守候多时了！我是来助你一臂之力的！"]],["（看来南半球的人比想象中友好嘛。）"],[function():void
               {
                  NpcDialog.show(137,"席德",[[1,"看来你还不知道，你已经进入了风刃氏族的边缘地带了。要说风刃氏族？那儿，不就是吗？"]],["（他的手指向了面前的巨大风暴）"],[function():void
                  {
                     if(_mc_0)
                     {
                        DisplayUtil.removeForParent(_mc_0);
                     }
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("56_0"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                        QuestManager.completeStep(_quest.id,8);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
   }
}
