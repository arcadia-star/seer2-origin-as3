package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import flash.utils.setTimeout;
   import org.taomee.bean.BaseBean;
   
   public class PvPFighterInviteBean extends BaseBean
   {
      
      public static var isPyramidIng:Boolean;
       
      
      public function PvPFighterInviteBean()
      {
         super();
         Connection.addCommandListener(CommandSet.NOTICE_PVP_COPE_1107,this.onNoticePvpCope);
         finish();
      }
      
      private function onNoticePvpCope(param1:MessageEvent) : void
      {
         var oppositeID:uint = 0;
         var event:MessageEvent = param1;
         var msgData:IDataInput = event.message.getRawData();
         oppositeID = uint(msgData.readUnsignedInt());
         var type:uint = uint(msgData.readUnsignedInt());
         var mode:uint = uint(msgData.readUnsignedInt());
         if(isPyramidIng)
         {
            setTimeout(function():void
            {
               var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
               _loc1_.writeUnsignedInt(oppositeID);
               _loc1_.writeUnsignedInt(0);
               _loc1_.writeUnsignedInt(0);
               Connection.send(CommandSet.FIGHT_ACCEPT_PVP_1513,_loc1_);
            },15000);
            return;
         }
         if(type == 1)
         {
            AlertManager.closeAllPopUp();
            ModuleManager.closeAll();
            AlertManager.showInvitedFightAlert(oppositeID,mode);
         }
      }
   }
}
