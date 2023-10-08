package com.taomee.seer2.app.processor.activity.AbaoTravel
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class AbaoTravelSayByebye
   {
       
      
      private var _abaoMC:MovieClip;
      
      private var _peopleMC:MovieClip;
      
      private var _resLib:ResourceLibrary;
      
      public function AbaoTravelSayByebye()
      {
         super();
         this.getURL();
         setTimeout(this.initQuest,2000);
      }
      
      private function initQuest() : void
      {
         if(QuestManager.isComplete(10127) && QuestManager.isComplete(10128) && QuestManager.isComplete(10129))
         {
            this.initMC();
         }
      }
      
      private function initMC() : void
      {
         this._abaoMC = this.getMovie("abao");
         this._peopleMC = this.getMovie("people");
         SceneManager.active.mapModel.content.addChild(this._abaoMC);
         SceneManager.active.mapModel.content.addChild(this._peopleMC);
         this._abaoMC.buttonMode = true;
         this._abaoMC.addEventListener(MouseEvent.CLICK,this.onPlayFullHandler);
      }
      
      private function onPlayFullHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._abaoMC)
         {
            DisplayUtil.removeForParent(this._abaoMC);
         }
         if(this._peopleMC)
         {
            DisplayUtil.removeForParent(this._peopleMC);
         }
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("AbaoTravel/travel1"),function():void
         {
            SwapManager.swapItem(593,1,onSuccess);
         },true,false,2);
      }
      
      private function onSuccess(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         var _loc3_:String = ItemConfig.getItemName(_loc2_.itemID);
         ServerBufferManager.updateServerBuffer(ServerBufferType.Leiyi_Fit_Kaisa,8,1);
      }
      
      private function getURL() : void
      {
         var url:String = String(URLUtil.getActivityAnimation("AbaoTravel/sayByebye"));
         var resourceLoader:ResourceLibraryLoader = new ResourceLibraryLoader(url);
         resourceLoader.getLib(function(param1:ResourceLibrary):void
         {
            _resLib = param1;
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return this._resLib.getMovieClip(param1);
         }
         return null;
      }
   }
}
