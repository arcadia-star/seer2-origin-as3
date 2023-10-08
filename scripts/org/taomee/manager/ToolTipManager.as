package org.taomee.manager
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import org.taomee.ds.HashMap;
   import org.taomee.utils.DisplayUtil;
   
   public class ToolTipManager
   {
      
      private static var _container:Sprite;
      
      private static var _bg:DisplayObject;
      
      private static var _map:HashMap;
      
      private static var _txt:TextField;
       
      
      public function ToolTipManager()
      {
         super();
      }
      
      public static function add(param1:InteractiveObject, param2:String, param3:int = 120, param4:Boolean = true) : void
      {
         param1.addEventListener(MouseEvent.ROLL_OVER,onOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,onOut);
         _map.add(param1,{
            "text":param2,
            "wordWrap":param4,
            "width":param3
         });
      }
      
      public static function remove(param1:InteractiveObject) : void
      {
         if(_map.containsKey(param1))
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,onOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT,onOut);
            _map.remove(param1);
         }
         onFinish();
      }
      
      private static function onOut(param1:MouseEvent) : void
      {
         onFinish();
      }
      
      private static function onMove(param1:MouseEvent) : void
      {
         PopUpManager.showForMouse(_container,PopUpManager.TOP_RIGHT,5,-5);
      }
      
      private static function onOver(param1:MouseEvent) : void
      {
         var _loc2_:InteractiveObject = param1.currentTarget as InteractiveObject;
         var _loc3_:Object = _map.getValue(_loc2_);
         if(_loc3_.wordWrap)
         {
            _txt.wordWrap = true;
            _txt.width = 120;
         }
         else
         {
            _txt.wordWrap = false;
         }
         _txt.width = _loc3_.width;
         _txt.htmlText = _loc3_.text;
         _bg.width = _txt.textWidth + 9;
         _bg.height = _txt.textHeight + 9;
         _txt.width = _txt.textWidth + 4;
         _txt.height = _txt.textHeight + 4;
         PopUpManager.showForMouse(_container,PopUpManager.TOP_RIGHT,5,-5);
         TaomeeManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
      }
      
      private static function onFinish() : void
      {
         DisplayUtil.removeForParent(_container);
         TaomeeManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
      }
      
      public static function setup(param1:DisplayObject) : void
      {
         _bg = param1;
         _map = new HashMap();
         _container = new Sprite();
         _container.mouseChildren = false;
         _container.mouseEnabled = false;
         _container.addChild(_bg);
         _txt = new TextField();
         _txt.multiline = true;
         _txt.autoSize = TextFieldAutoSize.LEFT;
         _txt.x = 2;
         _txt.y = 2;
         _container.addChild(_txt);
      }
   }
}
