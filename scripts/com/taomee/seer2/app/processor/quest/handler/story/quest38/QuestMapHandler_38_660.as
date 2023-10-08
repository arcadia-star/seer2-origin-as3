package com.taomee.seer2.app.processor.quest.handler.story.quest38
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
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
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_38_660 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_38_660(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.intMc();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.intMc();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep2);
         }
      }
      
      private function intMc() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "38_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            this.processStep0();
         }
      }
      
      private function onStep2(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "38_3")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep2);
            this.processStep2();
         }
      }
      
      private function processStep0() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("38_0"),function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[0,"缇娜女王？"]],["就是萨伦帝国的女王！是坏人！"],[function():void
            {
               NpcDialog.show(87,"刚铎",[[0,"关于萨伦帝国我略有耳闻——该势力居于不被阳光所照耀的地域。星际使者想必与他们交过手？"]],["哼！从这点上来说，我们也算是老朋友了！"],[function():void
               {
                  NpcDialog.show(83,"萨伯尔兵团长",[[0,"刚铎……我的心情非常矛盾，想要相信你，却希望你的预料都是错误的。我在此正式委托你们二位去时镜之岛使用观测台。"]],["观测台？那个我熟悉！去时镜之岛！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                     QuestManager.accept(_quest.id);
                  }]);
               }]);
            }]);
         },true,false,2);
      }
      
      private function processStep2() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"萨伦帝国让博士潜入飞翼氏族，并拉拢了财务官，为了一个可怕的目的：剥离神兽的力量！！"]],["大致就是这样。"],[function():void
         {
            NpcDialog.show(87,"刚铎",[[0,"萨伯尔，此事比我们想象的都要严重。这个节骨眼上，我希望你能够振作起来……不要再重蹈当年的覆辙。"]],["（重蹈当年的覆辙？）"],[function():void
            {
               NpcDialog.show(83,"萨伯尔兵团长",[[0,"是……我已经明白了。我会向总督禀报此事，并获取逮捕令……正式通缉财务官……不，那个出卖了飞翼氏族的人！！"]],["还有斯坦因博士，我一定要亲手……抓住你！！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                  QuestManager.completeStep(_quest.id,2);
               }]);
            }]);
         }]);
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         DisplayUtil.removeForParent(this._mc_0);
         SceneManager.changeScene(SceneType.LOBBY,700);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         if(param1.questId == 38)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
   }
}
