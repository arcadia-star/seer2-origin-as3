package com.taomee.seer2.app.processor.quest.handler.activity.quest30054
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30054_240 extends QuestMapHandler
   {
       
      
      private var _count:uint;
      
      private var _server:ServerBuffer;
      
      private var _itemList:Vector.<MovieClip>;
      
      public function QuestMapHandler_30054_240(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL,this.onGerServer);
         }
      }
      
      private function onGerServer(param1:ServerBuffer) : void
      {
         var _loc2_:MovieClip = null;
         this._server = param1;
         this._count = param1.readDataAtPostion(3);
         if(this._count < 2)
         {
            this._itemList = Vector.<MovieClip>([]);
            this._itemList.push(_processor.resLib.getMovieClip("item4"));
            this._itemList.push(_processor.resLib.getMovieClip("item5"));
            SceneManager.active.mapModel.content.addChild(this._itemList[0]);
            SceneManager.active.mapModel.content.addChild(this._itemList[1]);
            for each(_loc2_ in this._itemList)
            {
               _loc2_.buttonMode = true;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onItem);
            }
         }
      }
      
      private function onItem(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DisplayUtil.removeForParent(event.currentTarget as MovieClip);
         if(this._count < 2)
         {
            this._count += 1;
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL,3,this._count);
            ServerMessager.addMessage("获得1个护甲碎片");
            if(this._count >= 2 && this._server.readDataAtPostion(1) >= 2 && this._server.readDataAtPostion(2) >= 2)
            {
               if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
               {
                  QuestManager.completeStep(_quest.id,1);
               }
               AlertManager.showAlert("恭喜你搜集齐所有的材料",function():void
               {
                  StatisticsManager.newSendNovice("2014活动","帝王战袍","完成护甲制作");
                  ModuleManager.showAppModule("MakeTabardPanel");
               });
            }
            else if(this._count >= 2)
            {
               DisplayUtil.removeForParent(this._itemList[0]);
               DisplayUtil.removeForParent(this._itemList[1]);
               ModuleManager.showAppModule("MakeTabardArmorPanel");
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         if(Boolean(this._itemList) && Boolean(this._itemList[0]))
         {
            DisplayUtil.removeForParent(this._itemList[0]);
         }
         if(Boolean(this._itemList) && Boolean(this._itemList[1]))
         {
            DisplayUtil.removeForParent(this._itemList[1]);
         }
      }
   }
}
