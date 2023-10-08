package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.inventory.ItemDescription;
   import flash.utils.IDataInput;
   
   public class Parser_1051
   {
       
      
      public var cmdId:int;
      
      public var itemDes:Vector.<ItemDescription>;
      
      public function Parser_1051(param1:IDataInput)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         super();
         this.itemDes = new Vector.<ItemDescription>();
         this.cmdId = param1.readUnsignedInt();
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = int(param1.readShort());
            _loc6_ = uint(param1.readUnsignedInt());
            if(_loc4_ == 12)
            {
               _loc5_ -= ActorManager.actorInfo.trainerScore;
            }
            this.itemDes.push(new ItemDescription(_loc4_,_loc5_,_loc6_));
            _loc3_++;
         }
         _loc2_ = int(param1.readUnsignedInt());
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.itemDes.push(new ItemDescription(param1.readUnsignedInt(),1,param1.readUnsignedInt(),true));
            _loc3_++;
         }
         _loc2_ = int(param1.readUnsignedInt());
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = int(param1.readShort());
            _loc9_ = uint(param1.readUnsignedInt());
            this.itemDes.push(new ItemDescription(_loc7_,_loc8_,_loc9_,false,false));
            _loc3_++;
         }
      }
   }
}
