package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.activity.springFireworks.SpringFireworksManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_3843 extends MapProcessor
   {
       
      
      public function MapProcessor_3843(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         Connection.addCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,this.onBroadCast);
         SpringFireworksManager.setup(false);
      }
      
      private function onBroadCast(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         SpringFireworksManager.setup(true,_loc5_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,this.onBroadCast);
         SpringFireworksManager.dispose();
      }
   }
}
