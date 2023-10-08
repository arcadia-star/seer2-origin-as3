package com.taomee.seer2.app.plant
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.events.ActorEvent;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.plant.data.PlantTotalInfo;
   import com.taomee.seer2.app.plant.panelControl.PlantPanelControl;
   import com.taomee.seer2.app.scene.PathScene;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class PlantScene extends PathScene
   {
       
      
      private var _homeInfo:HomeInfo;
      
      private var _plantInfo:PlantTotalInfo;
      
      public function PlantScene(param1:int)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         PlantPanelControl.show();
      }
      
      override protected function onTick(param1:int) : void
      {
         super.onTick(param1);
         PlantPanelControl.onUpdate();
      }
      
      override protected function updateScene() : void
      {
         super.updateScene();
      }
      
      override protected function syncToServer() : void
      {
         ActorManager.addEventListener(ActorEvent.ACTOR_SYNC_SVR,this.onActorSyncSvr);
         ActorManager.syncToServer();
      }
      
      private function onActorSyncSvr(param1:ActorEvent) : void
      {
         ActorManager.removeEventListener(ActorEvent.ACTOR_SYNC_SVR,this.onActorSyncSvr);
         Connection.addCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028,this.onGetUserSimpleInfo);
         Connection.send(CommandSet.USER_GET_SIMPLE_INFO_1028,mapID);
      }
      
      private function onGetUserSimpleInfo(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028,this.onGetUserSimpleInfo);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:UserInfo;
         (_loc4_ = new UserInfo()).id = _loc3_;
         UserInfoParseHelper.readSimpleInfo(_loc4_,_loc2_);
         this._homeInfo = new HomeInfo();
         this._homeInfo.userInfo = _loc4_;
         if(_loc3_ == ActorManager.actorInfo.id)
         {
            ActorManager.actorInfo.plantLevel = _loc4_.plantLevel;
         }
         Connection.addCommandListener(CommandSet.GET_PLANT_INFO_1518,this.onGetPlantInfo);
         Connection.send(CommandSet.GET_PLANT_INFO_1518,mapID);
      }
      
      private function onGetPlantInfo(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_PLANT_INFO_1518,this.onGetPlantInfo);
         var _loc2_:IDataInput = param1.message.getRawData();
         this._plantInfo = new PlantTotalInfo();
         this._plantInfo.parseInfo(_loc2_);
         this._plantInfo.updateInfo();
         Tick.instance.addRender(this.updateInfo,1000);
         mapModel.name = this._homeInfo.userInfo.nick;
         PlantPanelControl.update(this._homeInfo);
         completeMap();
      }
      
      private function updateInfo(param1:uint) : void
      {
         this._plantInfo.updateInfo();
      }
      
      override public function dispose() : void
      {
         PlantPanelControl.hide();
         Tick.instance.removeRender(this.updateInfo);
         super.dispose();
      }
      
      public function get homeInfo() : HomeInfo
      {
         return this._homeInfo;
      }
      
      public function get plantInfo() : PlantTotalInfo
      {
         return this._plantInfo;
      }
   }
}
