package com.taomee.seer2.app.processor.quest.handler.activity.quest30010
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
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
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30010_470 extends QuestMapHandler
   {
       
      
      private var screwMc:MovieClip;
      
      private var repairNum:int = 0;
      
      private var diaMc:MovieClip;
      
      private var markMc:MouseClickHintSprite;
      
      public function QuestMapHandler_30010_470(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.initStep2();
         }
      }
      
      private function initStep2() : void
      {
         _map.content["wheel"].visible = false;
         this.screwMc = _processor.resLib.getMovieClip("screwMc");
         this.screwMc.x = 205;
         this.screwMc.y = 108;
         this.screwMc.gotoAndStop(1);
         _map.content.addChild(this.screwMc);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.showScrew);
      }
      
      private function showScrew(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "30010_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.showScrew);
            this.repairNum = 0;
            this.screwMc.buttonMode = true;
            this.markMc = new MouseClickHintSprite();
            this.markMc.x = 20;
            this.markMc.y = 100;
            this.screwMc.addChild(this.markMc);
            this.screwMc.addEventListener(MouseEvent.CLICK,this.repairScrew);
         }
      }
      
      private function repairScrew(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         ++this.repairNum;
         if(this.repairNum == 1)
         {
            MovieClipUtil.playMc(this.screwMc,1,2);
         }
         else
         {
            this.screwMc.removeChild(this.markMc);
            this.screwMc.removeEventListener(MouseEvent.CLICK,this.repairScrew);
            this.screwMc.buttonMode = false;
            MovieClipUtil.playMc(this.screwMc,2,this.screwMc.totalFrames,function():void
            {
               diaMc = _processor.resLib.getMovieClip("Dia30010_1");
               LayerManager.topLayer.addChild(diaMc);
               _map.content["wheel"].visible = true;
               _map.content.removeChild(screwMc);
               MovieClipUtil.playMc(diaMc,1,diaMc.totalFrames,function():void
               {
                  LayerManager.topLayer.removeChild(diaMc);
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"吉吉以后聊，我现在有急着去异蘑小径！刚才怎么又仿佛看到米咔了？又是幻影？"]],["不知道舒尔怎么了，快去看看！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,completeStep2);
                     QuestManager.completeStep(_quest.id,2);
                  }]);
               },true);
            },true);
         }
      }
      
      private function completeStep2(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep2);
            SceneManager.changeScene(SceneType.LOBBY,123);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep2);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.showScrew);
         if(this.screwMc)
         {
            this.screwMc.removeEventListener(MouseEvent.CLICK,this.repairScrew);
         }
         if(Boolean(this.diaMc) && Boolean(LayerManager.topLayer.contains(this.diaMc)))
         {
            LayerManager.topLayer.removeChild(this.diaMc);
         }
         super.processMapDispose();
      }
   }
}
