package com.taomee.seer2.app.activity.processor.PrizeCeremony
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class WalkRedCarpetAgain
   {
       
      
      private var _mc:MovieClip;
      
      private var _myself:Actor;
      
      private var _result:Boolean;
      
      public function WalkRedCarpetAgain()
      {
         super();
         this.initNpc();
         this.initMC();
         this._myself = ActorManager.getActor();
      }
      
      private function initNpc() : void
      {
         if(DateUtil.inInDateScope(5,13,1,14,1))
         {
            ItemManager.requestEquipList(this.hasEquipment);
            if(this._result)
            {
               NpcDialog.show(503,"神秘的某某",[[0,"哇，帅气！这身打扮和我们的红毯特别般配！现在快踏上红毯——有神秘礼物送（只可领一次）"]],["嗯嗯嗯！我要走红地毯啦！"],[function():void
               {
                  _myself.hide();
                  LayerManager.topLayer.addChild(_mc);
                  MovieClipUtil.playMc(_mc,1,_mc.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(_mc);
                     _myself.show();
                     ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,getSuverBuffer17);
                  },true);
               }]);
            }
            else
            {
               NpcDialog.show(503,"神秘的某某",[[0,"额？你就这样就出门了？快去 商城 采购装备打扮一下再来走红毯吧！ "]],["马上就去。"],[function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("ShopPanel"),"正在打开米币商城...");
               }]);
            }
         }
         else
         {
            NpcDialog.show(503,"神秘的某某",[[0,"颁奖礼的红毯仪式会只在8月10日13:00——14:00举行哦，如果错过就要等明年的暑假了！"]],["嗯，我知道啦！"],[]);
         }
      }
      
      private function getSuverBuffer17(param1:ServerBuffer) : void
      {
         var _loc2_:int = param1.readDataAtPostion(17);
         if(_loc2_ == 0)
         {
            Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onRequestSwap);
            Connection.send(CommandSet.ITEM_EXCHANGE_1055,521,1,0);
            ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,17,1);
         }
      }
      
      private function hasEquipment() : void
      {
         var _loc2_:EquipItem = null;
         var _loc1_:Vector.<EquipItem> = ItemManager.getEquipVec();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.isEquiped == true)
            {
               this._result = true;
            }
         }
      }
      
      private function initMC() : void
      {
         var _loc1_:String = String(URLUtil.getActivityAnimation("PrizeCeremony"));
         QueueLoader.load(_loc1_,LoadType.SWF,this.onTakePicLoaded);
      }
      
      private function onTakePicLoaded(param1:ContentInfo) : void
      {
         var _loc2_:MovieClip = param1.content as MovieClip;
         this._mc = _loc2_["mc_0"] as MovieClip;
      }
      
      private function onRequestSwap(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onRequestSwap);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_83);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:SwapInfo = new SwapInfo(_loc2_);
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onRequestSwap);
      }
   }
}
