package com.taomee.seer2.app.activity.processor.PrizeCeremony
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class Map160Prize
   {
       
      
      private var _ALLMc:MovieClip;
      
      private var _mc:MovieClip;
      
      public function Map160Prize()
      {
         super();
         ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,function(param1:ServerBuffer):void
         {
            var _loc2_:int = param1.readDataAtPostion(4);
            if(_loc2_ == 0)
            {
               initMC();
               ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,4,1);
            }
         });
      }
      
      private function initMC() : void
      {
         var _loc1_:String = String(URLUtil.getActivityAnimation("PrizeCeremony"));
         QueueLoader.load(_loc1_,LoadType.SWF,this.onTakePicLoaded);
      }
      
      private function onTakePicLoaded(param1:ContentInfo) : void
      {
         var info:ContentInfo = param1;
         var _ALLMc:MovieClip = info.content as MovieClip;
         this._mc = _ALLMc["mc_1"] as MovieClip;
         LayerManager.moduleLayer.addChild(this._mc);
         MovieClipUtil.playMc(this._mc,1,this._mc.totalFrames,function():void
         {
            Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060,onGerRewardError);
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060,onGetRewardSuccess);
            Connection.send(CommandSet.DIGGER_MINE_1060,156);
         },true);
      }
      
      private function onGerRewardError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,this.onGerRewardError);
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,this.onGetRewardSuccess);
      }
      
      private function onGetRewardSuccess(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,this.onGerRewardError);
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,this.onGetRewardSuccess);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_85);
         var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
         _loc2_.showResult(true);
      }
      
      public function dispose() : void
      {
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,this.onGerRewardError);
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,this.onGetRewardSuccess);
      }
   }
}
