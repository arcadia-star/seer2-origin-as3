package com.taomee.seer2.core.log
{
   public class Logger
   {
      
      public static var isDebug:Boolean = false;
       
      
      private var _name:String;
      
      private var _appenders:Vector.<com.taomee.seer2.core.log.IAppender>;
      
      private var _level:int;
      
      public function Logger(param1:String, param2:Blocker)
      {
         super();
         this._name = param1;
         this._level = 0;
         this._appenders = new Vector.<com.taomee.seer2.core.log.IAppender>();
      }
      
      public static function getLogger(param1:String, param2:Boolean = true) : Logger
      {
         var _loc3_:Logger = new Logger(param1,new Blocker());
         if(param2)
         {
            _loc3_.addAppender(new TraceAppender());
         }
         return _loc3_;
      }
      
      public function addAppender(param1:com.taomee.seer2.core.log.IAppender) : void
      {
         this._appenders.push(param1);
      }
      
      public function setLevel(param1:int) : void
      {
         this._level = param1;
      }
      
      public function debug(param1:String) : void
      {
         this.log(LogLevel.DEBUG,param1);
      }
      
      public function info(param1:String) : void
      {
         this.log(LogLevel.INFO,param1);
      }
      
      public function warn(param1:String) : void
      {
         this.log(LogLevel.WARN,param1);
      }
      
      public function error(param1:String) : void
      {
         this.log(LogLevel.ERROR,param1);
      }
      
      public function fatal(param1:String) : void
      {
         this.log(LogLevel.FATAL,param1);
      }
      
      private function log(param1:int, param2:String) : void
      {
         var _loc4_:com.taomee.seer2.core.log.IAppender = null;
         if(param1 < this._level)
         {
            return;
         }
         var _loc3_:String = this.preprocessMsg(param1,param2);
         for each(_loc4_ in this._appenders)
         {
            _loc4_.append(_loc3_);
         }
      }
      
      private function preprocessMsg(param1:int, param2:String) : String
      {
         var _loc3_:String = "(" + this._name + ")" + " " + param2;
         switch(param1)
         {
            case 1:
               _loc3_ = "Debug: " + _loc3_;
               break;
            case 2:
               _loc3_ = "Info: " + _loc3_;
               break;
            case 3:
               _loc3_ = "Warn: " + _loc3_;
               break;
            case 4:
               _loc3_ = "Error: " + _loc3_;
               break;
            case 5:
               _loc3_ = "Fatal: " + _loc3_;
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
