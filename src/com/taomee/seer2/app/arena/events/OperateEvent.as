package com.taomee.seer2.app.arena.events
{
   import flash.events.Event;
   
   public class OperateEvent extends Event
   {
      
      public static const OPERATE_END:String = "operateEnd";
      
      public static const FIGHT_SELECT_SKILL:String = "fightSelectSkill";
      
      public static const FIGHT_SELECT_ITEM:String = "fightSelectItem";
      
      public static const ERROR:String = "error";
      
      public static const OPERATE_SKILL:uint = 1;
      
      public static const OPERATE_ITEM_USE_MEDICINE:uint = 2;
      
      public static const OPERATE_ITEM_CATCH_PET:uint = 3;
      
      public static const OPERATE_FIGHTER:uint = 4;
      
      public static const OPERATE_ESCAPE:uint = 5;
      
      public static const OPERATE_RESURRECTION:uint = 6;
       
      
      public var operateType:uint;
      
      public var id:uint;
      
      public var fighterId:uint;
      
      public function OperateEvent(param1:uint, param2:uint, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param3,param4,param5);
         this.operateType = param1;
         this.id = param2;
      }
      
      override public function clone() : Event
      {
         var _loc1_:OperateEvent = new OperateEvent(this.operateType,this.id,type,bubbles,cancelable);
         _loc1_.fighterId = this.fighterId;
         return _loc1_;
      }
   }
}
