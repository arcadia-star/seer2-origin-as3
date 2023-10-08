package com.taomee.seer2.app.rightToolbar
{
   import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
   
   public interface IToolBar
   {
       
      
      function get isShowTime() : Boolean;
      
      function init(param1:RightToolbarInfo) : void;
      
      function remove() : void;
      
      function update() : void;
      
      function set x(param1:Number) : void;
      
      function set y(param1:Number) : void;
   }
}
