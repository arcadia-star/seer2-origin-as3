package com.taomee.seer2.app.arena.newUI.toolbar.sub
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class NewSuperSkillButton extends NewSkillButton
   {
       
      
      private var _skillInfo:SkillInfo;
      
      private var _huoMC:MovieClip;
      
      public function NewSuperSkillButton()
      {
         super();
      }
      
      override protected function createMc() : MovieClip
      {
         this._huoMC = FightUIManager.getMovieClip("UI_Fight_Super_MAX");
         return FightUIManager.getMovieClip("New_UI_FightSkillBtn2");
      }
      
      override protected function createSuperBrief() : MovieClip
      {
         return FightUIManager.getMovieClip("New_UI_FightSkillSuperBrief");
      }
      
      override protected function updatePoint() : void
      {
         _brief.x = 28;
         _typeIcon.x = 24;
      }
      
      override public function updateScale(param1:uint, param2:uint) : void
      {
         DisplayUtil.removeForParent(this._huoMC);
         if(param1 >= param2)
         {
            _tipMC.visible = false;
            this._huoMC.x = 90;
            this._huoMC.y = 61;
            this._huoMC.mouseChildren = false;
            this._huoMC.mouseEnabled = false;
            addChild(this._huoMC);
            this._huoMC.play();
         }
         else
         {
            _tipMC.visible = true;
         }
      }
      
      override protected function playSkillAngle(param1:uint, param2:uint) : void
      {
      }
      
      public function clearSkillInfo() : void
      {
         super.dispose();
      }
   }
}
