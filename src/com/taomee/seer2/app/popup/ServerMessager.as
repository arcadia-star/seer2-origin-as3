package com.taomee.seer2.app.popup
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import org.taomee.utils.Tick;
   
   public class ServerMessager extends Sprite
   {
      
      private static const MESSAGE_DISPEAR:String = "messageDispear";
      
      private static const NORMAL_DURATION:uint = 1500;
      
      private static const LAST_DURATION:uint = 2000;
      
      private static var _instance:ServerMessager;
      
      private static var _queue:MessagerQuene;
      
      private static var _isShowing:Boolean;
       
      
      private var _ui:MovieClip;
      
      private var _msgTxt:TextField;
      
      private var _tempList:Array;
      
      public function ServerMessager()
      {
         super();
         this.initialize();
      }
      
      public static function addMessage(param1:String) : void
      {
         if(_instance == null)
         {
            _instance = new ServerMessager();
            _queue = new MessagerQuene();
            _isShowing = false;
         }
         _queue.enquene(param1);
         showNextMessage();
      }
      
      private static function showNextMessage() : void
      {
         var _loc2_:uint = 0;
         if(_isShowing == true || _queue.length == 0)
         {
            return;
         }
         var _loc1_:int = _queue.length;
         if(_loc1_ > 1)
         {
            _loc2_ = NORMAL_DURATION;
         }
         else if(_loc1_ == 1)
         {
            _loc2_ = LAST_DURATION;
         }
         _instance.show(_queue.dequeue(),_loc2_);
         _isShowing = true;
      }
      
      private static function onMessageDispear(param1:Event) : void
      {
         _isShowing = false;
         _instance.removeEventListener(MESSAGE_DISPEAR,onMessageDispear);
         showNextMessage();
      }
      
      private function initialize() : void
      {
         DisplayObjectUtil.disableSprite(this);
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this._ui = UIManager.getMovieClip("UI_ServerMessager");
         if(this._ui == null)
         {
            return;
         }
         this._msgTxt = this._ui["msgTxt"];
         this._msgTxt.addEventListener(TextEvent.LINK,this.onTextClick);
         addChild(this._ui);
      }
      
      private function onTimer(param1:int) : void
      {
         Tick.instance.removeRender(this.onTimer);
         this.hide();
         showNextMessage();
      }
      
      private function hide() : void
      {
         DisplayObjectUtil.removeFromParent(this._ui);
         _isShowing = false;
      }
      
      private function show(param1:String, param2:uint) : void
      {
         var message:String = param1;
         var duration:uint = param2;
         if(this._ui == null || message == null)
         {
            return;
         }
         this._tempList = message.split("|");
         if(this._tempList.length < 2)
         {
            this._msgTxt.htmlText = "<b>" + this._tempList[0] + "</b>";
         }
         else
         {
            this._msgTxt.htmlText = "<b>" + this._tempList[0] + "<font color=\'#00FFFF\'><a href=\'event:clicktext\'>【<u>" + this._tempList[1] + "</u>】</a></font></b>";
         }
         LayerManager.topLayer.addChild(this._ui);
         this._ui.x = 240 - (240 - 240 * (LayerManager.stage.stageWidth / 1200)) * 2;
         this._ui.y = 260;
         this._ui.alpha = 0.3;
         TweenLite.to(this._ui,1,{
            "y":130,
            "alpha":2,
            "onComplete":function():void
            {
               Tick.instance.addRender(onTimer,duration);
            }
         });
      }
      
      private function onTextClick(param1:TextEvent) : void
      {
         if(this._tempList.length > 3)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(this._tempList[2]),"正在加载面板...",this._tempList[3]);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(this._tempList[2]),"正在加载面板...");
         }
      }
   }
}

class MessagerQuene
{
    
   
   private var _messageVec:Vector.<String>;
   
   public function MessagerQuene()
   {
      super();
      this._messageVec = new Vector.<String>();
   }
   
   public function enquene(param1:String) : void
   {
      if(this._messageVec.length > 1)
      {
         if(param1 != this._messageVec[this._messageVec.length - 1])
         {
            this._messageVec.push(param1);
         }
      }
      else
      {
         this._messageVec.push(param1);
      }
   }
   
   public function dequeue() : String
   {
      if(this._messageVec.length > 0)
      {
         return this._messageVec.shift();
      }
      return null;
   }
   
   public function get length() : int
   {
      return this._messageVec.length;
   }
}
