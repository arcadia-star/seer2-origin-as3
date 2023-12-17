package com.taomee.seer2.app.processor.quest.handler.branch.quest10004
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10004_132 extends BranchQuestMapHandler
   {
       
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_10004_132(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:XML = null;
         super.processMapComplete();
         if(QuestManager.isStepComplete(_questId,6) && !QuestManager.isStepComplete(_questId,7))
         {
            _loc1_ = <npc id="411" resId="411" name="" dir="1" width="25" height="50" pos="450,400" actorPos="500,400" path="">
						<dialog npcId="411" npcName="晓月兔" transport="1,300,400">
							<branch id="default" npcId="411" npcName="晓月兔">
								<node emotion="0"><![CDATA[如果你是萨伦帝国的人，请走开！我们身上已经没有你想要的东西了！]]></node>
								<reply action="close"><![CDATA[听不懂你在说什么，再见！]]></reply>
							</branch>
						</dialog>
					</npc>;
            initNpc(_loc1_);
            tip = "到荆棘林采集1个夜明珠给晓晓。";
            DialogPanel.addCloseEventListener(this.onClose);
         }
      }
      
      private function onClose(param1:DialogCloseEvent) : void
      {
         var evt:DialogCloseEvent = param1;
         if(evt.params == "playQuest10004Animation")
         {
            DialogPanel.removeCloseEventListener(this.onClose);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10004_0"),function():void
            {
               DialogPanel.showForSimple(411,"晓月兔",[[0,"现在，我们是全新的“晓月兔”。今天，你的礼物就是我们啦！我们决定成为你的精灵！"]],"哇~~~~真的！",gotoBranch);
            });
         }
      }
      
      private function gotoBranch() : void
      {
         DialogPanel.showForSimple(411,"晓月兔",[[0,"当然！现在我是超能系的精灵哦！小主人，我们走吧！"]],"耶！太好啦！",this.playQuestAnimation);
      }
      
      private function playQuestAnimation() : void
      {
         this._mc = _processor.resLib.getMovieClip("mc_4");
         LayerManager.topLayer.addChild(this._mc);
         MovieClipUtil.playMc(this._mc,1,this._mc.totalFrames,function():void
         {
            QuestManager.completeStep(_questId,7);
            DisplayObjectUtil.removeFromParent(_mc);
            _mc = null;
         },true);
      }
   }
}
