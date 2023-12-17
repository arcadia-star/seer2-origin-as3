package com.taomee.seer2.app.processor.map.diceThing.lucky
{
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.events.Event;
   
   public class RandomLuckyThing extends BaseDiceThing
   {
       
      
      private var thing:BaseDiceThing;
      
      public function RandomLuckyThing(param1:DiceThingInfo)
      {
         super(param1);
      }
      
      override public function setUpThing() : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.getRandom);
         Connection.send(CommandSet.RANDOM_EVENT_1140,92,0);
      }
      
      private function getRandom(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.getRandom);
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawData());
         var _loc3_:uint = _loc2_.id;
         thingInfo.isMee = true;
         thingInfo.id = _loc3_;
         switch(_loc3_)
         {
            case 1:
               thingInfo.stopTime = 10;
               thingInfo.moveTile = 0;
               this.thing = new StopThing(thingInfo);
               break;
            case 2:
               thingInfo.stopTime = 20;
               thingInfo.moveTile = 0;
               this.thing = new StopThing(thingInfo);
               break;
            case 3:
               thingInfo.moveTile = 1;
               thingInfo.stopTime = 0;
               this.thing = new ChangTileThing(thingInfo);
               break;
            case 4:
               thingInfo.moveTile = -1;
               thingInfo.stopTime = 0;
               this.thing = new ChangTileThing(thingInfo);
               break;
            case 5:
               thingInfo.moveTile = 500;
               thingInfo.stopTime = 0;
               this.thing = new ChangTileThing(thingInfo);
         }
         this.thing.addEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
         this.thing.setUpThing();
      }
      
      protected function thingOver(param1:Event) : void
      {
         this.thing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
         eventInfo.moveTile = thingInfo.moveTile;
         this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER,eventInfo));
      }
      
      override public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.getRandom);
         if(this.thing)
         {
            this.thing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
         }
      }
   }
}
