package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestProcessor_10036 extends QuestProcessor
   {
      
      public static var count:uint = 0;
      
      private static var mapArr:Array = [60,50,30,20,10,70,40];
       
      
      private var _mc:MovieClip;
      
      private var _mapID:uint;
      
      private var _close:SimpleButton;
      
      public function QuestProcessor_10036(param1:Quest)
      {
         _isLoadResLib = true;
         super(param1);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(QuestManager.isStepComplete(10036,1) && QuestManager.isStepComplete(10036,2) == false)
         {
            this._mapID = SceneManager.active.mapModel.id;
            if(mapArr.indexOf(this._mapID) != -1)
            {
               this.showPanel();
            }
         }
      }
      
      private function showPanel() : void
      {
         if(resLib == null)
         {
            return;
         }
         if(this._mc == null)
         {
            this._mc = resLib.getMovieClip("mc_1");
         }
         ++count;
         this._close = this._mc["closeBtn"];
         this._close.addEventListener(MouseEvent.CLICK,this.onCloseClick);
         this._mc["map" + this._mapID].gotoAndStop(2);
         DisplayUtil.align(this._mc);
         LayerManager.topLayer.addChild(this._mc);
         mapArr.splice(mapArr.indexOf(this._mapID),1);
         if(count >= 7)
         {
            QuestManager.completeStep(10036,2);
         }
      }
      
      private function onCloseClick(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._mc);
         this._close = null;
         var _loc2_:int = 7 - count;
         if(_loc2_ <= 0)
         {
            ServerMessager.addMessage("已经巡逻完毕");
         }
         else
         {
            ServerMessager.addMessage("还差" + _loc2_ + "个场景");
         }
      }
      
      override public function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         if(this._close)
         {
            this._close.removeEventListener(MouseEvent.CLICK,this.onCloseClick);
            this._close = null;
         }
         DisplayUtil.removeForParent(this._mc);
         super.dispose();
      }
   }
}
