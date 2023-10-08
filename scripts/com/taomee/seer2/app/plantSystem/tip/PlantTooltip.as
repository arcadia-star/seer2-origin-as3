package com.taomee.seer2.app.plantSystem.tip
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import org.taomee.ds.HashMap;
   
   internal class PlantTooltip extends Sprite
   {
      
      private static const VERTICAL_GAP:int = 10;
      
      private static const LEFT_OFFSET:int = 10;
       
      
      private var _map:HashMap;
      
      private var _currentTipSkin:Sprite;
      
      private var _currentItemTipSkin:com.taomee.seer2.app.plantSystem.tip.PlantItemSkin;
      
      private var _currentIconTipSkin:com.taomee.seer2.app.plantSystem.tip.PlantIconSkin;
      
      public function PlantTooltip()
      {
         super();
         this._map = new HashMap();
      }
      
      public function add(param1:InteractiveObject, param2:InteractiveObject, param3:String, param4:String, param5:uint, param6:uint, param7:PlantTipSkin) : void
      {
         if(this._map.containsKey(param1))
         {
            this.chanegTip(param1,param2,param3,param4,param5,param6);
            return;
         }
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
         param2.addEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
         param2.addEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
         var _loc8_:TipStuct;
         (_loc8_ = new TipStuct()).nick = param3;
         _loc8_.timeStr = param4;
         _loc8_.currLoading = param5;
         _loc8_.totalLoading = param6;
         _loc8_.tipSkin = param7;
         this._map.add(param1,_loc8_);
         this._map.add(param2,_loc8_);
      }
      
      public function addIcon(param1:InteractiveObject, param2:String, param3:uint, param4:Boolean, param5:com.taomee.seer2.app.plantSystem.tip.PlantIconSkin) : void
      {
         if(this._map.containsKey(param1))
         {
            this.chanegIconTip(param1,param2,param3,param4);
            return;
         }
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onIconTargetOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onIconTargetOut);
         var _loc6_:TipStuct;
         (_loc6_ = new TipStuct()).content = param2;
         _loc6_.id = param3;
         _loc6_.isPet = param4;
         _loc6_.iconSkin = param5;
         this._map.add(param1,_loc6_);
      }
      
      private function onIconTargetOver(param1:MouseEvent) : void
      {
         var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
         if(_loc2_)
         {
            _loc2_.iconSkin.show(_loc2_.content,_loc2_.id,_loc2_.isPet);
            this._currentTipSkin = _loc2_.iconSkin;
            this.deployTooltip(param1.stageX,param1.stageY - VERTICAL_GAP);
         }
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onTooltipMove);
      }
      
      private function onIconTargetOut(param1:MouseEvent) : void
      {
         var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
         _loc2_.iconSkin.hide();
         this._currentTipSkin = null;
         LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onTooltipMove);
      }
      
      public function addItem(param1:InteractiveObject, param2:String, param3:com.taomee.seer2.app.plantSystem.tip.PlantItemSkin) : void
      {
         if(this._map.containsKey(param1))
         {
            this.chanegItemTip(param1,param2);
            return;
         }
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onItemTargetOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onItemTargetOut);
         var _loc4_:TipStuct;
         (_loc4_ = new TipStuct()).content = param2;
         _loc4_.itemSkin = param3;
         this._map.add(param1,_loc4_);
      }
      
      private function onItemTargetOver(param1:MouseEvent) : void
      {
         var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
         if(_loc2_)
         {
            _loc2_.itemSkin.show(_loc2_.content);
            this._currentTipSkin = _loc2_.itemSkin;
            this.deployTooltip(param1.stageX,param1.stageY - VERTICAL_GAP);
         }
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onTooltipMove);
      }
      
      private function onItemTargetOut(param1:MouseEvent) : void
      {
         var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
         _loc2_.itemSkin.hide();
         this._currentTipSkin = null;
         LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onTooltipMove);
      }
      
      public function removeItem(param1:InteractiveObject) : void
      {
         var _loc2_:TipStuct = null;
         if(Boolean(this._map.containsKey(param1)) && this._map.getValue(param1) is TipStuct)
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
            _loc2_ = this._map.getValue(param1) as TipStuct;
            _loc2_.itemSkin.hide();
            this._map.remove(param1);
         }
         else if(this._map.containsKey(param1))
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.artTipsControl);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.artTipsControl);
            this._map.remove(param1);
         }
      }
      
      public function removeIcon(param1:InteractiveObject) : void
      {
         var _loc2_:TipStuct = null;
         if(Boolean(this._map.containsKey(param1)) && this._map.getValue(param1) is TipStuct)
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
            _loc2_ = this._map.getValue(param1) as TipStuct;
            _loc2_.iconSkin.hide();
            this._map.remove(param1);
         }
         else if(this._map.containsKey(param1))
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.artTipsControl);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.artTipsControl);
            this._map.remove(param1);
         }
      }
      
      public function remove(param1:InteractiveObject, param2:InteractiveObject) : void
      {
         var _loc3_:TipStuct = null;
         if(Boolean(this._map.containsKey(param1)) && this._map.getValue(param1) is TipStuct)
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
            param2.removeEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
            param2.removeEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
            _loc3_ = this._map.getValue(param1) as TipStuct;
            _loc3_.tipSkin.hide();
            this._map.remove(param1);
            this._map.remove(param2);
         }
         else if(this._map.containsKey(param1))
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.artTipsControl);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.artTipsControl);
            this._map.remove(param1);
            this._map.remove(param2);
         }
      }
      
      public function chanegTip(param1:InteractiveObject, param2:InteractiveObject, param3:String, param4:String, param5:uint, param6:uint) : void
      {
         var _loc7_:TipStuct = null;
         if(this._map.containsKey(param1))
         {
            (_loc7_ = this._map.getValue(param1)).nick = param3;
            _loc7_.timeStr = param4;
            _loc7_.currLoading = param5;
            _loc7_.totalLoading = param6;
         }
      }
      
      public function chanegItemTip(param1:InteractiveObject, param2:String) : void
      {
         var _loc3_:TipStuct = null;
         if(this._map.containsKey(param1))
         {
            _loc3_ = this._map.getValue(param1);
            _loc3_.content = param2;
         }
      }
      
      public function chanegIconTip(param1:InteractiveObject, param2:String, param3:uint, param4:Boolean) : void
      {
         var _loc5_:TipStuct = null;
         if(this._map.containsKey(param1))
         {
            (_loc5_ = this._map.getValue(param1)).content = param2;
            _loc5_.id = param3;
            _loc5_.isPet = param4;
         }
      }
      
      public function setData(param1:InteractiveObject, param2:Object) : void
      {
         var _loc3_:TipStuct = null;
         if(this._map.containsKey(param1))
         {
            _loc3_ = this._map.getValue(param1);
            _loc3_.tipSkin.setData(param2);
         }
      }
      
      public function addArtTips(param1:InteractiveObject, param2:InteractiveObject, param3:DisplayObject) : void
      {
         if(this._map.containsKey(param1))
         {
            return;
         }
         param1.addEventListener(MouseEvent.ROLL_OVER,this.artTipsControl);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.artTipsControl);
         param2.addEventListener(MouseEvent.ROLL_OVER,this.onTargetOver);
         param2.addEventListener(MouseEvent.ROLL_OUT,this.onTargetOut);
         this._map.add(param1,param3);
         this._map.add(param2,param3);
      }
      
      private function artTipsControl(param1:MouseEvent) : void
      {
         var _loc2_:InteractiveObject = param1.currentTarget as InteractiveObject;
         var _loc3_:DisplayObject = this._map.getValue(_loc2_) as DisplayObject;
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.artTipsControl);
            this.updateArtTips(_loc3_);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            DisplayObjectUtil.removeFromParent(_loc3_);
         }
         else if(param1.type == MouseEvent.MOUSE_MOVE)
         {
            this.updateArtTips(_loc3_);
         }
      }
      
      private function updateArtTips(param1:DisplayObject) : void
      {
         var _loc2_:Stage = LayerManager.stage;
         if(!_loc2_.contains(param1))
         {
            _loc2_.addChild(param1);
         }
         if(_loc2_.mouseX > _loc2_.stageWidth - param1.width)
         {
            param1.x = _loc2_.mouseX - param1.width;
         }
         else
         {
            param1.x = _loc2_.mouseX;
         }
         if(_loc2_.mouseY > _loc2_.stageHeight - param1.height)
         {
            param1.y = _loc2_.mouseY - param1.height;
         }
         else
         {
            param1.y = _loc2_.mouseY;
         }
      }
      
      private function onTargetOver(param1:MouseEvent) : void
      {
         var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
         if(_loc2_)
         {
            _loc2_.tipSkin.show(_loc2_.nick,_loc2_.timeStr,_loc2_.currLoading,_loc2_.totalLoading);
            this._currentTipSkin = _loc2_.tipSkin;
            this.deployTooltip(param1.stageX,param1.stageY - VERTICAL_GAP);
         }
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onTooltipMove);
      }
      
      private function onTargetOut(param1:MouseEvent) : void
      {
         var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
         _loc2_.tipSkin.hide();
         this._currentTipSkin = null;
         LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onTooltipMove);
      }
      
      private function onTooltipMove(param1:MouseEvent) : void
      {
         this.deployTooltip(param1.stageX,param1.stageY - VERTICAL_GAP);
      }
      
      private function deployTooltip(param1:int, param2:int) : void
      {
         var _loc3_:int = param1;
         var _loc4_:int = param2;
         if(_loc3_ - LEFT_OFFSET < 0)
         {
            _loc3_ = LEFT_OFFSET + 2;
         }
         if(_loc4_ - this._currentTipSkin.height < 0)
         {
            _loc4_ = this._currentTipSkin.height - 22;
         }
         if(_loc3_ + this._currentTipSkin.width - LEFT_OFFSET > LayerManager.root.width)
         {
            _loc3_ = LayerManager.root.width - this._currentTipSkin.width + LEFT_OFFSET;
         }
         if(_loc4_ + this._currentTipSkin.height > LayerManager.root.height)
         {
            _loc4_ = LayerManager.root.height - this._currentTipSkin.height - 25;
         }
         this._currentTipSkin.x = _loc3_;
         this._currentTipSkin.y = _loc4_;
      }
   }
}

import com.taomee.seer2.app.plantSystem.tip.PlantIconSkin;
import com.taomee.seer2.app.plantSystem.tip.PlantItemSkin;
import com.taomee.seer2.app.plantSystem.tip.PlantTipSkin;

class TipStuct
{
    
   
   public var nick:String;
   
   public var content:String;
   
   public var timeStr:String;
   
   public var id:uint;
   
   public var isPet:Boolean;
   
   public var iconSkin:PlantIconSkin;
   
   public var itemSkin:PlantItemSkin;
   
   public var currLoading:uint;
   
   public var totalLoading:uint;
   
   public var tipSkin:PlantTipSkin;
   
   public function TipStuct()
   {
      super();
   }
}
