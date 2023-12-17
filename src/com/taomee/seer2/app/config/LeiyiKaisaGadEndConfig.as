package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.LeiyiKaisaGadEndInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class LeiyiKaisaGadEndConfig
   {
      
      private static var _instance:LeiyiKaisaGadEndConfig;
       
      
      private var callback:Function;
      
      private var _allXml:XMLList;
      
      private var _allChip:Vector.<LeiyiKaisaGadEndInfo>;
      
      public function LeiyiKaisaGadEndConfig()
      {
         super();
      }
      
      public static function get Instance() : LeiyiKaisaGadEndConfig
      {
         if(!_instance)
         {
            _instance = new LeiyiKaisaGadEndConfig();
         }
         return _instance;
      }
      
      public function get allChip() : Vector.<LeiyiKaisaGadEndInfo>
      {
         return this._allChip;
      }
      
      public function getLeiyiKaisaGadEndInfo(param1:Function) : void
      {
         this.callback = param1;
         this.loadConfig();
      }
      
      private function loadConfig() : void
      {
         QueueLoader.load(URLUtil.getActivityXML("LeiyiKaisaGadEnd"),LoadType.TEXT,this.onComplete);
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         this._allXml = XML(param1.content).descendants("chip");
         this.parserXml();
      }
      
      private function parserXml() : void
      {
         var _loc1_:XML = null;
         var _loc2_:LeiyiKaisaGadEndInfo = null;
         this._allChip = new Vector.<LeiyiKaisaGadEndInfo>();
         for each(_loc1_ in this._allXml)
         {
            _loc2_ = new LeiyiKaisaGadEndInfo();
            _loc2_.index = int(_loc1_.@index);
            _loc2_.itemID = int(_loc1_.@itemID);
            _loc2_.mineID = int(_loc1_.@mineID);
            _loc2_.x = Number(_loc1_.@y);
            _loc2_.y = Number(_loc1_.@y);
            _loc2_.scale = Number(_loc1_.@scale);
            _loc2_.name = String(_loc1_.@name);
            this._allChip.push(_loc2_);
         }
         this.callback();
      }
   }
}
