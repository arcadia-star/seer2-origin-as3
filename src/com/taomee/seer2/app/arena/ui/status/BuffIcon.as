package com.taomee.seer2.app.arena.ui.status
{
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.core.utils.LabelRenderer;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BuffIcon extends Sprite
   {
       
      
      private var _buffId:int;
      
      private var _buffUrl:String;
      
      private var _icon:IconDisplayer;
      
      private var _numImage:Bitmap;
      
      public function BuffIcon()
      {
         super();
         this.mouseEnabled = false;
         this._icon = new IconDisplayer();
         addChild(this._icon);
      }
      
      public function updateBuffStatus(param1:uint) : void
      {
         if(param1 < 100 && param1 != 0)
         {
            this._numImage = LabelRenderer.getLabelImage(param1 + "",16777215,3342336,16);
            this._numImage.x = 15;
            this._numImage.y = 10;
            addChild(this._numImage);
         }
      }
      
      public function setBuffId(param1:int) : void
      {
         this._buffId = param1;
         trace("buffid: " + this._buffId);
         this._buffUrl = URLUtil.getSkillSideEffectIcon(this._buffId);
         this._icon.setIconUrl(this._buffUrl);
      }
      
      public function dispose() : void
      {
         this._icon.dispose();
         this._icon = null;
      }
   }
}
