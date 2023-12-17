package com.taomee.seer2.app.arena.ui.status.substatusbar
{
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.arena.ui.status.BuffIconBar;
   import com.taomee.seer2.app.arena.ui.status.ShrinkBar;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.core.ui.UINumberGenerator;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.text.TextField;
   
   public class SubFighterStatusBar extends Sprite
   {
       
      
      private var _fighter:Fighter;
      
      private var _back:Sprite;
      
      private var _hpTxtSign:Sprite;
      
      private var _iconDisplayer:IconDisplayer;
      
      private var _levelSprite:Sprite;
      
      private var _healthBar:ShrinkBar;
      
      private var _angerBar:ShrinkBar;
      
      private var _buffIconBar:BuffIconBar;
      
      private var _nameSprite:Sprite;
      
      protected var _shape:Shape;
      
      public function SubFighterStatusBar()
      {
         super();
         this.initialize();
      }
      
      public function dispose() : void
      {
         this._fighter = null;
         this._back = null;
         this._hpTxtSign = null;
         this._iconDisplayer.dispose();
         this._iconDisplayer = null;
         this._levelSprite = null;
         this._buffIconBar.dispose();
         this._buffIconBar = null;
      }
      
      public function setFighter(param1:Fighter) : void
      {
         this._fighter = param1;
         this.update();
      }
      
      public function update() : void
      {
         this._iconDisplayer.setIconUrl(this._fighter.iconUrl);
         var _loc1_:Number = this._fighter.fighterInfo.hp / this._fighter.fighterInfo.maxHp;
         this._healthBar.initAtPercent(_loc1_);
         var _loc2_:Number = this._fighter.fighterInfo.fightAnger / this._fighter.fighterInfo.maxAnger;
         if(_loc1_ == 0)
         {
            _loc2_ = 0;
         }
         this._angerBar.initAtPercent(_loc2_);
         if(this._levelSprite.numChildren > 1)
         {
            this._levelSprite.removeChildAt(1);
         }
         var _loc3_:Sprite = UINumberGenerator.generateFighterLevelNumber(this._fighter.fighterInfo.level,9);
         _loc3_.x = 27;
         this._levelSprite.addChild(_loc3_);
         if(this._buffIconBar == null)
         {
            this._buffIconBar = new BuffIconBar(this._fighter.fighterSide,4);
            this._buffIconBar.scaleX = 0.8 * this.scaleX;
            this._buffIconBar.scaleY = 0.8;
            if(this.scaleX > 0)
            {
               this._buffIconBar.x = 67;
            }
            else
            {
               this._buffIconBar.x = 96;
            }
            this._buffIconBar.y = 32;
            addChild(this._buffIconBar);
         }
         this._buffIconBar.setFighter(this._fighter);
         this._buffIconBar.update();
         (this._nameSprite["fighterNameTxt"] as TextField).text = this._fighter.fighterInfo.name;
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.layout();
      }
      
      protected function createChildren() : void
      {
         this._back = FightUIManager.getSprite("UI_SubFightStatusBarBack");
         addChild(this._back);
         this._hpTxtSign = FightUIManager.getSprite("UI_FightStatusBarSign");
         this._hpTxtSign.scaleX = this._hpTxtSign.scaleY = 0.7;
         addChild(this._hpTxtSign);
         this._shape = new Shape();
         addChild(this._shape);
         this._iconDisplayer = new IconDisplayer();
         this._iconDisplayer.setBoundary(52,52);
         addChild(this._iconDisplayer);
         this._healthBar = new ShrinkBar("UI_SubFightHealthBar");
         addChild(this._healthBar);
         this._angerBar = new ShrinkBar("UI_SubFightAngerBar");
         addChild(this._angerBar);
         this._levelSprite = new Sprite();
         this._levelSprite.addChild(FightUIManager.getSprite("UI_FighterLevelSign"));
         addChild(this._levelSprite);
         this._nameSprite = FightUIManager.getSprite("UI_FighterName");
         addChild(this._nameSprite);
      }
      
      protected function layout() : void
      {
         this.setChildPosition(this._nameSprite,0,62);
         this.setChildPosition(this._hpTxtSign,64,2);
         this.setChildPosition(this._iconDisplayer,10,5);
         this.setChildPosition(this._healthBar,78,5);
         this.setChildPosition(this._angerBar,78,17);
         this.setChildPosition(this._levelSprite,7,45);
      }
      
      protected function setChildPosition(param1:DisplayObject, param2:int, param3:int) : void
      {
         param1.x = param2;
         param1.y = param3;
      }
      
      public function updatePetPress(param1:int) : void
      {
         if(param1 > -1)
         {
            this._shape.graphics.clear();
            this._shape.graphics.beginFill(param1);
            this._shape.graphics.drawRect(10,5,50,50);
            this._shape.filters = [new BlurFilter()];
            this._shape.graphics.endFill();
         }
         else
         {
            this._shape.graphics.clear();
         }
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         if(param1 == -1)
         {
            this._hpTxtSign.scaleX = -1 * this._hpTxtSign.scaleX;
            this._hpTxtSign.x = 78;
            this._levelSprite.scaleX = -1 * this._levelSprite.scaleX;
            this._levelSprite.x = 60;
            this._nameSprite.scaleX = -1;
            this._nameSprite.x = 75;
         }
      }
   }
}
