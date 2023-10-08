package mx.formatters
{
   public class StringFormatter
   {
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") static const VERSION:String = "4.6.0.23201";
       
      
      private var extractToken:Function;
      
      private var reqFormat:String;
      
      private var patternInfo:Array;
      
      public function StringFormatter(param1:String, param2:String, param3:Function)
      {
         super();
         this.formatPattern(param1,param2);
         this.extractToken = param3;
      }
      
      public function formatValue(param1:Object) : String
      {
         var _loc2_:Object = this.patternInfo[0];
         var _loc3_:String = this.reqFormat.substring(0,_loc2_.begin) + this.extractToken(param1,_loc2_);
         var _loc4_:Object = _loc2_;
         var _loc5_:int = int(this.patternInfo.length);
         var _loc6_:int = 1;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = this.patternInfo[_loc6_];
            _loc3_ += this.reqFormat.substring(_loc4_.end,_loc2_.begin) + this.extractToken(param1,_loc2_);
            _loc4_ = _loc2_;
            _loc6_++;
         }
         if(_loc4_.end > 0 && _loc4_.end != this.reqFormat.length)
         {
            _loc3_ += this.reqFormat.substring(_loc4_.end);
         }
         return _loc3_;
      }
      
      private function formatPattern(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = param2.split(",");
         this.reqFormat = param1;
         this.patternInfo = [];
         var _loc7_:int = int(_loc6_.length);
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc3_ = this.reqFormat.indexOf(_loc6_[_loc8_]);
            if(_loc3_ >= 0 && _loc3_ < this.reqFormat.length)
            {
               _loc4_ = (_loc4_ = this.reqFormat.lastIndexOf(_loc6_[_loc8_])) >= 0 ? _loc4_ + 1 : _loc3_ + 1;
               this.patternInfo.splice(_loc5_,0,{
                  "token":_loc6_[_loc8_],
                  "begin":_loc3_,
                  "end":_loc4_
               });
               _loc5_++;
            }
            _loc8_++;
         }
         this.patternInfo.sort(this.compareValues);
      }
      
      private function compareValues(param1:Object, param2:Object) : int
      {
         if(param1.begin > param2.begin)
         {
            return 1;
         }
         if(param1.begin < param2.begin)
         {
            return -1;
         }
         return 0;
      }
   }
}
