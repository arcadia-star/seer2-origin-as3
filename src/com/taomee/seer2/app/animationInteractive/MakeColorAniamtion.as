package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MakeColorAniamtion extends BaseAniamationInteractive
   {
       
      
      private var _colorPanel:MovieClip;
      
      private var _colorMouse:MovieClip;
      
      private var _sunflower:MovieClip;
      
      private var _greenContainer:MovieClip;
      
      private var _purpleContainer:MovieClip;
      
      private var _orangeContainer:MovieClip;
      
      private var _currentColor:int = 0;
      
      private var _preColor:int = 0;
      
      private var _makeColorVec:Vector.<int>;
      
      public function MakeColorAniamtion()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         this._colorPanel = _animation["colorPanel"];
         this._colorMouse = _animation["colorMouse"];
         this._sunflower = _animation["sunflower"];
         this._greenContainer = this._colorPanel["greenColorContainer"];
         this._purpleContainer = this._colorPanel["purpleColorContainer"];
         this._orangeContainer = this._colorPanel["orangeColorContainer"];
         this._colorMouse.gotoAndStop(1);
         this._colorMouse.visible = false;
         this._colorMouse.mouseChildren = false;
         this._colorMouse.mouseEnabled = false;
         this._sunflower.gotoAndStop(1);
         this._makeColorVec = Vector.<int>([0,0,0]);
         this.colorPanelChangeFrame(1);
         this.initEventListener();
      }
      
      private function colorPanelChangeFrame(param1:int) : void
      {
         this._colorPanel.gotoAndStop(param1);
         this._colorPanel["paletteMC"].buttonMode = true;
         this._colorPanel["color_1"].buttonMode = true;
         this._colorPanel["color_2"].buttonMode = true;
         this._colorPanel["color_3"].buttonMode = true;
         this.fillColor();
      }
      
      private function initEventListener() : void
      {
         this._colorPanel.addEventListener(MouseEvent.CLICK,this.onColorPanelClick);
         this._colorMouse.addEventListener(Event.ENTER_FRAME,this.onColorMouseEnterFrame);
         this._sunflower.addEventListener(Event.ENTER_FRAME,this.onSunflowerEnterFrame);
      }
      
      private function closeEventListener() : void
      {
         this._colorPanel.removeEventListener(MouseEvent.CLICK,this.onColorPanelClick);
         this._colorMouse.removeEventListener(Event.ENTER_FRAME,this.onColorMouseEnterFrame);
         this._sunflower.removeEventListener(Event.ENTER_FRAME,this.onSunflowerEnterFrame);
      }
      
      private function onColorPanelClick(param1:MouseEvent) : void
      {
         this._sunflower.gotoAndStop(1);
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.name.substr(0,6) == "color_")
         {
            this._currentColor = int(_loc2_.name.substr(6,1));
            this._colorMouse.visible = true;
            this._colorMouse.gotoAndStop(this._currentColor);
         }
         else if(_loc2_.name == "paletteMC")
         {
            this._colorMouse.visible = false;
            if(this._currentColor != 0)
            {
               if(this._colorPanel.currentFrame == 1)
               {
                  this.colorPanelChangeFrame(this._currentColor + 1);
               }
               else
               {
                  this._preColor = this._colorPanel.currentFrame - 1;
                  if(this.isNewColor())
                  {
                     this.colorPanelChangeFrame(5 + 11 * (this._preColor + this._currentColor - 3));
                     this.showMakeColor();
                  }
                  else
                  {
                     this._sunflower.gotoAndStop(3);
                     this.colorPanelChangeFrame(1);
                  }
               }
            }
         }
      }
      
      private function showMakeColor() : void
      {
         this._colorPanel.removeEventListener(MouseEvent.CLICK,this.onColorPanelClick);
         this._colorPanel["paletteMC"].addEventListener(Event.ENTER_FRAME,this.onPaletteEnterFrame);
      }
      
      private function onPaletteEnterFrame(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.onPaletteEnterFrame);
            _loc3_ = this._currentColor + this._preColor;
            this._currentColor = 0;
            switch(_loc3_)
            {
               case 3:
                  this._makeColorVec[0] = 1;
                  break;
               case 4:
                  this._makeColorVec[1] = 1;
                  break;
               case 5:
                  this._makeColorVec[2] = 1;
            }
            this.colorPanelChangeFrame(1);
            this.isMakeColorOver();
         }
      }
      
      private function fillColor() : void
      {
         this._orangeContainer.gotoAndStop(this._makeColorVec[0] + 1);
         this._purpleContainer.gotoAndStop(this._makeColorVec[1] + 1);
         this._greenContainer.gotoAndStop(this._makeColorVec[2] + 1);
      }
      
      private function isMakeColorOver() : void
      {
         if(this._makeColorVec[0] == 1 && this._makeColorVec[1] == 1 && this._makeColorVec[2] == 1)
         {
            this._sunflower.gotoAndStop(2);
            _closeBtn.mouseEnabled = false;
         }
         else
         {
            this._colorPanel.addEventListener(MouseEvent.CLICK,this.onColorPanelClick);
         }
      }
      
      private function onColorMouseEnterFrame(param1:Event) : void
      {
         this._colorMouse.x = LayerManager.stage.mouseX - 135;
         this._colorMouse.y = LayerManager.stage.mouseY - 65;
      }
      
      private function onSunflowerEnterFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = this._sunflower["carMC"];
         if(_loc2_.currentFrame >= 75)
         {
            if(this._sunflower.currentFrame == 2)
            {
               _loc2_.gotoAndStop(1);
               dispatchEvent(new Event(AnimationEvent.MAKECOLOR));
               this.dispose();
            }
            else if(this._sunflower.currentFrame == 3)
            {
               this._sunflower.gotoAndStop(1);
            }
         }
      }
      
      private function isNewColor() : Boolean
      {
         if(this._currentColor == 0 || this._preColor == 0)
         {
            return false;
         }
         if(this._currentColor == this._preColor)
         {
            return false;
         }
         var _loc1_:int = this._preColor + this._currentColor;
         if(_loc1_ == 3 && this._makeColorVec[0] == 0 || _loc1_ == 4 && this._makeColorVec[1] == 0 || _loc1_ == 5 && this._makeColorVec[2] == 0)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.closeEventListener();
      }
   }
}
