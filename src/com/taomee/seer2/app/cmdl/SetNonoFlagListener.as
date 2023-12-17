package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import org.taomee.bean.BaseBean;
   
   public class SetNonoFlagListener extends BaseBean
   {
       
      
      public function SetNonoFlagListener()
      {
         super();
      }
      
      override public function start() : void
      {
         Connection.addCommandListener(CommandSet.SET_NONO_FLAG_1194,this.onData);
         finish();
      }
      
      private function onData(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:Actor;
         if((_loc4_ = ActorManager.getActorById(_loc3_)) != null)
         {
            _loc4_.getInfo().updateNonoInfo(_loc2_);
         }
      }
   }
}
