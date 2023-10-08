package com.taomee.seer2.app.processor.quest.handler.main.quest121
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_121_80610 extends QuestMapHandler
   {
       
      
      private var isStartFight:Boolean = false;
      
      private const fightId:int = 1890;
      
      private var mv:MovieClip;
      
      public function QuestMapHandler_121_80610(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         this.mv = SceneManager.active.mapModel.content["mv"];
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         if(this.isStartFight)
         {
            return;
         }
         NpcDialog.showDialogsByText("quest/dialog/121/2.json",function():void
         {
            mv.gotoAndStop(1);
            MovieClipUtil.playMc(mv.mc,2,mv.mc.totalFrames,function():void
            {
               NpcDialog.showDialogsByText("quest/dialog/121/3.json",function():void
               {
                  isStartFight = true;
                  SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onFightOver);
                  FightManager.startFightWithWild(fightId);
               },null);
            });
         },null);
      }
      
      private function onFightOver(param1:* = null) : void
      {
         var e:* = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onFightOver);
            if(this.fightId == FightManager.currentFightRecord.initData.positionIndex)
            {
               NpcDialog.showDialogsByText("quest/dialog/121/4.json",function():void
               {
                  mv.gotoAndStop(2);
                  MovieClipUtil.playMc(mv.mc,2,mv.mc.totalFrames,function():void
                  {
                     NpcDialog.showDialogsByText("quest/dialog/121/5.json",function():void
                     {
                        mv.gotoAndStop(3);
                        MovieClipUtil.playMc(mv.mc,2,mv.mc.totalFrames,function():void
                        {
                           NpcDialog.showDialogsByText("quest/dialog/121/6.json",function():void
                           {
                              SceneManager.changeScene(SceneType.COPY,80611);
                           },null);
                        });
                     },null);
                  });
               },null);
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
