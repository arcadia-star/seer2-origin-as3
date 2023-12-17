package com.taomee.seer2.app.processor.quest.handler.branch.quest10221
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.Interactive_10221;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10221_80143 extends QuestMapHandler
   {
       
      
      private var _mc1_1:MovieClip;
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _makeStone:Interactive_10221;
      
      private var _captain:Mobile;
      
      private var _inMark:InProgressMark;
      
      public function QuestMapHandler_10221_80143(param1:QuestProcessor)
      {
         super(param1);
      }
      
      private static function onDiaLogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.content == 1)
         {
            _loc2_ = 0;
            while(_loc2_ < DialogPanel.functionalityBox.getUnitList().length)
            {
               if(DialogPanel.functionalityBox.getUnitList()[_loc2_].label != "约瑟降临")
               {
                  DialogPanel.functionalityBox.removeUnit(DialogPanel.functionalityBox.getUnitList()[_loc2_]);
               }
               _loc2_++;
            }
         }
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10221) && QuestManager.isStepComplete(10221,1) == false)
         {
            this.initStep1();
         }
         else if(QuestManager.isAccepted(10221) && QuestManager.isStepComplete(10221,3) == false)
         {
            this.initStep3();
         }
      }
      
      private function initStep3() : void
      {
         this._captain = MobileManager.getMobile(354,MobileType.NPC);
         this._captain.visible = false;
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.front.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,2,this._mc1.totalFrames,function():void
         {
            NpcDialog.show(6,"克拉克",[[0,"可恶的萨伦帝国，又是他们捣的鬼。"]],["现在该怎么办啊？"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10221_2"),function():void
               {
                  DisplayUtil.removeForParent(_mc1);
                  _mc2 = _processor.resLib.getMovieClip("mc2");
                  _map.front.addChild(_mc2);
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哇~这是不是传说中的女战神——缪斯呀？"]],["威武女汉子！"],[function():void
                  {
                     NpcDialog.show(705,"缪斯",[[0,"是的。"]],["缪斯，你怎么出现了？"],[function():void
                     {
                        NpcDialog.show(705,"缪斯",[[0,"是“他”把我召唤到这里的！"]],["谁啊？"],[function():void
                        {
                           DisplayUtil.removeForParent(_mc2);
                           _mc3 = _processor.resLib.getMovieClip("mc3");
                           _map.front.addChild(_mc3);
                           MovieClipUtil.playMc(_mc3,2,_mc3.totalFrames,function():void
                           {
                              NpcDialog.show(6,"卡拉克",[[0,"是圣兽天尊！"]],["又能看到圣兽天尊了，太棒了！"],[function():void
                              {
                                 NpcDialog.show(705,"缪斯",[[0,"对，是圣兽天尊在呼唤我，所以我就从遥远的天蛇星赶来了！"]],["太好了，战神联盟又多了一员猛将啊！"],[function():void
                                 {
                                    NpcDialog.show(702,"天马",[[0,"事不延迟，我们赶快去找拯救王魄吧！"]],["好的，那我们出发吧！"],[function():void
                                    {
                                       _makeStone = new Interactive_10221();
                                       _makeStone.setup("interactive_10221");
                                       _makeStone.addEventListener(Event.CLOSE,onCloseAnimation);
                                       _makeStone.addEventListener(AnimationEvent.STONE,onMakeBubbleOver);
                                    }]);
                                 }]);
                              }]);
                           },true);
                        }]);
                     }]);
                  }]);
               },true,true);
            }]);
         },true);
      }
      
      private function onCloseAnimation(param1:Event) : void
      {
         this._makeStone.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeStone.removeEventListener(AnimationEvent.STONE,this.onMakeBubbleOver);
         this.complete3();
      }
      
      private function onMakeBubbleOver(param1:Event) : void
      {
         this._makeStone.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeStone.removeEventListener(AnimationEvent.STONE,this.onMakeBubbleOver);
         this.complete3();
      }
      
      private function complete3() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(10221,3);
      }
      
      private function initStep1() : void
      {
         this._mc1_1 = _processor.resLib.getMovieClip("mc1_1");
         _map.content.addChild(this._mc1_1);
         this._inMark = new InProgressMark();
         _map.content.addChild(this._inMark);
         this._inMark.x = 236;
         this._inMark.y = 192;
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,onDiaLogShow);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.questId == 10221 && param1.stepId == 1)
         {
            SceneManager.changeScene(SceneType.COPY,80144);
         }
         else if(param1.questId == 10221 && param1.stepId == 3)
         {
            SceneManager.changeScene(SceneType.COPY,80145);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DisplayUtil.removeForParent(this._inMark);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,onDiaLogShow);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(this._makeStone)
         {
            this._makeStone.removeEventListener(Event.CLOSE,this.onCloseAnimation);
            this._makeStone.removeEventListener(AnimationEvent.STONE,this.onMakeBubbleOver);
         }
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._mc3);
      }
   }
}
