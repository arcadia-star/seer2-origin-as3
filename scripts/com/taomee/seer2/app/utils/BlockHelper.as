package com.taomee.seer2.app.utils
{
   public class BlockHelper
   {
       
      
      private var _isBlock:Boolean = false;
      
      private var _isEnable:Boolean = false;
      
      private var _func1:Function;
      
      private var _func2:Function;
      
      public function BlockHelper(param1:Function, param2:Function)
      {
         super();
         this._func1 = param1;
         this._func2 = param2;
      }
      
      public function dispose() : void
      {
         this._func1 = null;
         this._func2 = null;
      }
      
      public function get isEnable() : Boolean
      {
         return this._isEnable;
      }
      
      public function set isEnable(param1:Boolean) : void
      {
         this._isEnable = param1;
         if(!this._isBlock)
         {
            if(this._isEnable)
            {
               this._func1();
            }
            else
            {
               this._func2();
            }
         }
      }
      
      public function get isBlock() : Boolean
      {
         return this._isBlock;
      }
      
      public function set isBlock(param1:Boolean) : void
      {
         this._isBlock = param1;
         if(this._isEnable)
         {
            if(!this._isBlock)
            {
               this._func1();
            }
            else
            {
               this._func2();
            }
         }
      }
      
      public function validate() : Boolean
      {
         return !this._isBlock && this._isEnable;
      }
   }
}
