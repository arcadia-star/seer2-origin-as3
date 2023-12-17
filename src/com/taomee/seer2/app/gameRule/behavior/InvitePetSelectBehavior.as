package com.taomee.seer2.app.gameRule.behavior
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.manager.MapUserStatusManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class InvitePetSelectBehavior
   {
       
      
      private var _inviteUser:UserInfo;
      
      private var _fightMode:uint;
      
      private var _fightType:uint;
      
      public function InvitePetSelectBehavior(param1:UserInfo, param2:uint, param3:uint)
      {
         super();
         this._inviteUser = param1;
         this._fightMode = param2;
         this._fightType = param3;
      }
      
      public function onInviteCancel() : void
      {
      }
      
      public function onInviteFighter(param1:Vector.<uint>) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         this.addListeners();
         var _loc2_:uint = this._inviteUser.id;
         var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc3_.writeUnsignedInt(_loc2_);
         _loc3_.writeUnsignedInt(this._fightMode);
         _loc3_.writeByte(this._fightType);
         _loc3_.writeUnsignedInt(param1.length);
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.writeUnsignedInt(param1[_loc4_]);
            _loc4_++;
         }
         Connection.send(CommandSet.FIGHT_INVITE_PVP_1512,_loc3_);
         var _loc5_:Array = new Array();
         for each(_loc6_ in param1)
         {
            _loc5_.push(_loc6_);
         }
         _loc7_ = SOMultiBehavior.getKey(this._fightMode);
         SOMultiBehavior.writeDefaultPets(_loc7_,_loc5_);
      }
      
      private function addListeners() : void
      {
         Connection.addErrorHandler(CommandSet.FIGHT_INVITE_PVP_1512,this.onErrorHandler);
         Connection.addCommandListener(CommandSet.FIGHT_INVITE_PVP_1512,this.onSuccessHandler);
      }
      
      private function removeListeners() : void
      {
         Connection.removeErrorHandler(CommandSet.FIGHT_INVITE_PVP_1512,this.onErrorHandler);
         Connection.removeCommandListener(CommandSet.FIGHT_INVITE_PVP_1512,this.onSuccessHandler);
      }
      
      private function onErrorHandler(param1:MessageEvent) : void
      {
         this.removeListeners();
         Connection.send(CommandSet.FIGHT_CANCEL_INVITE_PVP_1514);
         var _loc2_:uint = uint(param1.message.statusCode);
         if(!MapUserStatusManager.chcekUserIsInFight(ActorManager.actorInfo.id))
         {
            AlertManager.showAlert(ErrorMap.findErrorMessage(_loc2_));
         }
      }
      
      private function onSuccessHandler(param1:MessageEvent) : void
      {
         this.removeListeners();
         var _loc2_:Object = new Object();
         _loc2_.self = ActorManager.actorInfo;
         _loc2_.oppositer = this._inviteUser;
         ModuleManager.showModule(URLUtil.getAppModule("InviteFightPanel"),"正在打开邀请对战面板...",_loc2_);
      }
   }
}
