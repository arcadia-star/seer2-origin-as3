package com.taomee.seer2.module.login.loader
{
   public class LoaderPool
   {
      
      private static var _loadVec:Vector.<com.taomee.seer2.module.login.loader.LoaderImpl> = new Vector.<com.taomee.seer2.module.login.loader.LoaderImpl>();
       
      
      public function LoaderPool()
      {
         super();
      }
      
      public static function checkIn(param1:com.taomee.seer2.module.login.loader.LoaderImpl) : void
      {
         if(Boolean(param1) && Boolean(_loadVec))
         {
            _loadVec.push(param1);
         }
      }
      
      public static function checkOut() : com.taomee.seer2.module.login.loader.LoaderImpl
      {
         if(Boolean(_loadVec) && _loadVec.length > 0)
         {
            return _loadVec.pop();
         }
         return new com.taomee.seer2.module.login.loader.LoaderImpl();
      }
      
      public static function dispose() : void
      {
         var _loc1_:com.taomee.seer2.module.login.loader.LoaderImpl = null;
         for each(_loc1_ in _loadVec)
         {
            _loc1_.dispose();
         }
         _loadVec = null;
      }
   }
}
