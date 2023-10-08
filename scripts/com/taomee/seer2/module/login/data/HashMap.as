package com.taomee.seer2.module.login.data
{
   import flash.utils.Dictionary;
   
   public class HashMap
   {
       
      
      private var _dic:Dictionary;
      
      private var _len:int;
      
      public function HashMap(param1:Boolean = false)
      {
         super();
         this._dic = new Dictionary(param1);
         this._len = 0;
      }
      
      public function containKey(param1:*) : Boolean
      {
         if(param1 in this._dic)
         {
            return true;
         }
         return false;
      }
      
      public function containValue(param1:*) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._dic)
         {
            if(this._dic[_loc2_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function add(param1:*, param2:*) : void
      {
         if(!this.containKey(param1))
         {
            ++this._len;
         }
         this._dic[param1] = param2;
      }
      
      public function remove(param1:*) : void
      {
         if(this.containKey(param1))
         {
            --this._len;
            this._dic[param1] = null;
            delete this._dic[param1];
         }
      }
      
      public function get length() : int
      {
         return this._len;
      }
      
      public function getValue(param1:*) : *
      {
         if(this.containKey(param1))
         {
            return this._dic[param1];
         }
         return null;
      }
      
      public function getKey(param1:*) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._dic)
         {
            if(this._dic[_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getKeys() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this._dic)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getValues() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this._dic)
         {
            _loc1_.push(this._dic[_loc2_]);
         }
         return _loc1_;
      }
   }
}
