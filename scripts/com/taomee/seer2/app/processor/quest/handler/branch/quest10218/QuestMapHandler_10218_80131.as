package com.taomee.seer2.app.processor.quest.handler.branch.quest10218
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10218_80131 extends QuestMapHandler
   {
       
      
      private var _mc5:MovieClip;
      
      private var _mark:InProgressMark;
      
      public function QuestMapHandler_10218_80131(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10218) && QuestManager.isStepComplete(10218,6) == false)
         {
            this._mark = new InProgressMark();
            this._mark.x = 539;
            this._mark.y = 267;
            _map.front.addChild(this._mark);
            this.initStep6();
         }
      }
      
      private function initStep6() : void
      {
         DialogPanel.addCloseEventListener(this.onClose);
      }
      
      private function onClose(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         var params:String = event.params;
         if(params == "questEnd")
         {
            DialogPanel.removeCloseEventListener(this.onClose);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_6"),function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"我来找你的主要目的就是希望你能够签署联盟契约，一起抵抗黑暗势力。"]],["希望你可以同意！"],[function():void
               {
                  NpcDialog.show(107,"总督大人",[[0,"好的，我们飞翼氏族一定会全力支持你们，一同抵御邪恶势力。"]],["太好了！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_7"),function():void
                     {
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"太好了，那这样联盟契约就已经全部签署完毕了。"]],["哈哈哈！"],[function():void
                        {
                           _mc5 = _processor.resLib.getMovieClip("mc5");
                           _map.front.addChild(_mc5);
                           MovieClipUtil.playMc(_mc5,2,_mc5.totalFrames,function():void
                           {
                              DisplayUtil.removeForParent(_mc5);
                              MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_8"),function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                                 QuestManager.completeStep(10218,6);
                              },true,true);
                           },true);
                        }]);
                     },true,true);
                  }]);
               }]);
            },true,true);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         DisplayUtil.removeForParent(this._mark);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         DisplayUtil.removeForParent(this._mc5);
         DisplayUtil.removeForParent(this._mark);
         DialogPanel.removeCloseEventListener(this.onClose);
         this._mc5 = null;
         super.processMapDispose();
      }
   }
}
