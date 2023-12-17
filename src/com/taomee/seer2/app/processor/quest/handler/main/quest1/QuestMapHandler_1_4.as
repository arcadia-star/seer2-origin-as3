package com.taomee.seer2.app.processor.quest.handler.main.quest1
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_1_4 extends QuestMapHandler
   {
      
      private static var isFight:Boolean = false;
       
      
      private var _mc1_1:MovieClip;
      
      private var _mc1_2:MovieClip;
      
      private var _mc1_2_0:MovieClip;
      
      private var _mc1_3:MovieClip;
      
      public function QuestMapHandler_1_4(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.gotoCaptenMap);
         super.processMapComplete();
         ActorManager.showRemoteActor = false;
         if(_quest.isStepCompletable(3))
         {
            if(isFight == false)
            {
               this.processStep3();
            }
            else
            {
               this._mc1_1 = _processor.resLib.getMovieClip("mc1_1");
               _map.front.addChild(this._mc1_1);
               NpcDialog.show(6,"克拉克",[[0,"是不是学会战斗了，要不要再看一遍？"]],["不用了","好的，好的！"],[function():void
               {
                  processStepArena2();
               },function():void
               {
                  isFight = true;
                  FightManager.startFightWithGudiePet(100000);
               }]);
               StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","完成战斗教学");
            }
         }
      }
      
      private function processStep3() : void
      {
         this._mc1_1 = _processor.resLib.getMovieClip("mc1_1");
         _map.front.addChild(this._mc1_1);
         NpcDialog.showForNew(6,"克拉克",[[0,ActorManager.actorInfo.nick + "下面我就教你该如何战斗，你可得看好了！"]],"好的，好的！",function():void
         {
            isFight = true;
            StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","进入战斗教学");
            FightManager.startFightWithGudiePet(100000);
         });
      }
      
      private function processStepArena2() : void
      {
         StatisticsManager.sendNovice("0x10034688");
         NpcDialog.showForNew(6,"多罗",[[0,"太好了，教官把坏蛋都打跑了！"]],"教官真厉害！",function():void
         {
            NpcDialog.showForNew(6,"克拉克",[[0,ActorManager.actorInfo.nick + "，刚才的战斗教学你都看明白了吗？"]],"看明白了！",function():void
            {
               DisplayUtil.removeForParent(_mc1_1);
               _mc1_2 = _processor.resLib.getMovieClip("mc1_2");
               _map.front.addChild(_mc1_2);
               StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","播放场景动画4");
               MovieClipUtil.playMc(_mc1_2,2,_mc1_2.totalFrames,function():void
               {
                  StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","成功播放场景动画4");
                  _mc1_2_0 = _processor.resLib.getMovieClip("mc1_2_0");
                  _map.front.addChild(_mc1_2_0);
                  MovieClipUtil.playMc(_mc1_2_0,2,_mc1_2_0.totalFrames,function():void
                  {
                     _mc1_2_0.addEventListener(MouseEvent.CLICK,onMC1);
                  },true);
               },true);
            });
         });
      }
      
      private function onMC1(param1:MouseEvent) : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepCompleteQuest);
         QuestManager.completeStep(_quest.id,3);
      }
      
      private function onStepCompleteQuest(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepCompleteQuest);
         DisplayUtil.removeForParent(this._mc1_2_0);
         NpcDialog.showForNew(6,"克拉克",[[0,"你已经是一个合格的精灵训练师了，快去船长室接受船长辛迪的授勋吧。"]],"太棒了，我这就去！",function():void
         {
            _mc1_3 = _processor.resLib.getMovieClip("mc1_3");
            LayerManager.stage.addChild(_mc1_3);
            _mc1_3.addEventListener(MouseEvent.CLICK,onGo);
         });
      }
      
      private function onGo(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._mc1_3);
         StatisticsManager.sendNovice("0x1003468D");
         SceneManager.changeScene(SceneType.NOVICE,5);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DisplayUtil.removeForParent(this._mc1_3);
         DisplayUtil.removeForParent(this._mc1_2);
         DisplayUtil.removeForParent(this._mc1_1);
         DisplayUtil.removeForParent(this._mc1_2_0);
         PetAvatarPanel.recoverPanel();
      }
   }
}
