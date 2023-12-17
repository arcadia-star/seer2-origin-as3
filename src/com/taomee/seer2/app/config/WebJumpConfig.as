package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.JumpInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.grids.HashMap;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class WebJumpConfig
   {
      
      private static var _instance:WebJumpConfig;
       
      
      private var _isLoaded:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var callback:Function;
      
      private var _urlMap:HashMap;
      
      public function WebJumpConfig()
      {
         super();
         this._urlMap = new HashMap();
      }
      
      public static function get Instance() : WebJumpConfig
      {
         if(!_instance)
         {
            _instance = new WebJumpConfig();
         }
         return _instance;
      }
      
      public function getConfigMap(param1:Function) : void
      {
         if(this._isLoaded)
         {
            param1();
         }
         else
         {
            this.callback = param1;
            this.loadConfig();
         }
      }
      
      private function loadConfig() : void
      {
         if(!this._isLoaded && !this._isLoading)
         {
            this._isLoading = true;
            QueueLoader.load(URLUtil.getActivityXML("WebJumpConfig"),LoadType.TEXT,this.onComplete);
         }
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         var _loc4_:XML = null;
         var _loc5_:JumpInfo = null;
         var _loc2_:XML = XML(param1.content);
         var _loc3_:XMLList = _loc2_.descendants("info");
         for each(_loc4_ in _loc3_)
         {
            (_loc5_ = new JumpInfo()).tid = uint(_loc4_.@tid);
            this._urlMap.put(uint(_loc4_.@id),_loc5_);
         }
         this._isLoaded = true;
         this._isLoading = false;
         this.callback();
      }
      
      public function getInfo(param1:uint) : JumpInfo
      {
         return this._urlMap.getValue(param1) as JumpInfo;
      }
   }
}
