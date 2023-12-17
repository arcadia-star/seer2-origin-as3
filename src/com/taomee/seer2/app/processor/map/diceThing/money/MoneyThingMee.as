package com.taomee.seer2.app.processor.map.diceThing.money
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
   import com.taomee.seer2.app.processor.map.diceThing.DiceThingType;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import flash.utils.IDataInput;
   
   public class MoneyThingMee extends BaseDiceThing
   {
       
      
      public function MoneyThingMee(param1:DiceThingInfo)
      {
         super(param1);
      }
      
      override public function setUpThing() : void
      {
         if(thingInfo.type == DiceThingType.ADDMONEY_THING)
         {
            SwapManager.swapItem(2763,1,this.onSwapSuccess,null,new SpecialInfo(1,thingInfo.moneyNum));
         }
         else
         {
            SwapManager.swapItem(2766,1,this.onSwapSuccess,null,new SpecialInfo(1,thingInfo.moneyNum));
         }
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
            ServerMessager.addMessage("你真倒霉,被死神抢了" + (_loc4_ - _loc2_) + "赛尔豆!");
         }
         this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER,new DiceThingEventInfo()));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
