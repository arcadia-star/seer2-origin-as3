package com.taomee.seer2.app.processor.map.diceThing.lucky
{
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import flash.events.MouseEvent;
   
   public class ChangTileThing extends LuckyThing
   {
       
      
      public function ChangTileThing(param1:DiceThingInfo)
      {
         super(param1);
      }
      
      override protected function overThing(param1:MouseEvent) : void
      {
         super.overThing(param1);
         eventInfo.moveTile = thingInfo.moveTile;
         this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER,eventInfo));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
