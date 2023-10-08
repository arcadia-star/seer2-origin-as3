package com.taomee.seer2.core.entity.definition
{
   import com.taomee.seer2.core.entity.handler.EntityEventHandlerParser;
   import com.taomee.seer2.core.entity.handler.IEntityEventHandler;
   
   public class AnimationDefinition extends EntityDefinition
   {
       
      
      public var linkage:String;
      
      public var handlers:Vector.<IEntityEventHandler>;
      
      public function AnimationDefinition(param1:XML)
      {
         super();
         this.linkage = param1.attribute("linkage").toString();
         var _loc2_:String = param1.attribute("pos").toString();
         var _loc3_:Array = _loc2_.split(",");
         this.x = _loc3_[0];
         this.y = _loc3_[1];
         var _loc4_:XMLList = param1.elements("eventHandler").elements("*");
         this.handlers = EntityEventHandlerParser.parse(this,_loc4_);
      }
   }
}
