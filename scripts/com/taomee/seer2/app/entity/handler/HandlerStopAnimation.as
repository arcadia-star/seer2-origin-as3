package com.taomee.seer2.app.entity.handler
{
   import com.taomee.seer2.core.entity.AnimateElement;
   import com.taomee.seer2.core.entity.definition.EntityDefinition;
   import com.taomee.seer2.core.entity.handler.IEntityEventHandler;
   import flash.events.Event;
   
   public class HandlerStopAnimation implements IEntityEventHandler
   {
       
      
      private var _type:String;
      
      private var _entityDefinition:EntityDefinition;
      
      public function HandlerStopAnimation()
      {
         super();
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function setEntityDefinition(param1:EntityDefinition) : void
      {
         this._entityDefinition = param1;
      }
      
      public function initData(param1:XML) : void
      {
      }
      
      public function onEvent(param1:Event) : void
      {
         var _loc2_:AnimateElement = param1.target as AnimateElement;
         _loc2_.stop();
      }
   }
}
