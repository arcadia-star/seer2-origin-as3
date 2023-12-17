package org.taomee.bean
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class BeanManager
   {
      
      private static const ID_NODE:String = "id";
      
      private static const CLASS_NODE:String = "class";
      
      private static var _currentList:Array;
      
      private static var _currentID:String;
      
      private static var _beanMap:Dictionary;
      
      private static var _map:Object;
      
      private static var _playering:Boolean;
      
      private static var _ed:EventDispatcher = new EventDispatcher();
       
      
      public function BeanManager()
      {
         super();
      }
      
      public static function config(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Array = null;
         var _loc5_:XMLList = null;
         var _loc6_:XML = null;
         var _loc7_:BeanNodeInfo = null;
         _map = {};
         var _loc2_:XMLList = param1.elements();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = [];
            _loc5_ = _loc3_.elements();
            for each(_loc6_ in _loc5_)
            {
               (_loc7_ = new BeanNodeInfo()).id = _loc6_.attribute(ID_NODE).toString();
               _loc7_.className = _loc6_.attribute(CLASS_NODE).toString();
               _loc4_.push(_loc7_);
            }
            _map[String(_loc3_.@id)] = _loc4_;
         }
      }
      
      public static function start(param1:String) : void
      {
         if(_playering)
         {
            throw new Error("processoring");
         }
         _beanMap = new Dictionary(true);
         if(param1 in _map)
         {
            _playering = true;
            _currentID = param1;
            dispatchEvent(new BeanEvent(BeanEvent.OPEN,_currentID));
            _currentList = _map[_currentID];
            initClasses();
            return;
         }
         throw new Error("id error");
      }
      
      public static function getBeanInstance(param1:String) : *
      {
         return _beanMap[param1];
      }
      
      internal static function initClasses() : void
      {
         var _loc1_:BeanNodeInfo = null;
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         if(_currentList.length > 0)
         {
            _loc1_ = _currentList.shift();
            _loc2_ = getDefinitionByName(_loc1_.className) as Class;
            _loc3_ = new _loc2_();
            _beanMap[_loc1_.id] = _loc3_;
            trace(_loc3_,"实例化完成");
            _loc3_.start();
         }
         else
         {
            _currentList = null;
            _playering = false;
            dispatchEvent(new BeanEvent(BeanEvent.COMPLETE,_currentID));
         }
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _ed.addEventListener(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _ed.removeEventListener(param1,param2);
      }
      
      public static function dispatchEvent(param1:Event) : void
      {
         if(hasEventListener(param1.type))
         {
            _ed.dispatchEvent(param1);
         }
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _ed.hasEventListener(param1);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _ed.willTrigger(param1);
      }
   }
}
