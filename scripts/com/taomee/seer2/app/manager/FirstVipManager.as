package com.taomee.seer2.app.manager
{
   public class FirstVipManager
   {
      
      private static var _instance:com.taomee.seer2.app.manager.FirstVipManager;
       
      
      public function FirstVipManager(param1:InterClass)
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.manager.FirstVipManager
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.manager.FirstVipManager(new InterClass());
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
   }
}

class InterClass
{
    
   
   public function InterClass()
   {
      super();
   }
}
