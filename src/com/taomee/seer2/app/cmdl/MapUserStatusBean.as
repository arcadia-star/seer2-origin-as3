package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.manager.MapUserStatusManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import org.taomee.bean.BaseBean;
   
   public class MapUserStatusBean extends BaseBean
   {
       
      
      public function MapUserStatusBean()
      {
         super();
         Connection.addCommandListener(CommandSet.ACTIVITY_ALL_USER_STATUS_1110,this.onUpdateMapUserStatus);
         finish();
      }
      
      private function onUpdateMapUserStatus(param1:MessageEvent) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = uint(_loc2_.readUnsignedInt());
            _loc5_ = int(_loc2_.readUnsignedByte());
            MapUserStatusManager.updateMapUser(_loc4_,_loc5_);
            _loc6_++;
         }
      }
   }
}
