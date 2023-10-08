package com.taomee.seer2.app.serverBuffer
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   
   public class UpdateServerBufferHandler implements IUpdateServerBufferHandler
   {
       
      
      public var serverBufferType:int;
      
      public var dataVec:Vector.<com.taomee.seer2.app.serverBuffer.ServerBufferData>;
      
      public function UpdateServerBufferHandler(param1:int, param2:Vector.<com.taomee.seer2.app.serverBuffer.ServerBufferData>)
      {
         this.serverBufferType = param1;
         this.dataVec = param2;
         super();
      }
      
      public function updateServerBufferHandler(param1:ServerBuffer) : void
      {
         var _loc3_:com.taomee.seer2.app.serverBuffer.ServerBufferData = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.dataVec.length)
         {
            _loc3_ = this.dataVec[_loc2_];
            if(_loc3_.value is int)
            {
               if(_loc3_.bit == 1)
               {
                  param1.writeDataAtPostion(_loc3_.position,_loc3_.value);
               }
               else if(_loc3_.bit == 4)
               {
                  param1.writeDataAtUint(_loc3_.position,_loc3_.value);
               }
            }
            else if(_loc3_.value is String)
            {
               param1.writeString(_loc3_.position,_loc3_.value);
            }
            _loc2_++;
         }
         Connection.send(CommandSet.CLIENT_SET_BUFFER_INFO_1063,param1.data);
         this.serverBufferType = 0;
         this.dataVec = null;
      }
   }
}
