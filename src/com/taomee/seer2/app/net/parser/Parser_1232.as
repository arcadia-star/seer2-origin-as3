package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.processor.activity.sniper.SniperInfo;
   import flash.utils.IDataInput;
   
   public class Parser_1232
   {
       
      
      public var itemListVec:Vector.<SniperInfo>;
      
      public var myOrder:int = 0;
      
      public function Parser_1232(param1:IDataInput)
      {
         var _loc4_:SniperInfo = null;
         super();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:uint = uint(param1.readUnsignedInt());
         this.itemListVec = new Vector.<SniperInfo>();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            (_loc4_ = new SniperInfo()).userId = param1.readUnsignedInt();
            if(_loc4_.userId == ActorManager.actorInfo.id)
            {
               this.myOrder = _loc5_ + 1;
            }
            _loc4_.nick = param1.readUTFBytes(UserInfo.NICK_DATA_LEN);
            _loc4_.hurt = param1.readUnsignedInt();
            this.itemListVec.push(_loc4_);
            _loc5_++;
         }
      }
   }
}
