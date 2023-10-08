package com.taomee.seer2.core.ui
{
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class Proclaim extends Sprite
   {
      
      private static var _instance:com.taomee.seer2.core.ui.Proclaim;
       
      
      private var _isPlaying:Boolean;
      
      private var _textList:Array;
      
      private var _txt:TextField;
      
      private var _txtContainer:Sprite;
      
      private var _background:Sprite;
      
      public function Proclaim()
      {
         this._textList = [];
         this._txt = new TextField();
         this._txtContainer = new Sprite();
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this._background = UIManager.getSprite("UI_Announcement");
         addChild(this._background);
         this._txtContainer.scrollRect = new Rectangle(0,0,this._background.width - 30,30);
         this._txtContainer.x = 30;
         this._txtContainer.y = 2;
         addChild(this._txtContainer);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 65535;
         _loc1_.font = "_sans";
         _loc1_.size = 14;
         this._txt.defaultTextFormat = _loc1_;
         this._txt.autoSize = TextFieldAutoSize.LEFT;
         this._txtContainer.addChild(this._txt);
         this._txt.y = 2;
         x = (LayerManager.root.width - this._background.width) / 2;
         y = 70;
      }
      
      private static function get instance() : com.taomee.seer2.core.ui.Proclaim
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.core.ui.Proclaim();
         }
         return _instance;
      }
      
      public static function addText(param1:String) : void
      {
         instance.addText(param1);
      }
      
      public static function hasText(param1:String) : Boolean
      {
         return instance.hasText(param1);
      }
      
      public static function dispose() : void
      {
         if(_instance)
         {
            _instance.dispose();
            _instance = null;
         }
      }
      
      private static function openVipTurn(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("VipTurnCardPanel"),"正在打开面板...",{"currentTab":1});
      }
      
      private static function openVipPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"),"正在打开vip面板...",{"currentTab":1});
      }
      
      public function addText(param1:String) : void
      {
         this._textList.push(param1);
         if(LayerManager.topLayer.contains(this) == false)
         {
            LayerManager.topLayer.addChild(this);
         }
         if(this._isPlaying == false)
         {
            this.next();
            Tick.instance.addRender(this.onMove);
         }
      }
      
      public function hasText(param1:String) : Boolean
      {
         return this._textList.indexOf(param1) != -1;
      }
      
      private function next() : void
      {
         this._txt.text = this._textList.shift();
         if(this._txt.text.indexOf("开启幸运礼包获得了至尊资质果实") != -1)
         {
            this.mouseEnabled = true;
            this.buttonMode = true;
            this.addEventListener(MouseEvent.CLICK,openVipPanel);
            this._isPlaying = true;
            this._txt.x = this._background.width + 50;
            return;
         }
         this.mouseEnabled = false;
         this.buttonMode = false;
         this.removeEventListener(MouseEvent.CLICK,openVipPanel);
         if(this._txt.text.indexOf("在乐园金字塔中抽取了终极大奖") != -1)
         {
            this.mouseEnabled = true;
            this.buttonMode = true;
            this.addEventListener(MouseEvent.CLICK,this.openVipPyramid);
         }
         else
         {
            this.mouseEnabled = false;
            this.buttonMode = false;
            this.removeEventListener(MouseEvent.CLICK,this.openVipPyramid);
         }
         if(this._txt.text.indexOf("谁能驾驭摩托驰骋黑夜") != -1)
         {
            this.mouseEnabled = true;
            this.buttonMode = true;
            this.addEventListener(MouseEvent.CLICK,openVipTurn);
         }
         else
         {
            this.mouseEnabled = false;
            this.buttonMode = false;
            this.removeEventListener(MouseEvent.CLICK,openVipTurn);
         }
         this._isPlaying = true;
         this._txt.x = this._background.width + 50;
      }
      
      private function openVipPyramid(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("VipPyramidPanel"),"...");
      }
      
      private function onMove(param1:uint) : void
      {
         if(this._txt.x > -this._txt.width)
         {
            this._txt.x -= 0.05 * param1;
         }
         else if(this._textList.length > 0)
         {
            this.next();
         }
         else
         {
            this.clear();
         }
      }
      
      public function clear() : void
      {
         this._isPlaying = false;
         Tick.instance.removeRender(this.onMove);
         DisplayUtil.removeForParent(this);
      }
      
      public function dispose() : void
      {
         this.clear();
         this._textList = null;
         this._txt = null;
         this._txtContainer = null;
         this._background = null;
      }
   }
}
