package com.taomee.seer2.app.processor.quest.handler.story.quest62
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_62_40 extends QuestMapHandler
   {
      
      private static var _flag1:int;
      
      private static var _flag2:int;
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_62_40(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,function(param1:ServerBuffer):void
         {
            _flag1 = param1.readDataAtPostion(6);
            _flag2 = param1.readDataAtPostion(7);
            if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false && _flag1 == 1 && _flag2 == 0)
            {
               addTalk();
            }
         });
      }
      
      private function addTalk() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("talk3");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,7,1);
            ModuleManager.toggleModule(URLUtil.getAppModule("CallEveryOneHelpPanel"),"正在打开面板...");
         },true);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
      }
   }
}
