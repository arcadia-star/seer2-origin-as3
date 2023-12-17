package com.taomee.seer2.app.processor.map.diceThing.money
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import flash.utils.IDataInput;
   
   public class MoneyThing extends BaseDiceThing
   {
       
      
      public function MoneyThing(param1:DiceThingInfo)
      {
         super(param1);
      }
      
      override public function setUpThing() : void
      {
         SwapManager.swapItem(thingInfo.strikeId,1,this.onSwapSuccess);
      }
      
      private function onSwapSuccess(param1:IDataInput) : void
      {
         var _loc2_:int = int(ActorManager.actorInfo.coins);
         var _loc3_:SwapInfo = new SwapInfo(param1,false);
         var _loc4_:int = int(ActorManager.actorInfo.coins);
         if(_loc2_ < _loc4_)
         {
            ServerMessager.addMessage("你真幸运,在地上捡到了" + (_loc4_ - _loc2_) + "赛尔豆！");
         }
         else
         {
            ServerMessager.addMessage("你真倒霉,被狼妖抢了" + (_loc4_ - _loc2_) + "赛尔豆!");
         }
         this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER,new DiceThingEventInfo()));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
