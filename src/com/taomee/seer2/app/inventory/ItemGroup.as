package com.taomee.seer2.app.inventory
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class ItemGroup
   {
      
      public static const MOLECULAR_PASSWORD:String = "molecularPassword";
      
      public static const DAILY_QUEST:String = "dailyQuest";
       
      
      private var _id:int;
      
      private var _category:String;
      
      private var _itemDesVec:Vector.<ItemDescription>;
      
      public function ItemGroup(param1:int, param2:String, param3:Vector.<ItemDescription>)
      {
         super();
         this._id = param1;
         this._category = param2;
         this._itemDesVec = param3;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function get itemDesVec() : Vector.<ItemDescription>
      {
         return this._itemDesVec;
      }
      
      public function get iconUrl() : String
      {
         if(this._itemDesVec.length == 1)
         {
            return ItemConfig.getItemIconUrl(this._itemDesVec[0].referenceId);
         }
         return URLUtil.getGroupIcon(this._category,this._id);
      }
      
      public function contains(param1:Vector.<ItemDescription>) : Boolean
      {
         var _loc2_:ItemDescription = null;
         var _loc3_:Boolean = false;
         var _loc4_:ItemDescription = null;
         if(this._itemDesVec.length != param1.length)
         {
            return false;
         }
         for each(_loc2_ in this._itemDesVec)
         {
            _loc3_ = false;
            for each(_loc4_ in param1)
            {
               if(_loc2_.equals(_loc4_))
               {
                  _loc3_ = true;
               }
            }
            if(!_loc3_)
            {
               return false;
            }
         }
         return true;
      }
   }
}
