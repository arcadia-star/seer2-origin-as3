package com.taomee.seer2.app.controller
{
   import com.adobe.crypto.MD5;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.events.UserInfoEvent;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.inventory.ItemDescription;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class MolecularPasswordController
   {
      
      private static var _passwordView:PasswordView;
      
      private static var _password:String;
       
      
      public function MolecularPasswordController()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapDispose);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapComplete);
      }
      
      private static function onMapDispose(param1:SceneEvent) : void
      {
         if(SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.active.mapModel.id == 30)
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,onCustomUnitClick);
         }
      }
      
      private static function onMapComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.active.mapModel.id == 30)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,onCustomUnitClick);
         }
      }
      
      private static function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(evt.content.params == "molecularPassword")
         {
            if(_passwordView == null)
            {
               _passwordView = new PasswordView();
            }
            _passwordView.clear();
            DialogPanel.showForSimple(301,"分子密码大使",[[4,"对了，不同的分子密码兑换的奖品可能不同哦！"]],"再见！",null,_passwordView);
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_229);
         }
         else if(evt.content.params == "swapZuan")
         {
            ItemManager.requestItemList(function():void
            {
               var c:uint = uint(ItemManager.getItemQuantityByReferenceId(401155));
               if(c > 0)
               {
                  NpcDialog.show(301,"分子密码大使",[[4,"如果你有星钻兑换券，可以给我哦，1张券换1个星钻！你有<font color=\'#ff0000\'>" + c.toString() + "</font>张呢  "]],["我要兑换","我舍不得啊"],[function():void
                  {
                     SwapManager.swapItem(3812,1,function(param1:IDataInput):void
                     {
                        new SwapInfo(param1);
                     });
                  },null]);
               }
               else
               {
                  NpcDialog.show(301,"分子密码大使",[[4,"没有星钻兑换券哦~"]],["再见"],[null,null]);
               }
            });
         }
      }
      
      public static function query(param1:String) : void
      {
         _password = param1;
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUTFBytes(_password);
         _loc2_.length = 32;
         Connection.addErrorHandler(CommandSet.MAGIC_NUM_QUERY_1067,onPasswordFail);
         Connection.addCommandListener(CommandSet.MAGIC_NUM_QUERY_1067,onQuerySuccess);
         Connection.send(CommandSet.MAGIC_NUM_QUERY_1067,_loc2_);
      }
      
      private static function onQuerySuccess(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.MAGIC_NUM_QUERY_1067,onPasswordFail);
         Connection.removeErrorHandler(CommandSet.MAGIC_NUM_QUERY_1067,onQuerySuccess);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedShort());
         var _loc4_:int = int(_loc2_.readUnsignedShort());
         var _loc5_:Vector.<ItemDescription> = new Vector.<ItemDescription>();
         var _loc6_:int = int(_loc2_.readUnsignedInt());
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_.push(new ItemDescription(_loc2_.readUnsignedInt(),_loc2_.readUnsignedShort()));
            _loc7_++;
         }
         ModuleManager.showModule(URLUtil.getAppModule("FenziPasswordPanel"),"加载面板。。。",{
            "password":_password,
            "itemDesVec":_loc5_
         });
      }
      
      public static function receive(param1:int, param2:String, param3:Array) : void
      {
         var _loc4_:LittleEndianByteArray;
         (_loc4_ = new LittleEndianByteArray()).writeUTFBytes(param2);
         _loc4_.length = 32;
         _loc4_.position = 32;
         _loc4_.writeUnsignedInt(param1);
         var _loc5_:int = int(param3.length);
         _loc4_.writeUnsignedInt(_loc5_);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_.writeUnsignedInt(param3[_loc6_][0]);
            _loc4_.writeShort(param3[_loc6_][1]);
            _loc6_++;
         }
         Connection.addErrorHandler(CommandSet.MAGIC_NUM_USE_1068,onPasswordFail);
         Connection.addCommandListener(CommandSet.MAGIC_NUM_USE_1068,onUseSuccess);
         Connection.send(CommandSet.MAGIC_NUM_USE_1068,_loc4_);
      }
      
      private static function onUseSuccess(param1:MessageEvent) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         Connection.removeErrorHandler(CommandSet.MAGIC_NUM_USE_1068,onPasswordFail);
         Connection.removeCommandListener(CommandSet.MAGIC_NUM_USE_1068,onUseSuccess);
         var _loc2_:LittleEndianByteArray = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int;
         var _loc5_:* = (_loc4_ = int(_loc2_.readUnsignedByte())) == 0;
         var _loc6_:Vector.<ItemDescription> = new Vector.<ItemDescription>();
         var _loc7_:int = int(_loc2_.readUnsignedInt());
         var _loc10_:int = 0;
         while(_loc10_ < _loc7_)
         {
            _loc8_ = uint(_loc2_.readUnsignedInt());
            _loc9_ = uint(_loc2_.readUnsignedShort());
            _loc6_.push(new ItemDescription(_loc8_,_loc9_));
            if(_loc5_)
            {
               if(_loc8_ == 1)
               {
                  ActorManager.actorInfo.coins += _loc9_;
                  ActorManager.actorInfo.dispatchEvent(new UserInfoEvent(UserInfoEvent.UPDATE_COIN));
               }
            }
            _loc10_++;
         }
         if(_loc5_)
         {
            AlertManager.showItemListGaindeAlert(_loc6_);
            ItemManager.addItemList(_loc6_);
         }
         else
         {
            AlertManager.showAlert("你的背包不够放啦！");
         }
      }
      
      private static function miUpdateHandle(param1:Vector.<ItemDescription>) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].referenceId == 603848 && param1[_loc3_].quantity > 0)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            Connection.send(CommandSet.CLI_MONEY_COUNT_1253,getResult());
         }
      }
      
      private static function getResult() : LittleEndianByteArray
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc2_:String = String(MD5.hash("0"));
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.substr(_loc4_,2);
            _loc6_ = parseInt(_loc5_,16);
            _loc1_.writeByte(_loc6_);
            _loc4_ += 2;
         }
         return _loc1_;
      }
      
      private static function onPasswordFail(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.MAGIC_NUM_QUERY_1067,onPasswordFail);
         Connection.removeCommandListener(CommandSet.MAGIC_NUM_QUERY_1067,onQuerySuccess);
         Connection.removeCommandListener(CommandSet.MAGIC_NUM_USE_1068,onUseSuccess);
         var _loc2_:uint = uint(param1.message.statusCode);
         switch(_loc2_)
         {
            case 100001:
               AlertManager.showAlert("参数错误");
               break;
            case 100002:
               NpcDialog.show(301,"分子密码大使",[[4,"嗨，你别逗我了，这个分子密码不存在，我可不会被你唬住！"]],["再见！"]);
               break;
            case 100003:
               AlertManager.showAlert("分子密码过期啦！");
               break;
            case 100004:
               AlertManager.showAlert("分子密码未激活！");
               break;
            case 100005:
               AlertManager.showAlert("分子密码未绑定！");
               break;
            case 100006:
               AlertManager.showAlert("分子密码魔力被冻结！");
               break;
            case 100009:
               AlertManager.showAlert("该号段的兑换次数到达上限");
               break;
            case 100007:
               NpcDialog.show(301,"分子密码大使",[[4,"嘿嘿，小家伙，这个分子密码已经领过礼品喽！"]],["呵呵，我忘了，再见！"]);
         }
      }
   }
}

import com.taomee.seer2.app.controller.MolecularPasswordController;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.StringConstants;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import org.taomee.utils.StringUtil;

class PasswordView extends Sprite
{
    
   
   private var _mainUI:MovieClip;
   
   private var _passwordTxt:TextField;
   
   private var _confirmBtn:SimpleButton;
   
   public function PasswordView()
   {
      super();
      this._mainUI = UIManager.getMovieClip("UI_SeerMovieActivityUI");
      addChild(this._mainUI);
      this._passwordTxt = this._mainUI["passwordTxt"];
      this._passwordTxt.type = TextFieldType.INPUT;
      this._passwordTxt.restrict = "0-9a-zA-Z";
      this._confirmBtn = this._mainUI["confirmBtn"];
      this._passwordTxt.addEventListener(Event.CHANGE,this.onPasswordChange);
      this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onComfirmBtnClick);
   }
   
   private function onPasswordChange(param1:Event) : void
   {
      if(StringUtil.trim(this._passwordTxt.text) == StringConstants.EMPTY)
      {
         this._confirmBtn.visible = false;
      }
      else
      {
         this._confirmBtn.visible = true;
      }
   }
   
   private function onComfirmBtnClick(param1:MouseEvent) : void
   {
      DialogPanel.hide();
      var _loc2_:String = String(StringUtil.trim(this._passwordTxt.text));
      var _loc3_:int = _loc2_.length;
      if(_loc3_ == 12 || _loc3_ == 16 || _loc3_ == 24)
      {
         MolecularPasswordController.query(_loc2_);
      }
      else
      {
         NpcDialog.show(301,"分子密码大使",[[4,"嗨，你别逗我了，这个分子密码不存在，我可不会被你唬住！"]],["再见！"]);
      }
   }
   
   public function clear() : void
   {
      this._confirmBtn.visible = false;
      this._passwordTxt.text = "";
   }
}
