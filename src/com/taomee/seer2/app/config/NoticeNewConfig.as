package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.info.ItemInfo;
   import com.taomee.seer2.app.config.info.NoticeInfo;
   import com.taomee.seer2.app.config.info.NoticeLimitInfo;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   import org.taomee.ds.HashMap;
   
   public class NoticeNewConfig
   {
      
      private static var _instance:NoticeNewConfig;
       
      
      private var _isLoaded:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var _allXml:XMLList;
      
      private var _allAct:Vector.<NoticeInfo>;
      
      private var _hotAct:Vector.<NoticeInfo>;
      
      private var _closeAct:Vector.<NoticeInfo>;
      
      private var _petAct:Vector.<NoticeInfo>;
      
      private var _evlAct:Vector.<NoticeInfo>;
      
      private var _fdbAct:Vector.<NoticeInfo>;
      
      private var _dressAct:Vector.<NoticeInfo>;
      
      private var _vipAct:Vector.<NoticeInfo>;
      
      private var _recommendAct:Vector.<NoticeInfo>;
      
      private var callback:Function;
      
      public function NoticeNewConfig()
      {
         super();
      }
      
      public static function get Instance() : NoticeNewConfig
      {
         if(!_instance)
         {
            _instance = new NoticeNewConfig();
         }
         return _instance;
      }
      
      public function get vipAct() : Vector.<NoticeInfo>
      {
         return this._vipAct;
      }
      
      public function get dressAct() : Vector.<NoticeInfo>
      {
         return this._dressAct;
      }
      
      public function get evlAct() : Vector.<NoticeInfo>
      {
         return this._evlAct;
      }
      
      public function get petAct() : Vector.<NoticeInfo>
      {
         return this._petAct;
      }
      
      public function get closeAct() : Vector.<NoticeInfo>
      {
         return this._closeAct;
      }
      
      public function get hotAct() : Vector.<NoticeInfo>
      {
         return this._hotAct;
      }
      
      public function get fdbAct() : Vector.<NoticeInfo>
      {
         return this._fdbAct;
      }
      
      public function get recommendAct() : Vector.<NoticeInfo>
      {
         var _loc1_:NoticeInfo = null;
         this._recommendAct = new Vector.<NoticeInfo>();
         for each(_loc1_ in this._allAct)
         {
            if(ActorManager.actorInfo.trainerLevel < 7 && _loc1_.trainerLev < 7)
            {
               this._recommendAct.push(_loc1_);
            }
            else if(ActorManager.actorInfo.trainerLevel > 6 && ActorManager.actorInfo.trainerLevel < 13 && _loc1_.trainerLev < 13)
            {
               this._recommendAct.push(_loc1_);
            }
            else if(ActorManager.actorInfo.trainerLevel > 12)
            {
               this._recommendAct.push(_loc1_);
            }
         }
         return this._recommendAct;
      }
      
      public function get allAct() : Vector.<NoticeInfo>
      {
         return this._allAct;
      }
      
      public function getNoticeInfo(param1:Function) : void
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
            QueueLoader.load(URLUtil.getActivityXML("activity_notice_new"),LoadType.TEXT,this.onComplete);
         }
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         this._allXml = XML(param1.content).descendants("act");
         this.parserXml();
      }
      
      private function parserXml() : void
      {
         var _loc1_:XML = null;
         var _loc2_:NoticeInfo = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:XMLList = null;
         var _loc6_:XML = null;
         var _loc7_:XMLList = null;
         var _loc8_:XML = null;
         var _loc9_:XMLList = null;
         var _loc10_:XML = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:NoticeLimitInfo = null;
         var _loc14_:ItemInfo = null;
         this._allAct = new Vector.<NoticeInfo>();
         this._hotAct = new Vector.<NoticeInfo>();
         this._closeAct = new Vector.<NoticeInfo>();
         this._petAct = new Vector.<NoticeInfo>();
         this._evlAct = new Vector.<NoticeInfo>();
         this._fdbAct = new Vector.<NoticeInfo>();
         this._dressAct = new Vector.<NoticeInfo>();
         this._vipAct = new Vector.<NoticeInfo>();
         for each(_loc1_ in this._allXml)
         {
            _loc2_ = new NoticeInfo();
            _loc2_.resId = String(_loc1_.@resId);
            _loc2_.difficulty = int(_loc1_.@difficulty);
            _loc2_.trainerLev = int(_loc1_.@trainer);
            _loc2_.go = String(_loc1_.@go).split(",");
            _loc2_.isMapID = int(_loc1_.@isMapID);
            _loc2_.strategyId = uint(_loc1_.@strategyId);
            _loc2_.time = String(_loc1_.detail.@time);
            _loc2_.detailDes = String(_loc1_.detail.@des);
            _loc2_.des = String(_loc1_.@des);
            _loc2_.isAll = int(_loc1_.time.@isAll) == 0 ? false : true;
            _loc2_.startTime = String(_loc1_.time.@start);
            _loc2_.endTime = String(_loc1_.time.@end);
            _loc3_ = _loc1_.descendants("limit");
            _loc2_.timeLimit = new HashMap();
            for each(_loc4_ in _loc3_)
            {
               _loc11_ = String(_loc4_.@day);
               if(!_loc2_.timeLimit.getValue(_loc11_))
               {
                  _loc2_.timeLimit.add(_loc11_,[]);
               }
               _loc12_ = _loc2_.timeLimit.getValue(_loc11_) as Array;
               (_loc13_ = new NoticeLimitInfo()).startTime = String(_loc4_.@start);
               _loc13_.endTime = String(_loc4_.@end);
               _loc12_.push(_loc13_);
            }
            _loc5_ = _loc1_.descendants("item");
            _loc2_.itemReward = new Vector.<ItemInfo>();
            for each(_loc6_ in _loc5_)
            {
               _loc14_ = new ItemInfo(_loc6_);
               _loc2_.itemReward.push(_loc14_);
            }
            _loc7_ = _loc1_.descendants("pet");
            _loc2_.petReward = [];
            for each(_loc8_ in _loc7_)
            {
               _loc2_.petReward.push(_loc8_.attribute("id"));
            }
            _loc2_.types = new Vector.<String>();
            _loc9_ = _loc1_.descendants("type");
            for each(_loc10_ in _loc9_)
            {
               _loc2_.types.push(_loc10_.@name);
               if(_loc10_.@name == "hot")
               {
                  this._hotAct.push(_loc2_);
               }
               else if(_loc10_.@name == "close")
               {
                  this._closeAct.push(_loc2_);
               }
               else if(_loc10_.@name == "pet")
               {
                  this._petAct.push(_loc2_);
               }
               else if(_loc10_.@name == "evl")
               {
                  this._evlAct.push(_loc2_);
               }
               else if(_loc10_.@name == "fdb")
               {
                  this._fdbAct.push(_loc2_);
               }
               else if(_loc10_.@name == "dress")
               {
                  this._dressAct.push(_loc2_);
               }
               else if(_loc10_.@name == "vip")
               {
                  this._vipAct.push(_loc2_);
               }
            }
            this._allAct.push(_loc2_);
         }
         this._isLoaded = true;
         this._isLoading = false;
         this.callback();
      }
   }
}
