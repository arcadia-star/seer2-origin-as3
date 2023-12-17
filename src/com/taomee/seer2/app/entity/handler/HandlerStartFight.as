package com.taomee.seer2.app.entity.handler
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.utils.setTimeout;
   
   public class HandlerStartFight extends HandlerEntityClick
   {
       
      
      public function HandlerStartFight()
      {
         super();
      }
      
      override public function initData(param1:XML) : void
      {
      }
      
      override protected function action() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:Mobile = MobileManager.getMobile(_entityDefinition.id,MobileType.NPC);
         if(_loc1_)
         {
            _loc2_ = UIManager.getMovieClip("UI_FightSuprise");
            _loc2_.y = -80;
            _loc1_.addChild(_loc2_);
         }
         setTimeout(this.startFight,300);
      }
      
      private function startFight() : void
      {
         FightManager.startFightWithWild(8);
      }
   }
}
