package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.WanWangBattleInfo;
   import com.taomee.seer2.app.config.info.WanWangBattleItemInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.geom.Point;
   
   public class WanWangBattleConfig
   {
      
      private static var _instance:com.taomee.seer2.app.config.WanWangBattleConfig;
       
      
      private var _isLoaded:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var _allXml:XMLList;
      
      private var _allStep:Vector.<WanWangBattleInfo>;
      
      private var callback:Function;
      
      public function WanWangBattleConfig()
      {
         super();
      }
      
      public static function get Instance() : com.taomee.seer2.app.config.WanWangBattleConfig
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.config.WanWangBattleConfig();
         }
         return _instance;
      }
      
      public function get allStep() : Vector.<WanWangBattleInfo>
      {
         return this._allStep;
      }
      
      public function getLevelBattle(param1:int) : WanWangBattleInfo
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._allStep.length)
         {
            _loc2_ += this._allStep[_loc3_].needScore;
            if(param1 <= _loc2_)
            {
               _loc4_ = 1;
               this._allStep[_loc3_].curLevel = int((param1 - (_loc2_ - this._allStep[_loc3_].needScore)) / this._allStep[_loc3_].unitScore) + _loc4_;
               if(this._allStep[_loc3_].curLevel > this._allStep[_loc3_].slevel)
               {
                  this._allStep[_loc3_].curLevel = this._allStep[_loc3_].slevel;
               }
               return this._allStep[_loc3_];
            }
            _loc3_++;
         }
         this._allStep[_loc3_ - 1].curLevel = int((_loc2_ - (_loc2_ - this._allStep[_loc3_ - 1].needScore)) / this._allStep[_loc3_ - 1].unitScore);
         return this._allStep[_loc3_ - 1];
      }
      
      public function getStatusBattle(param1:int) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._allStep.length)
         {
            _loc3_ += this._allStep[_loc4_].needScore;
            if(param1 < _loc3_)
            {
               _loc2_.push((param1 - (_loc3_ - this._allStep[_loc4_].needScore)) % this._allStep[_loc4_].unitScore);
               _loc2_.push(this._allStep[_loc4_].unitScore);
               _loc2_.push(this._allStep[_loc4_].posArr);
               return _loc2_;
            }
            _loc4_++;
         }
         _loc2_.push(this._allStep[_loc4_ - 1].unitScore);
         _loc2_.push(this._allStep[_loc4_ - 1].unitScore);
         _loc2_.push(this._allStep[_loc4_ - 1].posArr);
         return _loc2_;
      }
      
      public function getWWBInfo(param1:Function) : void
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
            QueueLoader.load(URLUtil.getActivityXML("wanWangBattle"),LoadType.TEXT,this.onComplete);
         }
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         this._allXml = XML(param1.content).descendants("step");
         this.parserXml();
      }
      
      private function parserXml() : void
      {
         var _loc1_:XML = null;
         var _loc2_:WanWangBattleInfo = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:XMLList = null;
         var _loc7_:Vector.<WanWangBattleItemInfo> = null;
         var _loc8_:XML = null;
         var _loc9_:Array = null;
         var _loc10_:WanWangBattleItemInfo = null;
         var _loc11_:Array = null;
         var _loc12_:Point = null;
         this._allStep = new Vector.<WanWangBattleInfo>();
         for each(_loc1_ in this._allXml)
         {
            _loc2_ = new WanWangBattleInfo();
            _loc2_.sid = int(_loc1_.@sid);
            _loc2_.sresid = String(_loc1_.@sresid);
            _loc2_.slevel = int(_loc1_.@slevel);
            _loc2_.unitScore = int(_loc1_.@unitScore);
            _loc2_.sname = String(_loc1_.@sname);
            _loc2_.needScore = _loc2_.slevel * _loc2_.unitScore;
            _loc3_ = new Array();
            _loc4_ = String(_loc1_.@posArr).split(";");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc9_ = String(_loc4_[_loc5_]).split(",");
               _loc3_.push(_loc9_);
               _loc5_++;
            }
            _loc2_.posArr = _loc3_;
            _loc6_ = _loc1_.descendants("item");
            _loc7_ = new Vector.<WanWangBattleItemInfo>();
            for each(_loc8_ in _loc6_)
            {
               (_loc10_ = new WanWangBattleItemInfo()).id = uint(_loc8_.@id);
               _loc10_.name = String(_loc8_.@name);
               _loc10_.count = uint(_loc8_.@count);
               _loc11_ = String(_loc8_.@pos).split(",");
               _loc12_ = new Point(_loc11_[0],_loc11_[1]);
               _loc10_.posArr = _loc12_;
               _loc7_.push(_loc10_);
            }
            _loc2_.itemList = _loc7_;
            this._allStep.push(_loc2_);
         }
         this._allStep.sort(this.downSort);
         this._isLoaded = true;
         this._isLoading = false;
         this.callback();
      }
      
      private function downSort(param1:WanWangBattleInfo, param2:WanWangBattleInfo) : Number
      {
         if(param1.sid < param2.sid)
         {
            return -1;
         }
         if(param1.sid > param2.sid)
         {
            return 1;
         }
         return 0;
      }
   }
}
