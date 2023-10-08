package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.net.Command;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.FPS;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.log.LogArea;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class TestAssistPanel extends Sprite
   {
      
      private static var _instance:com.taomee.seer2.app.controls.TestAssistPanel = new com.taomee.seer2.app.controls.TestAssistPanel();
       
      
      private var _back:Shape;
      
      private var _mousePositiontxt:TextField;
      
      private var _mousePositionLabel:TextField;
      
      private var _serverTimeTxt:TextField;
      
      private var _switchMapLabel:TextField;
      
      private var _switchMapInput:TextField;
      
      private var _serverIdTxtLabel:TextField;
      
      private var _serverIdTxt:TextField;
      
      private var _serverContentTxtLabel:TextField;
      
      private var _serverContentTxt:TextField;
      
      private var _serverBitLabelTxt:TextField;
      
      private var _serverBitContentTxt:TextField;
      
      private var _serverSim:TextField;
      
      private var _fps:FPS;
      
      private var _isShow:Boolean = false;
      
      private var _txtFilter:GlowFilter;
      
      public function TestAssistPanel()
      {
         this._txtFilter = new GlowFilter(0,1,2,2,10,1);
         super();
         mouseEnabled = false;
         this.createChildren();
      }
      
      public static function show() : void
      {
         if(ClientConfig.isLocal)
         {
            _instance.y = 0;
            _instance.x = 276;
            LayerManager.topLayer.addChild(_instance);
         }
      }
      
      public static function hide() : void
      {
         DisplayUtil.removeForParent(_instance,false);
      }
      
      public static function updateTestAssist() : void
      {
         if(_instance.parent != null)
         {
            _instance.update(LayerManager.stage.mouseX,LayerManager.stage.mouseY);
         }
      }
      
      private function createChildren() : void
      {
         this._back = this.createBack();
         addChild(this._back);
         this._switchMapLabel = this.createTxt(TextFieldType.DYNAMIC,85,20);
         this._switchMapLabel.text = "跳转地图ID：";
         this._switchMapLabel.x = 2;
         this._switchMapLabel.y = 2;
         addChild(this._switchMapLabel);
         this._switchMapInput = this.createTxt(TextFieldType.INPUT,60,20);
         this._switchMapInput.border = true;
         this._switchMapInput.backgroundColor = 16777215;
         this._switchMapInput.mouseEnabled = true;
         this._switchMapInput.selectable = true;
         this._switchMapInput.x = 83;
         this._switchMapInput.y = 2;
         addChild(this._switchMapInput);
         this._mousePositionLabel = this.createTxt(TextFieldType.DYNAMIC,85,20);
         this._mousePositionLabel.text = "场景鼠标坐标：";
         this._mousePositionLabel.x = 2;
         this._mousePositionLabel.y = 24;
         addChild(this._mousePositionLabel);
         this._mousePositiontxt = this.createTxt(TextFieldType.DYNAMIC,80,20);
         this._mousePositiontxt.x = 83;
         this._mousePositiontxt.y = 24;
         addChild(this._mousePositiontxt);
         this._switchMapInput.addEventListener(KeyboardEvent.KEY_DOWN,this.onEnterKeyDown);
         this._serverTimeTxt = this.createTxt(TextFieldType.DYNAMIC,180,20);
         this._serverTimeTxt.x = 2;
         this._serverTimeTxt.y = 44;
         addChild(this._serverTimeTxt);
         this._serverIdTxtLabel = this.createTxt(TextFieldType.INPUT,70,20,65280);
         this._serverIdTxtLabel.text = "协议号";
         this._serverIdTxtLabel.x = 2;
         this._serverIdTxtLabel.y = 86;
         addChild(this._serverIdTxtLabel);
         this._serverContentTxtLabel = this.createTxt(TextFieldType.INPUT,110,20,65280);
         this._serverContentTxtLabel.text = "协议数据,逗号分割";
         this._serverContentTxtLabel.x = 2;
         this._serverContentTxtLabel.y = 107;
         addChild(this._serverContentTxtLabel);
         this._serverBitLabelTxt = this.createTxt(TextFieldType.INPUT,180,40,65280);
         this._serverBitLabelTxt.text = "数据对应位数，32、16、8位,\n不填的话，默认32位，逗号分割";
         this._serverBitLabelTxt.x = 2;
         this._serverBitLabelTxt.y = 128;
         addChild(this._serverBitLabelTxt);
         this._serverIdTxt = this.createTxt(TextFieldType.INPUT,40,20,65280);
         this._serverIdTxt.border = true;
         this._serverIdTxt.backgroundColor = 16777215;
         this._serverIdTxt.mouseEnabled = true;
         this._serverIdTxt.selectable = true;
         this._serverIdTxt.x = 180;
         this._serverIdTxt.y = 86;
         addChild(this._serverIdTxt);
         this._serverContentTxt = this.createTxt(TextFieldType.INPUT,250,20,65280);
         this._serverContentTxt.border = true;
         this._serverContentTxt.backgroundColor = 16777215;
         this._serverContentTxt.mouseEnabled = true;
         this._serverContentTxt.selectable = true;
         this._serverContentTxt.x = 180;
         this._serverContentTxt.y = 107;
         addChild(this._serverContentTxt);
         this._serverBitContentTxt = this.createTxt(TextFieldType.INPUT,250,20,65280);
         this._serverBitContentTxt.border = true;
         this._serverBitContentTxt.backgroundColor = 16777215;
         this._serverBitContentTxt.mouseEnabled = true;
         this._serverBitContentTxt.selectable = true;
         this._serverBitContentTxt.x = 180;
         this._serverBitContentTxt.y = 128;
         addChild(this._serverBitContentTxt);
         this._serverSim = this.createTxt(TextFieldType.DYNAMIC,60,20,65280);
         this._serverSim.x = 2;
         this._serverSim.y = 64;
         this._serverSim.mouseEnabled = true;
         this._serverSim.text = "发送协议";
         addChild(this._serverSim);
         this._serverSim.addEventListener(MouseEvent.CLICK,this.onShowServer);
         this._serverIdTxt.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._serverContentTxt.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._serverBitContentTxt.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._serverIdTxtLabel.visible = false;
         this._serverIdTxt.visible = false;
         this._serverContentTxtLabel.visible = false;
         this._serverContentTxt.visible = false;
         this._serverBitLabelTxt.visible = false;
         this._serverBitContentTxt.visible = false;
      }
      
      private function onShowServer(param1:MouseEvent) : void
      {
         if(this._isShow == false)
         {
            this._serverIdTxtLabel.visible = true;
            this._serverIdTxt.visible = true;
            this._serverContentTxtLabel.visible = true;
            this._serverContentTxt.visible = true;
            this._serverBitLabelTxt.visible = true;
            this._serverBitContentTxt.visible = true;
            this._isShow = true;
         }
         else
         {
            this._serverIdTxtLabel.visible = false;
            this._serverIdTxt.visible = false;
            this._serverContentTxtLabel.visible = false;
            this._serverContentTxt.visible = false;
            this._serverBitLabelTxt.visible = false;
            this._serverBitContentTxt.visible = false;
            this._isShow = false;
         }
      }
      
      private function createBack() : Shape
      {
         var _loc1_:Shape = new Shape();
         var _loc2_:Graphics = _loc1_.graphics;
         _loc2_.beginFill(13421772,0.2);
         _loc2_.drawRect(0,0,150,44);
         _loc2_.endFill();
         return _loc1_;
      }
      
      private function createTxt(param1:String, param2:int, param3:int, param4:uint = 16777215) : TextField
      {
         var _loc5_:TextFormat;
         (_loc5_ = new TextFormat()).font = "_sans";
         var _loc6_:TextField;
         (_loc6_ = new TextField()).type = param1;
         _loc6_.textColor = param4;
         _loc6_.selectable = false;
         _loc6_.mouseEnabled = false;
         _loc6_.width = param2;
         _loc6_.height = param3;
         _loc6_.defaultTextFormat = _loc5_;
         _loc6_.filters = [this._txtFilter];
         return _loc6_;
      }
      
      public function update(param1:int, param2:int) : void
      {
         this._mousePositiontxt.text = "X:" + param1 + " Y:" + param2;
         this._serverTimeTxt.text = "时间:" + DateUtil.formatCalendarWithYearMonthDay(TimeManager.getServerTime()) + " " + DateUtil.formatCalendarWithWeekHourMinuteSecond(TimeManager.getServerTime());
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:LittleEndianByteArray = null;
         var _loc5_:int = 0;
         if(param1.keyCode == Keyboard.ENTER)
         {
            _loc2_ = this._serverContentTxt.text.split(",");
            _loc3_ = this._serverBitContentTxt.text.split(",");
            if(this._serverIdTxt.text == "")
            {
               AlertManager.showAlert("协议ID不能写空哦");
               return;
            }
            if(Command.getCommand(uint(this._serverIdTxt.text)) == null)
            {
               AlertManager.showAlert("木有该条协议");
               return;
            }
            if(_loc3_.length == 1)
            {
               if(_loc3_[0] == "")
               {
                  _loc3_.splice(0,1);
               }
            }
            else if(_loc2_.length > 0 && _loc3_.length > 0)
            {
               if(_loc2_.length != _loc3_.length)
               {
                  AlertManager.showAlert("协议数据和对应的位数量不统一,逗号分开,如果都是32位,对应位数就不填");
                  return;
               }
            }
            if(uint(this._serverIdTxt.text) == 1055)
            {
               Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.on1055);
            }
            if(this._serverIdTxt.text.slice(0,5) == "fight")
            {
               FightManager.startFightWithWild(uint(this._serverIdTxt.text.slice(5)));
               return;
            }
            if(this._serverContentTxt.text != "")
            {
               _loc4_ = new LittleEndianByteArray();
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  this.udpateByte(_loc4_,String(_loc2_[_loc5_]));
                  _loc5_++;
               }
               Connection.send(Command.getCommand(uint(this._serverIdTxt.text)),_loc4_);
            }
            else
            {
               Connection.send(Command.getCommand(uint(this._serverIdTxt.text)));
            }
         }
      }
      
      private function on1055(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.on1055);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         new SwapInfo(_loc2_);
      }
      
      private function udpateByte(param1:LittleEndianByteArray, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param2.charAt(0) == "(")
         {
            _loc3_ = param2.slice(1,param2.length - 1);
            _loc4_ = _loc3_.split("|");
            param1.writeUnsignedInt(_loc4_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               param1.writeUnsignedInt(uint(_loc4_[0]));
               _loc5_++;
            }
         }
         else
         {
            param1.writeUnsignedInt(uint(param2));
         }
      }
      
      private function onEnterKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:uint = 0;
         if(this._switchMapInput.text != "")
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               if(this._switchMapInput.text.toLowerCase() == "log")
               {
                  if(!LayerManager.topLayer.contains(LogArea.getInstance()))
                  {
                     LayerManager.topLayer.addChild(LogArea.getInstance());
                  }
                  else
                  {
                     DisplayObjectUtil.removeFromParent(LogArea.getInstance());
                  }
               }
               else
               {
                  _loc2_ = uint(this._switchMapInput.text);
                  if(_loc2_ > 80000)
                  {
                     SceneManager.changeScene(SceneType.COPY,_loc2_);
                  }
                  else
                  {
                     SceneManager.changeScene(SceneType.LOBBY,_loc2_);
                  }
               }
            }
         }
      }
   }
}
