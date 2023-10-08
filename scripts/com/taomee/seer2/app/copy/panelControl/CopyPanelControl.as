package com.taomee.seer2.app.copy.panelControl
{
   import flash.display.Sprite;
   
   public class CopyPanelControl extends Sprite
   {
      
      private static var _self:com.taomee.seer2.app.copy.panelControl.CopyPanelControl;
       
      
      public function CopyPanelControl()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.copy.panelControl.CopyPanelControl
      {
         if(_self == null)
         {
            _self = new com.taomee.seer2.app.copy.panelControl.CopyPanelControl();
         }
         return _self;
      }
      
      public function show() : void
      {
      }
      
      public function hide() : void
      {
      }
   }
}
