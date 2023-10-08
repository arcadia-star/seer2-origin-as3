package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.shareToInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class ShareToConfig
   {
      
      private static var _instance:com.taomee.seer2.app.config.ShareToConfig;
       
      
      private var _isLoaded:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var _allXml:XMLList;
      
      private var _allShare:Vector.<shareToInfo>;
      
      private var callback:Function;
      
      public function ShareToConfig()
      {
         super();
      }
      
      public static function get Instance() : com.taomee.seer2.app.config.ShareToConfig
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.config.ShareToConfig();
         }
         return _instance;
      }
      
      public function getShareToInfo(param1:Function) : void
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
            QueueLoader.load(URLUtil.getActivityXML("shareTo"),LoadType.TEXT,this.onComplete);
         }
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         this._allXml = XML(param1.content).descendants("share");
         this.parserXml();
      }
      
      private function parserXml() : void
      {
         var _loc1_:XML = null;
         var _loc2_:shareToInfo = null;
         this._allShare = new Vector.<shareToInfo>();
         for each(_loc1_ in this._allXml)
         {
            _loc2_ = new shareToInfo();
            _loc2_.id = uint(_loc1_.@id);
            _loc2_.url = String(_loc1_.@url);
            _loc2_.desc = String(_loc1_.@desc);
            _loc2_.title = String(_loc1_.@title);
            _loc2_.summary = String(_loc1_.@summary);
            _loc2_.site = String(_loc1_.@site);
            _loc2_.pics = String(_loc1_.@pics);
            _loc2_.style = int(_loc1_.@style);
            _loc2_.height = uint(_loc1_.@height);
            _loc2_.width = uint(_loc1_.@width);
            _loc2_.flash = String(_loc1_.@flash);
            this._allShare.push(_loc2_);
         }
         this._isLoaded = true;
         this._isLoading = false;
         this.callback();
      }
      
      public function getallShare(param1:int) : shareToInfo
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._allShare.length)
         {
            if(param1 == this._allShare[_loc2_].id)
            {
               return this._allShare[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
