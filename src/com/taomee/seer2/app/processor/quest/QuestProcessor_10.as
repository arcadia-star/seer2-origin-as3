package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestProcessor_10 extends QuestProcessor
   {
       
      
      private var _isInit:Boolean = false;
      
      private var _petStep:int = 0;
      
      public var hasEnterDream:Boolean = false;
      
      public function QuestProcessor_10(param1:Quest)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/10"),LoadType.DOMAIN,this.onLoadComplete);
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         _resLib = new ResourceLibrary(param1.content);
         this._isInit = true;
         super.init();
      }
      
      override public function processMapComplete() : void
      {
         if(this._isInit)
         {
            super.processMapComplete();
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._isInit)
         {
            super.processMapDispose();
         }
      }
      
      public function addPetStep() : void
      {
         ++this._petStep;
      }
      
      public function get petStep() : int
      {
         return this._petStep;
      }
   }
}
