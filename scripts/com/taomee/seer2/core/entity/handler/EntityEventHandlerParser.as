package com.taomee.seer2.core.entity.handler
{
   import com.taomee.seer2.core.entity.definition.EntityDefinition;
   import org.taomee.utils.DomainUtil;
   
   public class EntityEventHandlerParser
   {
       
      
      public function EntityEventHandlerParser(param1:Blocker)
      {
         super();
      }
      
      public static function parse(param1:EntityDefinition, param2:XMLList) : Vector.<IEntityEventHandler>
      {
         var _loc3_:Vector.<IEntityEventHandler> = null;
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:Class = null;
         var _loc9_:IEntityEventHandler = null;
         if(param2.length() > 0)
         {
            _loc3_ = new Vector.<IEntityEventHandler>();
            for each(_loc4_ in param2)
            {
               _loc5_ = String(_loc4_.name().toString());
               if((_loc6_ = _loc4_.child(0)[0]) != null)
               {
                  _loc7_ = String(_loc6_.name().toString());
                  if(_loc8_ = DomainUtil.getCurrentDomainClass(EntityEventHandlerPath.BASE + _loc7_))
                  {
                     (_loc9_ = new _loc8_()).setEntityDefinition(param1);
                     _loc9_.initData(_loc6_.valueOf());
                     _loc9_.type = _loc5_;
                     _loc3_.push(_loc9_);
                  }
               }
            }
         }
         return _loc3_;
      }
   }
}

class Blocker
{
    
   
   public function Blocker()
   {
      super();
   }
}
