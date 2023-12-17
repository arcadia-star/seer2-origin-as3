package com.taomee.seer2.core.log
{
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LogArea extends Sprite
   {
      
      private static var _logArea:LogArea;
      
      private static const MAX_LINES:uint = 22;
       
      
      private var bg:Shape;
      
      private var close:Sprite;
      
      private var clear:Sprite;
      
      private var txt:TextField;
      
      private var tf:TextFormat;
      
      public function LogArea(param1:InterClass)
      {
         var _loc2_:TextField = null;
         var _loc3_:TextField = null;
         super();
         if(_logArea)
         {
            throw new Error("LogArea重复实例化");
         }
         this.bg = new Shape();
         this.bg.graphics.beginFill(0);
         this.bg.graphics.drawRect(0,0,370,491);
         this.bg.graphics.endFill();
         addChild(this.bg);
         this.tf = new TextFormat();
         this.tf.size = 18;
         this.txt = new TextField();
         this.txt.defaultTextFormat = this.tf;
         this.txt.multiline = true;
         this.txt.textColor = 16776960;
         this.txt.width = 370;
         this.txt.height = 491;
         this.txt.border = true;
         this.txt.borderColor = 16777215;
         this.txt.text = "日志打印工具(注:空格键开启或关闭)\n";
         addChild(this.txt);
         this.close = new Sprite();
         this.close.buttonMode = true;
         this.close.graphics.beginFill(16776960);
         this.close.graphics.drawRect(0,0,30,21);
         this.close.graphics.endFill();
         addChild(this.close);
         this.close.x = this.bg.width - 50;
         this.close.y = 5;
         this.close.buttonMode = true;
         _loc2_ = new TextField();
         _loc2_.text = "关闭";
         _loc2_.selectable = false;
         this.close.addChild(_loc2_);
         this.close.addEventListener(MouseEvent.CLICK,this.onClose);
         this.clear = new Sprite();
         this.clear.buttonMode = true;
         this.clear.graphics.beginFill(16776960);
         this.clear.graphics.drawRect(0,0,30,21);
         this.clear.graphics.endFill();
         addChild(this.clear);
         this.clear.x = this.bg.width - 50;
         this.clear.y = 35;
         this.clear.buttonMode = true;
         _loc3_ = new TextField();
         _loc3_.text = "清空";
         _loc3_.selectable = false;
         this.clear.addChild(_loc3_);
         this.clear.addEventListener(MouseEvent.CLICK,this.onClear);
      }
      
      public static function getInstance() : LogArea
      {
         if(_logArea == null)
         {
            _logArea = new LogArea(new InterClass());
         }
         return _logArea;
      }
      
      public function onClose(param1:MouseEvent) : void
      {
         DisplayObjectUtil.removeFromParent(LogArea.getInstance());
      }
      
      private function onClear(param1:MouseEvent) : void
      {
         this.txt.text = "";
         this.txt.scrollV = 1;
      }
      
      public function get logTxt() : TextField
      {
         return this.txt;
      }
      
      public function addLog(param1:String) : void
      {
         if(this.txt)
         {
            this.txt.appendText(param1 + "\n");
            if(this.txt.numLines > MAX_LINES)
            {
               this.txt.scrollV = this.txt.numLines - MAX_LINES + 1;
            }
            else
            {
               this.txt.scrollV = 1;
            }
         }
      }
   }
}

class InterClass
{
    
   
   public function InterClass()
   {
      super();
   }
}
