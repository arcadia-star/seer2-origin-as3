package com.taomee.seer2.app.processor.quest.handler.main.quest1
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.controls.widget.YueseNonoWidgetClick;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_1_6 extends QuestMapHandler
   {
       
      
      private var _mc1_0:MovieClip;
      
      private var _mc0:MovieClip;
      
      private var _toolBar:MovieClip;
      
      private var _mapMC:MovieClip;
      
      private var _rightMC:MovieClip;
      
      private var _isShowPanel:Boolean;
      
      private var _mc1_1:MovieClip;
      
      private var _mc1_2:MovieClip;
      
      private var _mc1_2_1:MovieClip;
      
      private var _mc1_3:MovieClip;
      
      private var _newMC:MovieClip;
      
      public function QuestMapHandler_1_6(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.showRemoteActor = false;
         this._toolBar = _map.front["toolbar"];
         NewGuidStatisManager.newPlayerStatisHandle(1);
         if(_quest.isStepCompletable(1))
         {
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         this._mc0 = UIManager.getMovieClip("NewGudie_MC");
         _map.front.addChild(this._mc0);
         NewGuidStatisManager.newPlayerStatisHandle(2);
         LayerManager.mapLayer.addEventListener(MouseEvent.CLICK,this.onSelectPetClick);
         this._mc0.buttonMode = true;
      }
      
      private function onSelectPetClick(param1:MouseEvent) : void
      {
         LayerManager.mapLayer.removeEventListener(MouseEvent.CLICK,this.onSelectPetClick);
         this._mc0.visible = false;
         this._mc1_1 = _processor.resLib.getMovieClip("mc1_1");
         _map.front.addChild(this._mc1_1);
         NewGuidStatisManager.newPlayerStatisHandle(3);
         LayerManager.mapLayer.addEventListener(MouseEvent.CLICK,this.onMcClick1);
      }
      
      private function onMcClick1(param1:MouseEvent) : void
      {
         LayerManager.mapLayer.removeEventListener(MouseEvent.CLICK,this.onMcClick1);
         this._mc1_1.gotoAndStop(2);
         LayerManager.mapLayer.addEventListener(MouseEvent.CLICK,this.onNewMcClick);
      }
      
      private function onNewMcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         LayerManager.mapLayer.removeEventListener(MouseEvent.CLICK,this.onNewMcClick);
         DisplayObjectUtil.removeFromParent(this._mc1_1);
         this._newMC = _processor.resLib.getMovieClip("newMC");
         _map.front.addChild(this._newMC);
         MovieClipUtil.playMc(this._newMC,1,this._newMC.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_newMC);
            QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
            QuestManager.completeStep(_quest.id,1);
         });
      }
      
      private function nextQuest() : void
      {
         this._mc1_3 = _processor.resLib.getMovieClip("mc1_3");
         _map.front.addChild(this._mc1_3);
         MovieClipUtil.playMc(this._mc1_3,1,this._mc1_3.totalFrames,function():void
         {
            NpcDialog.showForNew(6,"克拉克",[[0,"看来小梦具有潜在的王者力量！小赛尔你还需要经过一番历练！"],[0,"前往船长室，小梦会陪伴你通过辛迪船长的试炼！"]],"好的",function():void
            {
               var _loc1_:uint = new Date(2014,8,26).getTime() / 1000;
               if(ActorManager.actorInfo.createTime > _loc1_ && !NewPlayerGuideTimeManager.timeCheckNewGuide())
               {
                  DisplayUtil.removeForParent(ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO));
                  RightToolbarConter.instance.initEvent();
                  SceneManager.changeScene(SceneType.COPY,80351);
               }
               else if(NewPlayerGuideTimeManager.timeCheckNewGuide())
               {
                  DisplayUtil.removeForParent(ToolBar.getBtn(YueseNonoWidgetClick.YUESE_NONO));
                  RightToolbarConter.instance.initEvent();
                  SceneManager.changeScene(SceneType.COPY,80491);
               }
               else
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
               }
            });
         },true);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         StatisticsManager.newSendNovice("新手引导tyler版tyler版","2014上半年版新手引导tyler版","完成场景动画1");
         NewGuidStatisManager.newPlayerStatisHandle(4);
         this._mc1_2 = _processor.resLib.getMovieClip("mc1_2");
         _map.content.addChild(this._mc1_2);
         this._mc0.visible = false;
         StatisticsManager.newSendNovice("新手引导tyler版tyler版","2014上半年版新手引导tyler版","进入警报场景动画");
         MovieClipUtil.playMc(this._mc1_2,1,this._mc1_2.totalFrames,function():void
         {
            StatisticsManager.newSendNovice("新手引导tyler版tyler版","2014上半年版新手引导tyler版","完成警报场景动画");
            DisplayUtil.removeForParent(_mc1_2);
            nextQuest();
         });
      }
      
      override public function dispose() : void
      {
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         _processor = null;
         _quest = null;
         LayerManager.mapLayer.removeEventListener(MouseEvent.CLICK,this.onSelectPetClick);
         LayerManager.mapLayer.removeEventListener(MouseEvent.CLICK,this.onMcClick1);
         DisplayUtil.removeForParent(this._mc0);
         DisplayUtil.removeForParent(this._mc1_1);
         DisplayUtil.removeForParent(this._mc1_2);
         DisplayUtil.removeForParent(this._mc1_2_1);
         DisplayUtil.removeForParent(this._mc1_3);
         PetAvatarPanel.recoverPanel();
      }
   }
}
