package com.taomee.seer2.app.processor.quest.handler.branch.quest10210
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10210_80077 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _accept:AcceptableMark;
      
      public function QuestMapHandler_10210_80077(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10210) && QuestManager.isStepComplete(10210,1) == false)
         {
            this.initQuest1();
         }
      }
      
      private function initQuest1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.content.addChild(this._mc1);
         this._accept = new AcceptableMark();
         _map.front.addChild(this._accept);
         this._accept.x = 606;
         this._accept.y = 298;
         this._mc1["npc"].buttonMode = true;
         this._mc1["npc"].addEventListener(MouseEvent.CLICK,this.onMC1);
      }
      
      private function onMC1(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(652,"拜瑞",[[0,"你们终于醒了，胆子真够大的，竟敢跑到这里来？/:08"]],["为什么不能来？你又是谁？"],[function():void
         {
            NpcDialog.show(652,"拜瑞",[[0,"我是天马四骑士之一的“拜瑞”。/:17"]],["天马四骑士？听上去好霸气啊！"],[function():void
            {
               NpcDialog.show(652,"拜瑞",[[0,"好了，既然你们都已经醒了/:03，那就赶快回家吧，我还要继续去追踪“魔域四将”/:00。"]],["“魔域四将”又是什么？"],[function():void
               {
                  NpcDialog.show(652,"拜瑞",[[0,"这些都是秘密/:07，我现在必须要出发了，我们有缘再见吧！/:22"]],["等等……"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10210_1"),function():void
                     {
                        NpcDialog.show(10,"巴蒂",[[0,"这应该是古老的隐形文字/:06，我在一本古书上曾看到过类似的情况/:15"]],["隐形文字？那有办法看到吗？"],[function():void
                        {
                           NpcDialog.show(10,"巴蒂",[[0,"办法是有/:18，但可能需要准备一些材料。/:23"]],["什么材料呢？"],[function():void
                           {
                              NpcDialog.show(10,"多罗",[[0,"先去荆棘小道、异磨谷附近寻找下材料A和材料B吧！/:04"]],["好的，我这就去！"],[function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                                 QuestManager.completeStep(10210,1);
                              }]);
                           }]);
                        }]);
                     },true,true,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80078);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.processMapDispose();
         if(this._mc1)
         {
            this._mc1["npc"].removeEventListener(MouseEvent.CLICK,this.onMC1);
         }
         DisplayUtil.removeForParent(this._accept);
         DisplayUtil.removeForParent(this._mc1);
      }
   }
}
