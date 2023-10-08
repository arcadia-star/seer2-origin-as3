package
{
   public class TmdType
   {
      
      private static var _map:Object = {};
      
      {
         setup();
      }
      
      public function TmdType()
      {
         super();
      }
      
      private static function setup() : void
      {
         _map["766.com"] = 2;
         _map["7k7k.com"] = 4;
         _map["4399.com"] = 5;
         _map["3839.com"] = 6;
         _map["2144.com"] = 7;
         _map["2125.com"] = 29;
         _map["5253.com"] = 66;
         _map["5068.com"] = 68;
         _map["duowan.com"] = 69;
         _map["265g.com"] = 70;
         _map["07073.com"] = 71;
         _map["2366.com"] = 72;
      }
      
      public static function getID(param1:String) : int
      {
         var _loc2_:String = null;
         for(_loc2_ in _map)
         {
            if(param1.indexOf(_loc2_) != -1)
            {
               return _map[_loc2_];
            }
         }
         return 0;
      }
   }
}
