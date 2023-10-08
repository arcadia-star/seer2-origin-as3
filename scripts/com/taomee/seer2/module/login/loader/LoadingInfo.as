package com.taomee.seer2.module.login.loader
{
   public class LoadingInfo
   {
       
      
      public var infoVec:Vector.<com.taomee.seer2.module.login.loader.LoginLoaderInfo>;
      
      public var loader:com.taomee.seer2.module.login.loader.LoaderImpl;
      
      public function LoadingInfo()
      {
         super();
         this.infoVec = new Vector.<com.taomee.seer2.module.login.loader.LoginLoaderInfo>();
      }
   }
}
