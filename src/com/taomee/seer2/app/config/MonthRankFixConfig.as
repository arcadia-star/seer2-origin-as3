package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.MonthRankFixInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.grids.HashMap;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class MonthRankFixConfig
   {
      
      private static var _instance:MonthRankFixConfig;
       
      
      private var _isLoaded:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var _allXml:XMLList;
      
      private var _all:HashMap;
      
      private var callback:Function;
      
      private var _allList0:Array;
      
      private var _allList1:Array;
      
      private var _allList2:Array;
      
      private var _allList3:Array;
      
      private var _allList4:Array;
      
      private var _allList5:Array;
      
      public function MonthRankFixConfig()
      {
         super();
      }
      
      public static function get Instance() : MonthRankFixConfig
      {
         if(!_instance)
         {
            _instance = new MonthRankFixConfig();
         }
         return _instance;
      }
      
      public function get all() : HashMap
      {
         return this._all;
      }
      
      public function getListIDFromDate(param1:int) : int
      {
         var _loc4_:MonthRankFixInfo = null;
         var _loc2_:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
         var _loc3_:String = _loc2_.fullYear + String(_loc2_.month + 1 < 10 ? "0" + (_loc2_.month + 1) : _loc2_.month + 1);
         if(this._all.containsKey(_loc3_))
         {
            _loc4_ = this._all.getValue(_loc3_) as MonthRankFixInfo;
            if(param1 == 0)
            {
               return (this._all.getValue(_loc3_) as MonthRankFixInfo).list0;
            }
            if(param1 == 1)
            {
               return (this._all.getValue(_loc3_) as MonthRankFixInfo).list1;
            }
            if(param1 == 2)
            {
               return (this._all.getValue(_loc3_) as MonthRankFixInfo).list2;
            }
            if(param1 == 3)
            {
               return (this._all.getValue(_loc3_) as MonthRankFixInfo).list3;
            }
            if(param1 == 4)
            {
               return (this._all.getValue(_loc3_) as MonthRankFixInfo).list4;
            }
            if(param1 == 5)
            {
               return (this._all.getValue(_loc3_) as MonthRankFixInfo).list5;
            }
         }
         else
         {
            AlertManager.showAlert("请配置 MonthRankFix.xml.更新排行榜数据！");
         }
         return 0;
      }
      
      public function getInfo(param1:Function) : void
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
            QueueLoader.load(URLUtil.getActivityXML("MonthRankFix"),LoadType.TEXT,this.onComplete);
         }
      }
      
      private function onComplete(param1:ContentInfo) : void
      {
         this._allXml = XML(param1.content).descendants("rank");
         this.parserXml();
      }
      
      private function parserXml() : void
      {
         var _loc1_:XML = null;
         var _loc2_:MonthRankFixInfo = null;
         this._allList0 = new Array();
         this._allList1 = new Array();
         this._allList2 = new Array();
         this._allList3 = new Array();
         this._allList4 = new Array();
         this._allList5 = new Array();
         this._all = new HashMap();
         for each(_loc1_ in this._allXml)
         {
            _loc2_ = new MonthRankFixInfo();
            _loc2_.date = String(_loc1_.@date);
            _loc2_.list0 = int(_loc1_.@list0);
            _loc2_.list1 = int(_loc1_.@list1);
            _loc2_.list2 = int(_loc1_.@list2);
            _loc2_.list3 = int(_loc1_.@list3);
            _loc2_.list4 = int(_loc1_.@list4);
            _loc2_.list5 = int(_loc1_.@list5);
            this._all.put(_loc2_.date,_loc2_);
            this._allList0.push(_loc2_.list0);
            this._allList1.push(_loc2_.list1);
            this._allList2.push(_loc2_.list2);
            this._allList3.push(_loc2_.list3);
            this._allList4.push(_loc2_.list4);
            this._allList5.push(_loc2_.list5);
         }
         this._isLoaded = true;
         this._isLoading = false;
         this.callback();
      }
      
      public function get allList0() : Array
      {
         return this._allList0;
      }
      
      public function get allList1() : Array
      {
         return this._allList1;
      }
      
      public function get allList2() : Array
      {
         return this._allList2;
      }
      
      public function get allList3() : Array
      {
         return this._allList3;
      }
      
      public function get allList4() : Array
      {
         return this._allList4;
      }
      
      public function get allList5() : Array
      {
         return this._allList5;
      }
   }
}
