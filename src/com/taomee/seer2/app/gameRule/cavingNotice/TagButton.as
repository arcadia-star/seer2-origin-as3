package com.taomee.seer2.app.gameRule.cavingNotice
{
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class TagButton extends Sprite
   {
       
      
      public var mainButton:SimpleButton;
      
      public var goButton:SimpleButton;
      
      public var mainBtnTip:String;
      
      public function TagButton(param1:MovieClip, param2:String = "")
      {
         super();
         this.mainButton = param1["mainButton"];
         this.goButton = param1["gotoBtn"];
         this.mainBtnTip = param2;
         if(param2 != "")
         {
            TooltipManager.addCommonTip(this.mainButton,param2);
         }
         addChild(param1);
      }
   }
}
