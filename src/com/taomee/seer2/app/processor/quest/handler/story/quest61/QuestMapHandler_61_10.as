package com.taomee.seer2.app.processor.quest.handler.story.quest61
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_61_10 extends QuestMapHandler
   {
      
      private static var _flag:int;
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_61_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,function(param1:ServerBuffer):void
         {
            _flag = param1.readDataAtPostion(5);
            if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false && _flag == 0)
            {
               addNPC();
            }
         });
      }
      
      private function addNPC() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("ma5");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onMoutherTalk);
      }
      
      private function onMoutherTalk(param1:MouseEvent) : void
      {
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onMoutherTalk);
         this.addFull();
      }
      
      private function addFull() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("61_0"),function():void
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,5,1);
            ergodicServerBuffer();
         },true,false,2);
      }
      
      private function ergodicServerBuffer() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,function(param1:ServerBuffer):void
         {
            var flag:int = 0;
            var num:int = 0;
            var sev:ServerBuffer = param1;
            var i:int = 1;
            while(i < 6)
            {
               flag = sev.readDataAtPostion(i);
               if(flag == 0)
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("FindSeanPanel"),"正在打开面板...");
                  return;
               }
               num++;
               i++;
            }
            if(num == 5)
            {
               NpcDialog.show(171,"SEAN的妈妈",[[0,"呜呜呜…我大老远过来找我的儿子，还给他带了过冬的衣服和亲手做的点心…呜呜呜…"]],["(⊙o⊙)…你先别伤心我们去资料室看看吧"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
                  QuestManager.completeStep(_quest.id,1);
               }]);
            }
         });
      }
      
      private function onStepConpleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,30);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
      }
   }
}
