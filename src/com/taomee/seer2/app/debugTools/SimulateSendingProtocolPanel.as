package com.taomee.seer2.app.debugTools
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.Scroller;
   import com.taomee.seer2.app.config.ProtocolConfig;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.Command;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.core.map.grids.HashMap;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SimulateSendingProtocolPanel extends Sprite
   {
      
      public static var _instance:SimulateSendingProtocolPanel;
       
      
      private var _specialCmdMap:HashMap;
      
      private var _errorVector:Vector.<String>;
      
      private var _mainUI:MovieClip;
      
      private var _wheelObjMc:MovieClip;
      
      private var _scrollBar:Scroller;
      
      private var _sendBtn:SimpleButton;
      
      private var _clearBtn:SimpleButton;
      
      private var _protocolNumTxt:TextField;
      
      private var _parameterTxt:TextField;
      
      private var _formatTxt:TextField;
      
      private var _msgContentTxt:TextField;
      
      private var _curCommand:Command;
      
      private var _protocol:ProtocolInfo;
      
      public function SimulateSendingProtocolPanel(param1:InterClass)
      {
         super();
         if(_instance)
         {
            throw new Error("(地图、面板、协议)重复实例化");
         }
         this._mainUI = UIManager.getMovieClip("SimulateSendingProtocolUI");
         addChild(this._mainUI);
         this.initset();
         this.initEvent();
         this.initSpecialCommand();
         this._errorVector = new Vector.<String>();
      }
      
      public static function instance() : SimulateSendingProtocolPanel
      {
         if(_instance == null)
         {
            _instance = new SimulateSendingProtocolPanel(new InterClass());
         }
         return _instance;
      }
      
      private function initset() : void
      {
         this._sendBtn = this._mainUI["sendBtn"];
         this._clearBtn = this._mainUI["clearBtn"];
         this._wheelObjMc = this._mainUI["wheelObjMc"];
         this._protocolNumTxt = this._mainUI["protocolNumTxt"];
         this._protocolNumTxt.text = "";
         this._parameterTxt = this._mainUI["parameterTxt"];
         this._parameterTxt.text = "";
         this._formatTxt = this._mainUI["formatTxt"];
         this._formatTxt.text = "";
         this._msgContentTxt = this._mainUI["msgContentTxt"];
         this._msgContentTxt.text = "";
         this._msgContentTxt.mouseEnabled = this._msgContentTxt.mouseWheelEnabled = false;
         this._scrollBar = new Scroller(this._mainUI["scroll"]);
         this._scrollBar.x = 510;
         this._scrollBar.y = 3;
         this._scrollBar.pageSize = 10;
         this._scrollBar.maxScrollPosition = 10;
         this._scrollBar.wheelObject = this._wheelObjMc;
         this._mainUI.addChild(this._scrollBar);
      }
      
      private function initEvent() : void
      {
         this._sendBtn.addEventListener(MouseEvent.CLICK,this.onSendBtn);
         this._clearBtn.addEventListener(MouseEvent.CLICK,this.onClearBtn);
         this._scrollBar.addEventListener(Scroller.MOVE,this.onScrollerMove);
         this.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function onSendBtn(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         this._curCommand = Command.getCommand(uint(this._protocolNumTxt.text));
         if(this._curCommand)
         {
            this._protocol = ProtocolConfig.getProtocol(this._curCommand.id);
            _loc3_ = this._specialCmdMap.getValue(this._curCommand);
            if(_loc3_ != null)
            {
               _loc3_.handler(this._parameterTxt.text);
            }
            else if(this._protocol)
            {
               this.appendMsgText(this._protocol.toString());
               if(this._protocol.haveReturn)
               {
                  this.addCommandListenner(this._curCommand);
               }
               if(this._parameterTxt.text != "")
               {
                  _loc2_ = new Array();
                  this.parserParamArray(_loc2_,this._parameterTxt.text.split(","),this.cloneParametersVector(this._protocol.requestPack));
               }
            }
            else
            {
               this._errorVector.push("协议错误：协议不在配表中。");
            }
         }
         else
         {
            this.appendMsgText("\n不存在这条协议哦 ··· ···");
         }
      }
      
      private function onClearBtn(param1:MouseEvent) : void
      {
         this._msgContentTxt.text = "";
         this._scrollBar.maxScrollPosition = this._scrollBar.pageSize;
      }
      
      private function printData(param1:Array) : void
      {
         var _loc2_:* = undefined;
         this._msgContentTxt.appendText("\n" + this._curCommand.toString() + "\n");
         for each(_loc2_ in param1)
         {
            if(_loc2_ is Array)
            {
               this.printData(_loc2_);
            }
            else if(_loc2_ is String)
            {
               this._msgContentTxt.appendText(_loc2_ + ",");
            }
            else
            {
               this._msgContentTxt.appendText(_loc2_.toString() + ",");
            }
         }
      }
      
      private function cloneParametersVector(param1:Vector.<ParameterInfo>) : Vector.<ParameterInfo>
      {
         var _loc3_:ParameterInfo = null;
         var _loc4_:ParameterInfo = null;
         var _loc2_:Vector.<ParameterInfo> = new Vector.<ParameterInfo>();
         for each(_loc3_ in param1)
         {
            _loc4_ = new ParameterInfo(_loc3_.pid,_loc3_.name,_loc3_.type,_loc3_.isArray,_loc3_.length,_loc3_.fixedLength,_loc3_.description);
            if(_loc3_.type == "struct")
            {
               _loc4_.structList = this.cloneParametersVector(_loc3_.structList);
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      private function parserParamArray(param1:Array, param2:Array, param3:Vector.<ParameterInfo>) : void
      {
         var _loc5_:ParameterInfo = null;
         var _loc11_:Array = null;
         var _loc12_:LittleEndianByteArray = null;
         var _loc4_:String = "";
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = -1;
         while(param2.length > 0 && param3.length > 0)
         {
            _loc4_ = param2.shift();
            _loc5_ = param3.shift();
            if(_loc4_.charAt(0) == "[")
            {
               if(_loc5_.isArray)
               {
                  _loc8_ = true;
                  _loc4_ = _loc4_.slice(1);
               }
               else
               {
                  this._errorVector.push("错误：不是数组，存在多余中括号。");
               }
            }
            if(_loc8_)
            {
               _loc9_++;
            }
            _loc10_ = _loc4_.indexOf("]");
            if(-1 != _loc10_)
            {
               _loc8_ = false;
            }
            if(_loc4_.charAt(0) == "{")
            {
               _loc4_ = _loc4_.slice(1);
               if(_loc5_.type == "struct")
               {
                  _loc7_ = true;
               }
               else
               {
                  this._errorVector.push("错误：基本类型不需要花括号");
               }
            }
            if((_loc10_ = _loc4_.indexOf("}")) != -1)
            {
               _loc4_ = _loc4_.slice(0,_loc10_);
            }
            if(_loc5_.type == "struct")
            {
               if(_loc7_ = false)
               {
                  this._errorVector.push("错误：缺少结构体花括号。");
               }
               else
               {
                  _loc11_ = new Array();
                  param2.unshift(_loc4_);
                  this.parserParamArray(_loc11_,param2,_loc5_.structList);
                  param1.push(_loc11_);
               }
            }
            else
            {
               _loc12_ = new LittleEndianByteArray();
               this.writeTempData(_loc12_,_loc5_.type,_loc4_,_loc5_.fixedLength);
               param1.push(_loc12_);
               if(_loc8_)
               {
                  param3.unshift(_loc5_);
               }
               if(_loc8_ == false && _loc9_ > 0)
               {
                  param1.splice(param1.length - _loc9_,0,_loc9_);
                  _loc9_ = 0;
               }
            }
         }
      }
      
      private function writeTempData(param1:LittleEndianByteArray, param2:String, param3:String, param4:int = 0) : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param2 == "uint32")
         {
            param1.writeUnsignedInt(uint(param3));
         }
         else if(param2 == "uint16")
         {
            param1.writeShort(uint(param3));
         }
         else if(param2 == "uint8")
         {
            param1.writeByte(uint(param3));
         }
         else if(param2 == "char")
         {
            (_loc5_ = new ByteArray()).writeUTFBytes(param3);
            _loc6_ = int(_loc5_.length);
            if(param4 == 0)
            {
               param1.writeUnsignedInt(_loc6_);
               param1.writeBytes(_loc5_);
            }
            else
            {
               param1.writeBytes(_loc5_,0,param4);
               if(_loc6_ < param4)
               {
                  _loc7_ = 0;
                  _loc7_ = 0;
                  while(_loc7_ < param4 - _loc6_)
                  {
                     param1.writeByte(0);
                     _loc7_++;
                  }
               }
            }
         }
         else
         {
            this._errorVector.push("配表错误：参数类型异常");
         }
      }
      
      private function onScrollerMove(param1:Event) : void
      {
         this._msgContentTxt.scrollV = this._scrollBar.scrollPosition + 1;
         this._formatTxt.text = this._scrollBar.scrollPosition.toString();
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            param1.stopPropagation();
         }
      }
      
      private function appendMsgText(param1:String) : void
      {
         this._msgContentTxt.appendText(param1);
         this._scrollBar.maxScrollPosition = this._msgContentTxt.numLines;
         this._scrollBar.scrollPosition = this._msgContentTxt.numLines - this._scrollBar.pageSize;
         this._msgContentTxt.scrollV = this._msgContentTxt.numLines;
      }
      
      private function addCommandListenner(param1:Command) : void
      {
         Connection.addCommandListener(param1,this.rightMsgHandler);
         Connection.addErrorHandler(param1,this.errorMsgHandler);
      }
      
      private function sendCommand(param1:Command, param2:Array = null) : void
      {
         if(this._errorVector.length > 0)
         {
            this.appendMsgText("\n ============== 出错喽 ===============");
            while(this._errorVector.length > 0)
            {
               this.appendMsgText(this._errorVector.shift() + "\n");
            }
         }
         if(param2 == null)
         {
            Connection.send(param1);
         }
         else
         {
            Connection.send(param1,param2);
         }
      }
      
      private function parseReturnPackage(param1:Array, param2:IDataInput, param3:Vector.<ParameterInfo>) : void
      {
         var readData:Function;
         var tempStr:String = null;
         var tempParam:ParameterInfo = null;
         var outData:Array = param1;
         var data:IDataInput = param2;
         var paramInfoVec:Vector.<ParameterInfo> = param3;
         var i:int = 0;
         var elementsCount:int = 0;
         while(paramInfoVec.length > 0)
         {
            readData = function():void
            {
               var _loc1_:int = 0;
               var _loc2_:int = 0;
               tempStr = "【" + tempParam.name + "】：";
               if(tempParam.type == "struct")
               {
                  parseReturnPackage(outData,data,tempParam.structList);
               }
               else
               {
                  if(tempParam.type == "uint32")
                  {
                     tempStr += data.readUnsignedInt().toString();
                  }
                  else if(tempParam.type == "uint16")
                  {
                     tempStr += data.readUnsignedShort().toString();
                  }
                  else if(tempParam.type == "uint8")
                  {
                     tempStr += data.readUnsignedByte().toString();
                  }
                  else if(tempParam.type == "char")
                  {
                     if(tempParam.fixedLength > 0)
                     {
                        tempStr += data.readUTFBytes(tempParam.fixedLength);
                     }
                     else
                     {
                        _loc1_ = int(data.readUnsignedInt());
                        _loc2_ = 0;
                        _loc2_ = 0;
                        while(_loc2_ < _loc1_)
                        {
                           tempStr += data.readUTF();
                           _loc2_++;
                        }
                     }
                  }
                  outData.push(tempStr);
               }
            };
            tempStr = "";
            tempParam = paramInfoVec.shift();
            tempStr = "【" + tempParam.name + "】：";
            if(tempParam.isArray)
            {
               tempStr += " 数组";
               outData.push(tempStr);
            }
            if(tempParam.isArray)
            {
               elementsCount = int(data.readUnsignedInt());
               i = 0;
               while(i < elementsCount)
               {
                  readData();
                  i++;
               }
            }
            else
            {
               readData();
            }
         }
      }
      
      private function rightMsgHandler(param1:MessageEvent) : void
      {
         var _loc4_:String = null;
         Connection.removeCommandListener(this._curCommand,this.rightMsgHandler);
         Connection.removeErrorHandler(this._curCommand,this.errorMsgHandler);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         this.parseReturnPackage(_loc2_,param1.message.getRawData(),this.cloneParametersVector(this._protocol.returnPack));
         this.appendMsgText("\n" + this._curCommand.toString() + ":成功回包\n");
         for each(_loc4_ in _loc2_)
         {
            this.appendMsgText(_loc3_ + ":" + _loc4_ + "\n");
            _loc3_++;
         }
      }
      
      private function errorMsgHandler(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(this._curCommand,this.rightMsgHandler);
         Connection.removeErrorHandler(this._curCommand,this.errorMsgHandler);
         this.appendMsgText("\n" + this._curCommand.toString() + ":失败");
         this.appendMsgText("\n\t" + ErrorMap.findErrorMessage(param1.message.statusCode));
      }
      
      private function initSpecialCommand() : void
      {
         this._specialCmdMap = new HashMap();
         this._specialCmdMap.put(CommandSet.FIGHT_START_WILD_1500,{"handler":this.fightWithWildHandler});
         this._specialCmdMap.put(CommandSet.MI_BUY_ITEM_1224,{"handler":this.buyItemHandler});
      }
      
      private function fightWithWildHandler(param1:String) : void
      {
         if(isNaN(Number(param1)))
         {
            this._errorVector.push("错误：战斗id非法");
         }
         else
         {
            FightManager.startFightWithWild(uint(param1));
         }
      }
      
      private function buyItemHandler(param1:String) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BuyPropInfo = new BuyPropInfo();
         var _loc4_:Array;
         if((_loc4_ = param1.split(",")).length <= 0)
         {
            this._errorVector.push("参数错误：购买ID缺失。");
            return;
         }
         if(isNaN(_loc4_[0]))
         {
            this._errorVector.push("参数错误：购买ID非法。");
            return;
         }
         _loc2_ = uint(_loc4_[0]);
         _loc3_.itemId = _loc2_;
         if(isNaN(Number(_loc4_[1])) == false)
         {
            _loc3_.buyNum = uint(_loc4_[1]);
         }
         if(_loc2_ <= 500500 || _loc2_ > 800000)
         {
            ShopManager.buyBagItem(_loc3_);
         }
         else
         {
            ShopManager.buyVirtualItem(_loc3_);
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
