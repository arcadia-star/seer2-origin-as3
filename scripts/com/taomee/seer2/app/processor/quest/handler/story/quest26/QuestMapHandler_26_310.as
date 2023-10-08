package com.taomee.seer2.app.processor.quest.handler.story.quest26
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.geom.Point;
   
   public class QuestMapHandler_26_310 extends QuestMapHandler
   {
       
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _mousePoint:Point;
      
      public function QuestMapHandler_26_310(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && QuestManager.isComplete(28))
         {
            this._mousePoint = new Point(487,309);
            ModuleManager.addEventListener("MapSignPanel",ModuleEvent.SHOW,this.onMapPanelShow);
            ModuleManager.addEventListener("MapSignPanel",ModuleEvent.HIDE,this.onMapPanelHide);
            this.addMouseHint(72,490);
         }
      }
      
      private function addMouseHint(param1:Number, param2:Number) : void
      {
         if(this._mouseHint == null)
         {
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
            LayerManager.moduleLayer.addChild(this._mouseHint);
         }
         else
         {
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
         }
      }
      
      private function onMapPanelShow(param1:ModuleEvent) : void
      {
         this.addMouseHint(this._mousePoint.x,this._mousePoint.y);
         LayerManager.moduleLayer.addChild(this._mouseHint);
      }
      
      private function onMapPanelHide(param1:ModuleEvent) : void
      {
         this.addMouseHint(72,490);
      }
      
      private function clearMouseHint() : void
      {
         if(this._mouseHint)
         {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
            this._mouseHint = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this._mousePoint = null;
         ModuleManager.removeEventListener("MapSignPanel",ModuleEvent.SHOW,this.onMapPanelShow);
         ModuleManager.removeEventListener("MapSignPanel",ModuleEvent.HIDE,this.onMapPanelHide);
         this.clearMouseHint();
         super.processMapDispose();
      }
   }
}
