package com.taomee.seer2.app.cmdl
{
   import com.adobe.crypto.MD5;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.events.UserInfoEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import org.taomee.bean.BaseBean;
   
   public class MoneyUpdateBean extends BaseBean
   {
       
      
      public function MoneyUpdateBean()
      {
         super();
         Connection.addCommandListener(CommandSet.MI_BUY_ITEM_1224,this.onUpdate);
         Connection.addCommandListener(CommandSet.CLI_MONEY_COUNT_1253,this.onMoneyCount);
         Connection.send(CommandSet.CLI_MONEY_COUNT_1253,this.getResult());
         finish();
      }
      
      private function getResult() : LittleEndianByteArray
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc2_:String = String(MD5.hash("0"));
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.substr(_loc4_,2);
            _loc6_ = parseInt(_loc5_,16);
            _loc1_.writeByte(_loc6_);
            _loc4_ += 2;
         }
         return _loc1_;
      }
      
      private function onMoneyCount(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         ActorManager.actorInfo.moneyCount = uint(_loc3_ / 100);
         if(ActorManager.actorInfo.hasEventListener(UserInfoEvent.UPDATE_MONEY))
         {
            ActorManager.actorInfo.dispatchEvent(new UserInfoEvent(UserInfoEvent.UPDATE_MONEY));
         }
      }
      
      private function onUpdate(param1:MessageEvent = null) : void
      {
         Connection.send(CommandSet.CLI_MONEY_COUNT_1253,this.getResult());
      }
   }
}
