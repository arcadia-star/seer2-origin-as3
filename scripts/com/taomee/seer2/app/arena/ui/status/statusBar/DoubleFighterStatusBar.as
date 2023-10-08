package com.taomee.seer2.app.arena.ui.status.statusBar
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.arena.ui.status.AngerBar;
   import com.taomee.seer2.app.arena.ui.status.ShrinkBar;
   import com.taomee.seer2.app.component.IconDisplayer;
   import flash.display.MovieClip;
   import flash.filters.BlurFilter;
   
   public class DoubleFighterStatusBar extends FighterStatusBar
   {
       
      
      private var _hold:MovieClip;
      
      public function DoubleFighterStatusBar()
      {
         super();
      }
      
      override protected function createBack() : void
      {
         _back = FightUIManager.getSprite("UI_DoubleFightStatusBarBack");
         this._hold = _back["holder"];
         addChild(_back);
      }
      
      override protected function createFighterIcon() : void
      {
         _iconDisplayer = new IconDisplayer();
         _iconDisplayer.scaleX = 1.4;
         _iconDisplayer.scaleY = 1.4;
         addChild(_iconDisplayer);
      }
      
      override protected function createHealthBar() : void
      {
         _healthBar = new ShrinkBar("UI_DoubleFightHealthBar");
         addChild(_healthBar);
      }
      
      override protected function createAngerBar() : void
      {
         _angerBar = new AngerBar("UI_DoubleFightAngerBar");
         addChild(_angerBar);
      }
      
      override protected function createHealthShadowBar() : void
      {
         _healthShadowBar = new ShrinkBar("UI_DoubleFightHealthShadowBar");
         addChild(_healthShadowBar);
      }
      
      override protected function layout() : void
      {
         setChildPosition(_iconDisplayer,6,7);
         setChildPosition(_sign,85,9);
         setChildPosition(_healthShadowBar,111,10);
         setChildPosition(_healthBar,111,10);
         setChildPosition(_hpSign,120,13);
         setChildPosition(_angerBar,110,33);
         setChildPosition(_angerSign,120,33);
         setChildPosition(_levelSprite,10,70);
         setChildPosition(_nameSprite,4,90);
         setChildPosition(_typeIcon,65,50);
      }
      
      override public function updatePetPress(param1:int) : void
      {
         if(param1 > -1)
         {
            _shape.graphics.clear();
            _shape.graphics.beginFill(param1);
            _shape.graphics.drawRect(6,7,70,70);
            _shape.filters = [new BlurFilter()];
            _shape.graphics.endFill();
         }
         else
         {
            _shape.graphics.clear();
         }
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         if(param1 == -1)
         {
            _sign.scaleX = -1;
            _sign.x = 107;
            _hpSign.scaleX = -1;
            _hpSign.x = 230;
            _angerSign.scaleX = -1;
            _angerSign.x = 230;
            _levelSprite.scaleX = -1;
            _levelSprite.x = 69;
            _nameSprite.scaleX = -1;
            _nameSprite.x = 78;
            _typeIcon.scaleX = -1;
            _typeIcon.x = 65;
         }
      }
   }
}
