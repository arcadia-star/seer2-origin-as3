package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestTargetManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.map.ResourceLibraryBox;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.constant.QuestType;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import org.taomee.ds.HashMap;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestProcessor
   {
       
      
      protected var _quest:Quest;
      
      protected var _questHandlerMap:HashMap;
      
      protected var _mapModel:MapModel;
      
      protected var _resLib:ResourceLibrary;
      
      protected var _isLoadResLib:Boolean = false;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _inProgressMark:InProgressMark;
      
      public function QuestProcessor(param1:Quest)
      {
         super();
         this._quest = param1;
      }
      
      public function init() : void
      {
         this.initQuest();
      }
      
      private function initQuest() : void
      {
         var _loc1_:int = 0;
         var _loc2_:QuestMapHandler = null;
         this._questHandlerMap = new HashMap();
         for each(_loc1_ in this.quest.getRelatedMapIds())
         {
            _loc2_ = this.createMapHandler(_loc1_);
            if(_loc2_ != null)
            {
               this._questHandlerMap.add(_loc1_,_loc2_);
            }
         }
         if(!SceneManager.isSwitching && Boolean(SceneManager.active))
         {
            this.processMapComplete();
         }
      }
      
      private function createMapHandler(param1:int) : QuestMapHandler
      {
         var _loc3_:Class = null;
         var _loc2_:* = "com.taomee.seer2.app.processor.quest.handler.";
         if(this._quest.type == QuestType.CHAPTER)
         {
            _loc2_ += "main.";
         }
         else if(this._quest.type == QuestType.PET || this._quest.type == QuestType.NPC || this._quest.type == QuestType.OTHER || this._quest.type == QuestType.BEAST)
         {
            _loc2_ += "branch.";
         }
         else if(this._quest.type == QuestType.STORY)
         {
            _loc2_ += "story.";
         }
         else if(this._quest.type == QuestType.ACTIVITY)
         {
            _loc2_ += "activity.";
         }
         _loc2_ += "quest" + this._quest.id + ".";
         try
         {
            _loc3_ = ApplicationDomain.currentDomain.getDefinition(_loc2_ + "QuestMapHandler_" + this._quest.id + "_" + param1) as Class;
         }
         catch(e:Error)
         {
         }
         if(_loc3_ == null)
         {
            return null;
         }
         return new _loc3_(this);
      }
      
      public function processMapComplete() : void
      {
         if(this._isLoadResLib && this._resLib == null)
         {
            QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/" + this._quest.id),LoadType.DOMAIN,this.onLoadComplete);
         }
         else
         {
            this.initHandlerMap();
         }
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this._isLoadResLib = false;
         if(this.checkOldQuestId(this._quest.id))
         {
            this._resLib = new ResourceLibraryBox(param1.content);
         }
         else
         {
            this._resLib = new ResourceLibrary(param1.content);
         }
         this.initHandlerMap();
      }
      
      private function checkOldQuestId(param1:uint) : Boolean
      {
         if(param1 >= 30001 && param1 <= 30052)
         {
            return true;
         }
         if(param1 >= 10001 && param1 <= 10227)
         {
            return true;
         }
         if(param1 > 1 && param1 <= 73)
         {
            return true;
         }
         return false;
      }
      
      private function initHandlerMap() : void
      {
         var _loc1_:MapModel = SceneManager.active.mapModel;
         if(this.quest.getCurrentOrNextStep().target != null)
         {
            QuestTargetManager.initTarget(this.quest);
         }
         if(this._questHandlerMap.containsKey(_loc1_.resourceId))
         {
            this._mapModel = _loc1_;
            QuestMapHandler(this._questHandlerMap.getValue(_loc1_.resourceId)).processMapComplete();
         }
      }
      
      public function processMapDispose() : void
      {
         var _loc1_:MapModel = SceneManager.active.mapModel;
         if(this._isLoadResLib)
         {
            return;
         }
         if(this._questHandlerMap.containsKey(_loc1_.resourceId))
         {
            this._mapModel = _loc1_;
            QuestMapHandler(this._questHandlerMap.getValue(_loc1_.resourceId)).processMapDispose();
         }
         this.hideInProgressMark();
         this.hideMouseClickHint();
      }
      
      public function get mouseHint() : Sprite
      {
         if(this._mouseHint == null)
         {
            this._mouseHint = new MouseClickHintSprite();
         }
         return this._mouseHint;
      }
      
      public function showMouseHintAt(param1:Number, param2:Number, param3:Sprite = null, param4:Boolean = true) : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = new MouseClickHintSprite();
         if(param4)
         {
            this._mouseHint.x = param1 + 150;
            this._mouseHint.y = param2 + 50;
         }
         else
         {
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
         }
         if(param3)
         {
            param3.addChild(this._mouseHint);
         }
         else
         {
            LayerManager.mapLayer.addChild(this._mouseHint);
         }
      }
      
      public function showMouseHintOver(param1:DisplayObject, param2:Point = null) : void
      {
         var _loc3_:Rectangle = param1.getBounds(LayerManager.stage);
         var _loc4_:Number = _loc3_.left + _loc3_.width / 2;
         var _loc5_:Number = _loc3_.top;
         if(param2 != null)
         {
            _loc4_ += param2.x;
            _loc5_ += param2.y;
         }
         this.showMouseHintAt(_loc4_,_loc5_,null,false);
      }
      
      public function hideMouseClickHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
      }
      
      public function showInProgressMarkOver(param1:DisplayObject) : void
      {
         this._inProgressMark = new InProgressMark();
         var _loc2_:Rectangle = param1.getBounds(LayerManager.stage);
         this._inProgressMark.x = _loc2_.left + _loc2_.width / 2;
         this._inProgressMark.y = _loc2_.top;
         this._mapModel.content.addChild(this._inProgressMark);
      }
      
      public function hideInProgressMark() : void
      {
         if(this._inProgressMark != null)
         {
            DisplayObjectUtil.removeFromParent(this._inProgressMark);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:QuestMapHandler = null;
         for each(_loc1_ in this._questHandlerMap.getValues())
         {
            _loc1_.dispose();
         }
         this._questHandlerMap.clear();
         this._questHandlerMap = null;
         this.hideMouseClickHint();
         this.hideInProgressMark();
         this._mouseHint = null;
         this._mapModel = null;
      }
      
      public function get mapModel() : MapModel
      {
         return this._mapModel;
      }
      
      public function get quest() : Quest
      {
         return this._quest;
      }
      
      public function get resLib() : ResourceLibrary
      {
         return this._resLib;
      }
      
      public function getMcFromLib(param1:String) : MovieClip
      {
         return this._resLib.getMovieClip(param1).getChildAt(0) as MovieClip;
      }
   }
}
