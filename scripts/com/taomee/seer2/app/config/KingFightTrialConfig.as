package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.KingFightTrialInfo;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class KingFightTrialConfig
   {
      
      private static var _instance:com.taomee.seer2.app.config.KingFightTrialConfig;
       
      
      private var _isLoaded:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var _allXml:XMLList;
      
      private var _fightInfoList:Vector.<KingFightTrialInfo>;
      
      private var _openNum:int;
      
      private var _curFightNum:int;
      
      private var callback:Function;
      
      public function KingFightTrialConfig()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.config.KingFightTrialConfig
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.config.KingFightTrialConfig();
         }
         return _instance;
      }
      
      public function get fightInfoList() : Vector.<KingFightTrialInfo>
      {
         return this._fightInfoList;
      }
      
      public function get openNum() : int
      {
         return this._openNum;
      }
      
      public function set curFightNum(param1:int) : void
      {
         this._curFightNum = param1;
      }
      
      public function get curFightNum() : int
      {
         return this._curFightNum;
      }
      
      public function getFightInfo(param1:Function) : void
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
            QueueLoader.load(URLUtil.getActivityXML("KingFightTrial"),LoadType.TEXT,this.onComplete);
         }
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         this._openNum = int(XML(param1.content).@openNum);
         this._allXml = XML(param1.content).descendants("item");
         this.parserXml();
      }
      
      private function parserXml() : void
      {
         var _loc1_:KingFightTrialInfo = null;
         var _loc2_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         this._fightInfoList = new Vector.<KingFightTrialInfo>();
         var _loc3_:Array = [0,0.05,0.1,0.15,0.2,0.25];
         for each(_loc4_ in this._allXml)
         {
            _loc1_ = new KingFightTrialInfo();
            _loc1_.level = int(_loc4_.@level);
            _loc1_.fightResList = new Vector.<int>();
            _loc5_ = String(_loc4_.@fightResList).split(",");
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               _loc1_.fightResList.push(_loc5_[_loc2_]);
               _loc2_++;
            }
            _loc1_.layerNum = int(_loc4_.@id);
            _loc1_.awradList.push(["exp",int(_loc1_.layerNum * 130 / 5 + _loc3_[VipManager.vipInfo.level] * _loc1_.layerNum * 130 / 5)]);
            _loc1_.awradList.push(["coin",int(200 + _loc1_.layerNum * 5)]);
            if(String(_loc4_.@award) != "")
            {
               _loc6_ = String(_loc4_.@award).split(";");
               _loc2_ = 0;
               while(_loc2_ < _loc6_.length)
               {
                  _loc7_ = String(_loc6_[_loc2_]).split(",");
                  _loc1_.awradList.push([_loc7_[0],int(_loc7_[1])]);
                  _loc2_++;
               }
            }
            this._fightInfoList.push(_loc1_);
         }
         this._isLoaded = true;
         this._isLoading = false;
         this.callback();
      }
      
      public function getTotalAwardList(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(this._allXml == null)
         {
            return _loc2_;
         }
         if(param1.length == 0)
         {
            return _loc2_;
         }
         _loc2_.push(["exp",0],["coin",0]);
         var _loc3_:Array = [0,0.05,0.1,0.15,0.2,0.25];
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            (_loc2_[0] as Array)[1] += int(this._fightInfoList[param1[_loc5_]].layerNum * 130 / 5 + _loc3_[VipManager.vipInfo.level] * this._fightInfoList[param1[_loc5_]].layerNum * 130 / 5);
            (_loc2_[1] as Array)[1] += int(this._fightInfoList[param1[_loc5_]].layerNum * 5 + 200);
            _loc4_ = 0;
            while(_loc4_ < this._fightInfoList[param1[_loc5_]].awradList.length)
            {
               this.propMerge(_loc2_,this._fightInfoList[param1[_loc5_]].awradList[_loc4_] as Array);
               _loc4_++;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function propMerge(param1:Array, param2:Array) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param2[0] == "exp" || param2[0] == "coin")
         {
            return;
         }
         if(param2[0] == "pet")
         {
            param1.push(param2.slice());
         }
         else
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               if((param1[_loc4_] as Array)[0] == param2[0])
               {
                  (param1[_loc4_] as Array)[1] += param2[1];
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               param1.push(param2.slice());
            }
         }
      }
   }
}
