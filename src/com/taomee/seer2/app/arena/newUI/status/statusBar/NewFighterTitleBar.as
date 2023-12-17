package com.taomee.seer2.app.arena.newUI.status.statusBar
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NewFighterTitleBar extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      public function NewFighterTitleBar()
      {
         super();
         this._mc = FightUIManager.getMovieClip("New_UI_FighterTitle");
         addChild(this._mc);
      }
      
      public function setNum(param1:uint) : void
      {
         this._mc["countMC"].gotoAndStop(param1);
      }
   }
}
