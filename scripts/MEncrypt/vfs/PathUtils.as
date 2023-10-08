package MEncrypt.vfs
{
   public class PathUtils
   {
       
      
      public function PathUtils()
      {
         super();
      }
      
      public static function toCanonicalPath(param1:String) : String
      {
         var _loc4_:* = 0;
         var _loc5_:String = param1.replace(/\//,"/");
         while(_loc5_ != param1)
         {
            param1 = _loc5_;
            _loc5_ = param1.replace(/\//,"/");
         }
         var _loc3_:Array = param1.split("/");
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_] == "..")
            {
               if(_loc2_.length > 0)
               {
                  _loc2_.pop();
               }
            }
            else if(_loc3_[_loc4_].length != 0 && _loc3_[_loc4_] != ".")
            {
               _loc2_.push(_loc3_[_loc4_]);
            }
            _loc4_++;
         }
         return "/" + _loc2_.join("/");
      }
      
      public static function getDirectory(param1:String) : String
      {
         param1 = String(PathUtils.toCanonicalPath(param1));
         var _loc2_:uint = uint(param1.lastIndexOf("/"));
         if(!_loc2_)
         {
            return "/";
         }
         return param1.substring(0,_loc2_);
      }
   }
}
