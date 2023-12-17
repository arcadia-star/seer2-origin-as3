package com.taomee.seer2.app.home
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.events.ActorEvent;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.app.home.panel.HomePanel;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.scene.PathScene;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class HomeScene extends PathScene
   {
       
      
      private var _homeInfo:HomeInfo;
      
      public function HomeScene(param1:int)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         HomePanel.show();
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
         Connection.addCommandListener(CommandSet.HOME_GET_ENTRY_INFO_1038,this.onGetHomeEntryInfo);
         Connection.send(CommandSet.HOME_GET_ENTRY_INFO_1038);
      }
      
      private function onGetHomeEntryInfo(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.HOME_GET_ENTRY_INFO_1038,this.onGetHomeEntryInfo);
         this._homeInfo.parse1038(param1.message.getRawDataCopy());
         mapModel.name = this._homeInfo.userInfo.nick;
         HomePanel.update(this._homeInfo);
         completeMap();
      }
      
      override public function dispose() : void
      {
         HomePanel.hide();
         super.dispose();
      }
      
      public function get homeInfo() : HomeInfo
      {
         return this._homeInfo;
      }
      
      public function isInSelfHome() : Boolean
      {
         return ActorManager.getActor().id == this._homeInfo.userId;
      }
   }
}
