package org.taomee.events
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.core.DragSource;
   
   public class DragEvent extends MouseEvent
   {
      
      public static const DRAG_DROP:String = "dragDrop";
      
      public static const DRAG_COMPLETE:String = "dragComplete";
      
      public static const DRAG_EXIT:String = "dragExit";
      
      public static const DRAG_ENTER:String = "dragEnter";
      
      public static const DRAG_UPEATE:String = "dragUpdate";
      
      public static const DRAG_START:String = "dragStart";
      
      public static const DRAG_OVER:String = "dragOver";
       
      
      public var dropTarget:InteractiveObject;
      
      public var allowMove:Boolean;
      
      public var dragInitiator:InteractiveObject;
      
      public var action:String;
      
      public var dragSource:DragSource;
      
      public function DragEvent(param1:String, param2:InteractiveObject = null, param3:InteractiveObject = null, param4:DragSource = null, param5:String = null, param6:Boolean = true)
      {
         super(param1);
         this.dragInitiator = param2;
         this.dropTarget = param3;
         this.dragSource = param4;
         this.action = param5;
         this.allowMove = param6;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DragEvent = new DragEvent(type,dragInitiator,dropTarget,dragSource,action,allowMove);
         _loc1_.ctrlKey = ctrlKey;
         _loc1_.altKey = altKey;
         _loc1_.shiftKey = shiftKey;
         _loc1_.relatedObject = relatedObject;
         _loc1_.localX = localX;
         _loc1_.localY = localY;
         return _loc1_;
      }
   }
}
