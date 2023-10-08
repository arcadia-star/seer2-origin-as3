package com.taomee.seer2.app.processor.activity.npcPosHandle
{
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class NpcPosHandle
   {
      
      private static var _isDown:Boolean = false;
      
      public static var isMove:Boolean = false;
      
      private static var _curDrag:Mobile;
      
      private static var _movableFlag:Boolean = false;
      
      private static var _switchCompleteFlag:Boolean = false;
       
      
      public function NpcPosHandle()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(ClientConfig.isLocal)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         }
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         _switchCompleteFlag = true;
         if(_movableFlag == false)
         {
            return;
         }
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageDown);
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_UP,onStageUp);
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_OVER,onStageOver);
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_OUT,onStageOut);
      }
      
      private static function onStageDown(param1:MouseEvent) : void
      {
         if(!(param1.target is Mobile))
         {
            return;
         }
         if(MobileManager.getMobileVec(MobileType.NPC) == null)
         {
            return;
         }
         _curDrag = param1.target as Mobile;
         if(MobileManager.getMobileVec(MobileType.NPC).indexOf(_curDrag) != -1)
         {
            _curDrag.startDrag();
            _curDrag.addEventListener(MouseEvent.MOUSE_MOVE,onNpcMove);
            _isDown = true;
         }
      }
      
      private static function onNpcMove(param1:MouseEvent) : void
      {
         isMove = true;
      }
      
      private static function onStageUp(param1:MouseEvent) : void
      {
         if(!(param1.target is Mobile))
         {
            return;
         }
         var _loc2_:Mobile = param1.target as Mobile;
         _loc2_.stopDrag();
         if(_curDrag)
         {
            _curDrag.removeEventListener(MouseEvent.MOUSE_MOVE,onNpcMove);
         }
         _isDown = false;
      }
      
      private static function onStageOver(param1:MouseEvent) : void
      {
         var _loc2_:Mobile = getCurNpc(param1.target as DisplayObject);
         if(!_loc2_)
         {
            return;
         }
         if(_isDown)
         {
            return;
         }
         TooltipManager.addCommonTip(_loc2_,"id:" + _loc2_.id + "  坐标:x=" + int(_loc2_.x) + "  y=" + int(_loc2_.y));
      }
      
      private static function getCurNpc(param1:DisplayObject) : Mobile
      {
         var _loc3_:Mobile = null;
         var _loc2_:Mobile = null;
         for each(_loc3_ in MobileManager.getMobileVec(MobileType.NPC))
         {
            if(_loc3_ == param1 || Boolean(_loc3_.contains(param1)))
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      private static function onStageOut(param1:MouseEvent) : void
      {
         var _loc2_:Mobile = getCurNpc(param1.target as DisplayObject);
         if(_loc2_)
         {
            TooltipManager.addCommonTip(_loc2_,"id:" + _loc2_.id + "  坐标:x=" + int(_loc2_.x) + "  y=" + int(_loc2_.y));
         }
      }
      
      public static function setMovableState(param1:Boolean) : void
      {
         _movableFlag = param1;
         if(_switchCompleteFlag == false)
         {
            return;
         }
         if(param1)
         {
            LayerManager.stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageDown);
            LayerManager.stage.addEventListener(MouseEvent.MOUSE_UP,onStageUp);
            LayerManager.stage.addEventListener(MouseEvent.MOUSE_OVER,onStageOver);
            LayerManager.stage.addEventListener(MouseEvent.MOUSE_OUT,onStageOut);
         }
         else
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
            LayerManager.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onStageDown);
            LayerManager.stage.removeEventListener(MouseEvent.MOUSE_UP,onStageUp);
            LayerManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,onStageOver);
            LayerManager.stage.removeEventListener(MouseEvent.MOUSE_OUT,onStageOut);
         }
      }
   }
}
