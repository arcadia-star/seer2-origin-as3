package com.taomee.seer2.app.arena.ui.status.statusBar
{
   import com.taomee.seer2.app.arena.data.FighterInfo;
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.arena.ui.status.AngerBar;
   import com.taomee.seer2.app.arena.ui.status.ShrinkBar;
   import com.taomee.seer2.core.ui.UINumberGenerator;
   
   public class SPTBossStatusBar extends FighterStatusBar
   {
       
      
      public function SPTBossStatusBar()
      {
         super();
      }
      
      override protected function createBack() : void
      {
         _back = FightUIManager.getSprite("UI_FightSPTBossStatusBack");
         addChild(_back);
      }
      
      override protected function createFighterIcon() : void
      {
         super.createFighterIcon();
         _iconDisplayer.scaleX = -1.5;
         _iconDisplayer.scaleY = 1.5;
      }
      
      override protected function createHealthBar() : void
      {
         _healthBar = new ShrinkBar("UI_FightSPTBossHealthBar");
         addChild(_healthBar);
      }
      
      override protected function createAngerBar() : void
      {
         _angerBar = new AngerBar("UI_FightSPTBossAngerBar");
         addChild(_angerBar);
      }
      
      override protected function createHealthShadowBar() : void
      {
         _healthShadowBar = new ShrinkBar("UI_FightSPTBossHealthShadowBar");
         addChild(_healthShadowBar);
      }
      
      override protected function layout() : void
      {
         setChildPosition(_back,162,0);
         setChildPosition(_nameSprite,877,104);
         setChildPosition(_levelSprite,802,53);
         setChildPosition(_sign,840,10);
         setChildPosition(_typeIcon,785,52);
         setChildPosition(_iconDisplayer,952,10);
         setChildPosition(_hpSign,637,13);
         setChildPosition(_healthBar,833,10);
         setChildPosition(_healthShadowBar,833,10);
         setChildPosition(_angerSign,657,33);
         setChildPosition(_angerBar,835,32);
      }
      
      override protected function updateHpSign() : void
      {
         if(_hpSign.numChildren > 0)
         {
            _hpSign.removeChildAt(0);
         }
         var _loc1_:FighterInfo = _fighter.fighterInfo;
         _hpSign.addChild(UINumberGenerator.generateHpNumber(_loc1_.hp,_loc1_.maxHp));
         _hpSign.x = 668 - _hpSign.width + 150;
      }
   }
}
